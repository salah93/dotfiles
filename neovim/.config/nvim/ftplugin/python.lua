local colorcolumn = {"90"}
for i = 400, 999 do
    table.insert(colorcolumn, tostring(i))
end
vim.opt_local.colorcolumn = table.concat(colorcolumn, ",")
