{
  pkgs,
  inputs,
  ...
}: {
  programs.firefox = {
    enable = true;
    package = inputs.firefox-nightly.packages.${pkgs.system}.firefox-nightly-bin;
    profiles.default.settings = {
      "ui.key.menuAccessKeyFocuses" = false;
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    };
  };
}
