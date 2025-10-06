{...}: {
  config.vim = {
    languages = {
      enableLSP = true;
      enableTreesitter = true;
      enableFormat = true;
      # enableExtraDiagnostics = true;

      nix.enable = true;
      python.enable = true;
      go.enable = true;
      markdown.enable = true;
      rust.enable = true;
      csharp.enable = true;
      clang.enable = true;
    };

    lsp = {
      formatOnSave = false;
      lspsaga.enable = true;
      lsplines.enable = true;
    };

    debugger.nvim-dap = {
      enable = true;
      ui.enable = true;
    };

    autocomplete.nvim-cmp = {
      enable = true;
      mappings = {
        next = "<C-j>";
        previous = "<C-k>";
      };
    };
  };
}
