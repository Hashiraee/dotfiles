-- Map :W to :w
vim.api.nvim_create_user_command("W", ":w", {})

-- Map :Q to :q
vim.api.nvim_create_user_command("Q", ":q", {})

-- Map :WQ to :wq
vim.api.nvim_create_user_command("WQ", ":wq", {})

-- Map :Wq to :wq
vim.api.nvim_create_user_command("Wq", ":wq", {})
