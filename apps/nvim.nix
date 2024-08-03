{ pkgs }:
{
  enable = true;
  defaultEditor = true;
  opts = {
    updatetime = 100;

    # Display
    relativenumber = true;
    number = true;
    wrap = false;

    # Tabs
    tabstop = 2;
    shiftwidth = 2;
    expandtab = true;
    autoindent = true;

    foldlevel = 999;
  };
  keymaps = [
    {
      action = ":lua vim.lsp.buf.hover()";
      key = "<C-h>";
      mode = ["n" "i"];
      options.silent = true;
    }
    {
      action = ":Neotree position=left toggle reveal<CR>";
      key = "<C-\\>";
      mode = "n";
      options.silent = true;
    }
    {
      action = ":BufferLineCycleNext<CR>";
      key = "<C-]>";
      mode = "n";
      options.silent = true;
    }
    {
      action = ":BufferLineCyclePrev<CR>";
      key = "<C-[>";
      mode = "n";
      options.silent = true;
    }
    {
      action = ":bdelete<CR>";
      key = "<C-Del>";
      mode = "n";
      options.silent = true;
    }
  ];
  extraLuaPackages = pkgs: [ pkgs.jsregexp ];
  extraPlugins = [ pkgs.vimPlugins.lualine-lsp-progress ];
  plugins = {
    bufferline.enable = true;
    lualine = {
      enable = true;
      sections.lualine_c = [ "lsp_progress" ];
    };
    treesitter = {
      enable = true;
      settings = {
        indent.enable = true;
        highlight.enable = true;
      };
    };
    luasnip.enable = true;
    neo-tree.enable = true;
    lsp = {
      enable = true;
      servers = {
        rust-analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };
        nixd.enable = true;
        csharp-ls.enable = true;
      };
    };
    lsp-lines = {
      enable = true;
    };
    cmp-nvim-lsp.enable = true;
    cmp_luasnip.enable = true;
    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
        completion.completeopt = "menu,menuone,noinsert";
        formatting.format = ''
          function (entry, vim_item)
            vim_item.abbr = string.sub(vim_item.abbr, 1, 30)
            return vim_item
          end
        '';
        mapping = {
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-j>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          "<C-k>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<Tab>" = "cmp.mapping.confirm({ select = true })";
        };
        sources = [
          { name = "path"; }
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
        ];
      };
    };
  };
}
