local M = {}

-- Function to get file paths from quickfix list
function M.get_quickfix_files()
	local qf_items = vim.fn.getqflist()
	local files = {}
	local seen = {}

	-- Extract unique file paths from quickfix list
	for _, item in ipairs(qf_items) do
		local bufnr = item.bufnr
		if bufnr > 0 then
			local file_path = vim.api.nvim_buf_get_name(bufnr)
			if file_path and file_path ~= "" and not seen[file_path] then
				seen[file_path] = true
				table.insert(files, file_path)
			end
		end
	end

	return files
end

-- Function to escape a path for shell quoting
function M.escape_path(path)
	-- Replace any single quotes with quote-escape-quote
	path = path:gsub("'", "'\\''")
	-- Wrap the whole path in single quotes to handle spaces and other special chars
	return "'" .. path .. "'"
end

-- Function to handle glob special characters - FIX: Always apply this escaping
function M.escape_glob_chars(path)
	-- Escape the glob pattern characters needed by code2prompt
	path = path:gsub("%[", "\\[")
	path = path:gsub("%]", "\\]")
	path = path:gsub("%*", "\\*")
	path = path:gsub("%?", "\\?")
	path = path:gsub("%{", "\\{")
	path = path:gsub("%}", "\\}")
	path = path:gsub("%!", "\\!")
	return path
end

-- Function to convert absolute path to relative path based on cwd
function M.to_relative_path(abs_path)
	local cwd = vim.fn.getcwd()
	-- Check if the path starts with cwd
	if abs_path:sub(1, #cwd) == cwd then
		-- Get the relative path by removing cwd and leading slash
		local rel_path = abs_path:sub(#cwd + 2)
		return rel_path
	else
		-- If not in cwd, return the original path
		return abs_path
	end
end

-- Function to run code2prompt with the quickfix files
function M.run_code2prompt(opts)
	local files = M.get_quickfix_files()

	if #files == 0 then
		vim.notify("No files found in quickfix list", vim.log.levels.WARN)
		return
	end

	-- Build the command - starting with just the base command
	local cmd = { "code2prompt" }

	-- Add additional options if provided
	if opts.template then
		table.insert(cmd, "-t")
		table.insert(cmd, opts.template)
	end

	if opts.tokens then
		table.insert(cmd, "--tokens")
		if type(opts.tokens) == "string" then
			table.insert(cmd, opts.tokens)
		end
	end

	if opts.encoding then
		table.insert(cmd, "--encoding=" .. opts.encoding)
	end

	if opts.output_file then
		table.insert(cmd, "--output-file=" .. opts.output_file)
	end

	if opts.line_numbers then
		table.insert(cmd, "--line-number")
	end

	if opts.no_codeblock then
		table.insert(cmd, "--no-codeblock")
	end

	if opts.json then
		table.insert(cmd, "--json")
	end

	if opts.full_directory_tree then
		table.insert(cmd, "--full-directory-tree")
	end

	-- Create a comma-separated list of relative file paths with proper escaping
	local escaped_files = {}
	for _, file in ipairs(files) do
		local rel_path = M.to_relative_path(file)
		-- FIXED: Always apply glob escaping before shell escaping
		local glob_escaped = M.escape_glob_chars(rel_path)
		-- Then do shell escaping for the command line
		table.insert(escaped_files, M.escape_path(glob_escaped))
	end
	local file_list = table.concat(escaped_files, ",")

	-- Add the relative file paths as include parameter
	table.insert(cmd, "--include=" .. file_list)

	-- Now add the current directory as the base path for code2prompt
	local cwd = vim.fn.getcwd()
	table.insert(cmd, cwd)

	-- For debugging
	local cmdstr = table.concat(cmd, " ")
	vim.notify("Running command: " .. cmdstr, vim.log.levels.INFO)

	-- Run the command
	vim.notify("Running code2prompt with " .. #files .. " files from quickfix list", vim.log.levels.INFO)

	local job_id = vim.fn.jobstart(cmdstr, {
		on_stdout = function(_, data)
			if data and #data > 0 then
				vim.schedule(function()
					for _, line in ipairs(data) do
						if line and line ~= "" then
							print(line)
						end
					end
				end)
			end
		end,
		on_stderr = function(_, data)
			if data and #data > 0 then
				vim.schedule(function()
					for _, line in ipairs(data) do
						if line and line ~= "" then
							vim.notify(line, vim.log.levels.ERROR)
						end
					end
				end)
			end
		end,
		on_exit = function(_, exit_code)
			if exit_code == 0 then
				vim.schedule(function()
					vim.notify("code2prompt completed successfully!", vim.log.levels.INFO)
				end)
			else
				vim.schedule(function()
					vim.notify("code2prompt failed with exit code: " .. exit_code, vim.log.levels.ERROR)
				end)
			end
		end,
		stdout_buffered = true,
		stderr_buffered = true,
	})

	if job_id <= 0 then
		vim.notify("Failed to start code2prompt job", vim.log.levels.ERROR)
	end
end

-- Debug function to show the constructed command
function M.debug_command(opts)
	local files = M.get_quickfix_files()

	if #files == 0 then
		vim.notify("No files found in quickfix list", vim.log.levels.WARN)
		return
	end

	-- Build the command
	local cmd = { "code2prompt" }

	-- Add additional options if provided
	if opts.template then
		table.insert(cmd, "-t")
		table.insert(cmd, opts.template)
	end

	if opts.tokens then
		table.insert(cmd, "--tokens")
		if type(opts.tokens) == "string" then
			table.insert(cmd, opts.tokens)
		end
	end

	if opts.encoding then
		table.insert(cmd, "--encoding=" .. opts.encoding)
	end

	if opts.output_file then
		table.insert(cmd, "--output-file=" .. opts.output_file)
	end

	if opts.line_numbers then
		table.insert(cmd, "--line-number")
	end

	if opts.no_codeblock then
		table.insert(cmd, "--no-codeblock")
	end

	if opts.json then
		table.insert(cmd, "--json")
	end

	if opts.full_directory_tree then
		table.insert(cmd, "--full-directory-tree")
	end

	-- Create a comma-separated list of relative file paths with proper escaping
	local escaped_files = {}
	for _, file in ipairs(files) do
		local rel_path = M.to_relative_path(file)
		-- FIXED: Always apply glob escaping before shell escaping
		local glob_escaped = M.escape_glob_chars(rel_path)
		-- Then do shell escaping for the command line
		table.insert(escaped_files, M.escape_path(glob_escaped))
	end
	local file_list = table.concat(escaped_files, ",")

	-- Add the relative file paths as include parameter
	table.insert(cmd, "--include=" .. file_list)

	-- Add the current directory as the base path
	local cwd = vim.fn.getcwd()
	table.insert(cmd, cwd)

	-- Print the command for debugging - as a string, not a table
	local cmdstr = table.concat(cmd, " ")
	vim.notify("Command: " .. cmdstr, vim.log.levels.INFO)
end

-- Setup function to register commands
function M.setup(opts)
	opts = opts or {}

	-- Register the main command
	vim.api.nvim_create_user_command("Code2PromptQF", function(cmd_opts)
		local run_opts = vim.deepcopy(opts)

		-- Parse command arguments if any
		if cmd_opts.args and cmd_opts.args ~= "" then
			local args = vim.split(cmd_opts.args, " ")
			for _, arg in ipairs(args) do
				if arg:match("^%-t=") or arg:match("^%-%-template=") then
					run_opts.template = arg:match("^%-t=(.+)") or arg:match("^%-%-template=(.+)")
				elseif arg:match("^%-%-tokens=(.+)") then
					run_opts.tokens = arg:match("^%-%-tokens=(.+)")
				elseif arg:match("^%-%-tokens$") then
					run_opts.tokens = true
				elseif arg:match("^%-%-encoding=") then
					run_opts.encoding = arg:match("^%-%-encoding=(.+)")
				elseif arg:match("^%-%-output%-file=") then
					run_opts.output_file = arg:match("^%-%-output%-file=(.+)")
				elseif arg:match("^%-%-line%-number") then
					run_opts.line_numbers = true
				elseif arg:match("^%-%-no%-codeblock") then
					run_opts.no_codeblock = true
				elseif arg:match("^%-%-json") then
					run_opts.json = true
				elseif arg:match("^%-%-full%-directory%-tree") then
					run_opts.full_directory_tree = true
				end
			end
		end

		M.run_code2prompt(run_opts)
	end, {
		nargs = "*",
		desc = "Run code2prompt with files from quickfix list as include patterns",
		complete = function(arg_lead, _, _)
			local completions = {
				"--template=",
				"--tokens",
				"--encoding=",
				"--output-file=",
				"--line-number",
				"--no-codeblock",
				"--json",
				"--full-directory-tree",
			}

			return vim.tbl_filter(function(item)
				return item:match("^" .. arg_lead)
			end, completions)
		end,
	})

	-- Debug command to show the constructed command
	vim.api.nvim_create_user_command("Code2PromptQFDebug", function(cmd_opts)
		local run_opts = vim.deepcopy(opts)

		-- Parse command arguments if any
		if cmd_opts.args and cmd_opts.args ~= "" then
			local args = vim.split(cmd_opts.args, " ")
			for _, arg in ipairs(args) do
				if arg:match("^%-t=") or arg:match("^%-%-template=") then
					run_opts.template = arg:match("^%-t=(.+)") or arg:match("^%-%-template=(.+)")
				elseif arg:match("^%-%-tokens=(.+)") then
					run_opts.tokens = arg:match("^%-%-tokens=(.+)")
				elseif arg:match("^%-%-tokens$") then
					run_opts.tokens = true
				elseif arg:match("^%-%-encoding=") then
					run_opts.encoding = arg:match("^%-%-encoding=(.+)")
				elseif arg:match("^%-%-output%-file=") then
					run_opts.output_file = arg:match("^%-%-output%-file=(.+)")
				elseif arg:match("^%-%-line%-number") then
					run_opts.line_numbers = true
				elseif arg:match("^%-%-no%-codeblock") then
					run_opts.no_codeblock = true
				elseif arg:match("^%-%-json") then
					run_opts.json = true
				elseif arg:match("^%-%-full%-directory%-tree") then
					run_opts.full_directory_tree = true
				end
			end
		end

		M.debug_command(run_opts)
	end, {
		nargs = "*",
		desc = "Debug code2prompt command construction",
	})

	-- Set up keymappings if provided
	if opts.mappings then
		for mode, mapping_table in pairs(opts.mappings) do
			for key, command in pairs(mapping_table) do
				vim.keymap.set(mode, key, command, { noremap = true, silent = true })
			end
		end
	end
end

-- This line makes the module available for require(), but doesn't stop execution
_G.c2p = M

-- Setup configuration (this code will execute when the file is loaded)
M.setup({
	-- Default options
	tokens = false, -- Show token count by default
	encoding = "cl100k", -- Default tokenizer (for ChatGPT models)
	full_directory_tree = true, -- Enable by default

	-- Key mappings for quick access
	mappings = {
		n = {
			-- Normal mode mappings
			["<leader>cp"] = ":Code2PromptQF<CR>",
			["<leader>cpd"] = ":Code2PromptQF --template=templates/document-the-code.hbs<CR>",
			["<leader>cps"] = ":Code2PromptQF --template=templates/find-security-vulnerabilities.hbs<CR>",
			["<leader>cpf"] = ":Code2PromptQF --template=templates/fix-bugs.hbs<CR>",
			["<leader>cpt"] = ":Code2PromptQF --full-directory-tree<CR>",
		},
	},
})

-- Create commands for specific templates
vim.api.nvim_create_user_command(
	"C2PDoc",
	"Code2PromptQF --template=templates/document-the-code.hbs",
	{ desc = "Generate documentation prompt from quickfix files" }
)

vim.api.nvim_create_user_command(
	"C2PSecurity",
	"Code2PromptQF --template=templates/find-security-vulnerabilities.hbs",
	{ desc = "Generate security analysis prompt from quickfix files" }
)

vim.api.nvim_create_user_command(
	"C2PFix",
	"Code2PromptQF --template=templates/fix-bugs.hbs",
	{ desc = "Generate bug fixing prompt from quickfix files" }
)

vim.api.nvim_create_user_command(
	"C2PTree",
	"Code2PromptQF --full-directory-tree",
	{ desc = "Generate prompt with full directory tree" }
)

-- Return the module (needed for require to work)
return M
