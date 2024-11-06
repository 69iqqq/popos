-- my_go_module.lua

local M = {}

-- Function to compile and run the Go program
function M.compile_and_run_go()
    vim.cmd("w") -- Save the current file

    -- Get the file path, file name, and file extension
    local filepath = vim.fn.expand("%:p")
    local filename = vim.fn.expand("%:t:r") -- Get the file name without extension
    local fileext = vim.fn.expand("%:e")
    local dirpath = vim.fn.expand("%:p:h") -- Get the directory of the current file

    -- Debug: Print file details
    print("File Path: " .. filepath)
    print("File Name: " .. filename)
    print("File Extension: " .. fileext)
    print("Directory Path: " .. dirpath)

    -- Check if it's a Go file and go.mod is missing, then initialize Go module
    if fileext == "go" then
        -- Change to the directory of the current file
        vim.fn.chdir(dirpath)

        if vim.fn.filereadable("go.mod") == 0 then
            -- Run 'go mod init' with the file's directory as the module name
            local modname = vim.fn.fnamemodify(dirpath, ":t")
            vim.cmd("!go mod init " .. modname)
            print("Initialized Go module: " .. modname)
        end

        -- Specify the output file name with -o flag
        local build_command = "!go build -o " .. filename .. " " .. filepath
        vim.cmd(build_command) -- Compile the Go file

        -- Check if there was an error during compilation
        if vim.v.shell_error == 0 then
            -- Close the quickfix window if it is open
            vim.cmd("cclose")
            -- Open a new terminal window and run the compiled Go program
            local run_command = "belowright split | terminal ./" .. filename
            vim.cmd(run_command)
        else
            -- Open the quickfix window to display compilation errors
            vim.cmd("copen")
            -- Map Enter to close the quickfix window
            vim.api.nvim_buf_set_keymap(0, "n", "<CR>", ":cclose<CR>", { noremap = true, silent = true })
        end
    else
        print("Not a Go file: " .. filepath)
    end
end

-- Set the keybind to compile and run the Go program
vim.keymap.set("n", "<leader>d", M.compile_and_run_go, { desc = "Compile and run Go program" })

return M
