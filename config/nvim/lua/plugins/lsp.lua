return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "pyright",
        "bash-language-server",
        "gopls",
        "yaml-language-server",
        "terraform-ls",
        "lua-language-server",
      },
    },
  },
}
