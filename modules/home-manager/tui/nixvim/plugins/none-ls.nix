{
  programs.nixvim.plugins.none-ls = {
    enable = true;
    enableLspFormat = true;
    border = [
      "DiagnosticHint"
      "DiagnosticInfo"
      "WarningMsg"
      "ErrorMsg"
    ];
  };
}
