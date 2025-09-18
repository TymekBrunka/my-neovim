local Path = require('plenary.path')

vim.keymap.set("", "<C-e>", function()
    vim.cmd(":wa")
    -- vim.cmd([[!cd build && cmake .. -DCMAKE_BUILD_TYPE=debug -DCMAKE_EXPORT_COMPILE_COMMANDS=1 && cmake .. && cmake --build . <CR>]])

    print(Path:new(vim.fn.getcwd()):joinpath("build"):expand())

    vim.fn.jobstart( 'cmake .. -DCMAKE_BUILD_TYPE=debug -DCMAKE_EXPORT_COMPILE_COMMANDS=1',
    { cwd = Path:new(vim.fn.getcwd()):joinpath("build"):expand(), })

    vim.fn.jobstart( 'cmake --build .',
    { cwd = Path:new(vim.fn.getcwd()):joinpath("build"):expand(), })
end)
