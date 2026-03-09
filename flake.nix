{
  description = "My config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri.url = "github:sodiboo/niri-flake";

    nixcord = {
      url = "github:kaylorben/nixcord";
    };

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    lazyvim.url = "github:pfassina/lazyvim-nix";

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";

    copyparty.url = "github:9001/copyparty";

    zapret-discord-youtube.url = "github:kartavkun/zapret-discord-youtube";

    nix-gaming.url = "github:fufexan/nix-gaming";

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    winapps = {
      url = "github:winapps-org/winapps";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mcsr-nixos = {
      url = "https://git.uku3lig.net/uku/mcsr-nixos/archive/main.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      stylix,
      niri,
      mango,
      ...
    }@inputs:
    let
      b = builtins;
      system = "x86_64-linux";
      nixosConfigDir = "/home/olegsea/flake";
    in
    {
      nixosConfigurations.oleg-laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit nixosConfigDir;
          inherit inputs;
          inherit system;
          inherit stylix;
        };
        modules = [
          ./hosts/laptop/configuration.nix

          stylix.nixosModules.stylix
          niri.nixosModules.niri
          mango.nixosModules.mango

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit nixosConfigDir;
              inherit inputs;
              inherit system;
            };
            home-manager.users.olegsea = {
              imports = [
                ./home-manager/olegsea/home.nix
                mango.hmModules.mango
              ];
            };
          }
        ];
      };

      nixosConfigurations.oleg-desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit nixosConfigDir;
          inherit inputs;
          inherit system;
          inherit stylix;
        };
        modules = [
          ./hosts/desktop/configuration.nix

          stylix.nixosModules.stylix
          niri.nixosModules.niri
          mango.nixosModules.mango

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit nixosConfigDir;
              inherit inputs;
              inherit system;
            };
            home-manager.users.olegsea = {
              imports = [
                ./home-manager/olegsea/home.nix
                mango.hmModules.mango
              ];
            };
          }
        ];
      };

      nixosConfigurations.oleg-server = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit nixosConfigDir;
          inherit inputs;
          inherit system;
        };
        modules = [
          ./hosts/server/configuration.nix
        ];
      };
    };
}
