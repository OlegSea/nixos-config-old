{ inputs, ... }:
{
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];
  programs.nixcord = {
    enable = true;
    # dorion.enable = true;
    config = {
      themeLinks = [
        "https://raw.githubusercontent.com/shvedes/discord-gruvbox/refs/heads/main/gruvbox-dark.theme.css"
      ];
      frameless = true;
      plugins = {
      };
    };
    extraConfig = {
      # Some extra JSON config here
      # ...
    };
  };
}
