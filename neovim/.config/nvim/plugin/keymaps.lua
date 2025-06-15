
-- Key mappings
-- Disable highlight when <leader><cr> is pressed
vim.keymap.set("n", "<leader>c", ":noh<cr>", { silent = true })

-- Tab movement keys
vim.keymap.set("", "<leader>[", "<esc>:tabprevious<CR>")
vim.keymap.set("", "<leader>]", "<esc>:tabnext<CR>")
vim.keymap.set("", "<leader>bn", ":bnext<cr>")
vim.keymap.set("", "<leader>bp", ":bprevious<cr>")

-- Location list navigation
vim.keymap.set("n", "<leader>l", ":lnext<CR>")
vim.keymap.set("n", "<leader>k", ":lprevious<CR>")
vim.keymap.set("n", "<leader>r", ":lrewind<CR>")

-- Fast saving
vim.keymap.set("n", "<leader>w", ":w<cr>")

-- :W sudo saves the file
vim.api.nvim_create_user_command("W", "w !sudo tee % > /dev/null", {})

-- Visual mode related functions
vim.cmd([[
  function! VisualSelection() range
    let l:saved_reg = @"
    execute "normal! vgvy"
    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")
    let @/ = l:pattern
    let @" = l:saved_reg
  endfunction
]])

vim.keymap.set("v", "*", ":<C-u>call VisualSelection()<CR>/<C-R>=@/<CR><CR>", { silent = true })
vim.keymap.set("v", "#", ":<C-u>call VisualSelection()<CR>?<C-R>=@/<CR><CR>", { silent = true })
vim.keymap.set("", ",*", "*<C-O>:%s///gn<CR>")

-- diagnostics
vim.diagnostic.config({
  virtual_text = true,    -- Show virtual text
  signs = true,           -- Show signs in gutter
  underline = true,       -- Underline problematic text
  update_in_insert = false, -- Don't update while typing
  severity_sort = true,   -- Sort by severity
})
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setqflist, { desc = 'Diagnostics to quickfix' })
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Diagnostics to location list' })

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
