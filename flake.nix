{
  description = "`/forgeOS`: Infrastructure as Nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixdocs.url = "github:Thunderbottom/nix-options-doc";
    deploy-rs.url = "github:serokell/deploy-rs";
    nixos-hardware.url = "github:nixos/nixos-hardware";

    sops = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixdocs,
    deploy-rs,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      geonosis = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [./hosts/geonosis];
      };
      nevarro = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [./hosts/nevarro];
      };
      mandalore = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [./hosts/mandalore];
      };
      coruscant = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [./hosts/coruscant];
      };
      mustafar = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        system = "aarch64-linux";
        modules = [./hosts/mustafar];
      };
    };

    apps.${system} = {
      default = self.apps.${system}.docs;

      docs = {
        type = "app";
        program = "${pkgs.writeShellScript "run-docs" ''
          ${nixdocs.packages."${system}".default}/bin/nix-options-doc --strip-prefix --out ref.md --progress
        ''}";
        meta.description = "Generate a markdown reference of my options";
      };
    };

    devShells.${system} = {
      default = self.devShells.${system}.nix;

      nix = pkgs.mkShell {
        name = "nix";
        packages = [
          pkgs.sbctl
          nixdocs.packages.${system}.default
          deploy-rs.packages.${system}.default
          pkgs.sops
          pkgs.age
          pkgs.ssh-to-age
        ];
      };
    };
  };
}
