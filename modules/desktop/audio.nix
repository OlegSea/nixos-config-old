{
  config,
  pkgs,
  nixpgkgs-stable,
  ...
}:

{

  environment.systemPackages = with pkgs; [
    nixpkgs-stable.legacyPackages.x86_64-linux.guitarix
    qjackctl
    reaper
    helvum
  ];
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  programs.noisetorch.enable = true;
}
