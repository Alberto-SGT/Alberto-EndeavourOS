return {
  -- Tema Catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({ flavour = "mocha" })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  -- Árbol de archivos
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "File Tree" },
    },
    config = function()
      require("nvim-tree").setup()
    end,
  },
  -- Buscador
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
    },
  },
  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
  -- Indent lines
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup()
    end,
  },
  -- Terraform
  { "hashivim/vim-terraform" },
  -- Ansible
  { "pearofducks/ansible-vim" },
  -- Lazygit
  {
    "kdheepak/lazygit.nvim",
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    keys = {
      { "<C-t>", "<cmd>ToggleTerm<cr>", desc = "Terminal" },
    },
  },
}
