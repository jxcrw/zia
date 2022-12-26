local confd = os.getenv("Path")
-- print(confd)

-- Opens a file in append mode
file = io.open("test.lua", "a")

-- sets the default output file as test.lua
io.output(file)

-- appends a word test to the last line of the file
io.write(confd)

-- closes the open file
io.close(file)

vim.cmd [[
new
setlocal buftype=nofile bufhidden=hide noswapfile nobuflisted
let evars = environ()
" let file = 'C:/~/.sel/nvim/vars.txt'
for var in evars->keys()->sort()
    " echo var . '=' . evars[var]
    put=var . '=' . evars[var]
endfor
]]
