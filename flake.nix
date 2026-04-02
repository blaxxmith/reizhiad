{
  description = "`/forgeOS`: Infrastructure as Nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    import-tree.url = "github:vic/import-tree";
    parts.url = "github:hercules-ci/flake-parts";

    sops.url = "github:Mic92/sops-nix";
    sops.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    lanzaboote.url = "github:nix-community/lanzaboote";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
    lanzaboote.inputs.pre-commit.follows = "";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.inputs.flake-parts.follows = "parts";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.inputs.home-manager.follows = "home-manager";
  };

  outputs = inputs:
    inputs.parts.lib.mkFlake {inherit inputs;} {
      imports = [(inputs.import-tree ./modules)];

      systems = ["x86_64-linux" "aarch64-linux"];

      # flake.nixosConfigurations = {
      # geonosis = inputs.nixpkgs.lib.nixosSystem {
      #   specialArgs = {inherit inputs;};
      #   modules = [./hosts/geonosis];
      # };
      # nevarro = inputs.nixpkgs.lib.nixosSystem {
      #   specialArgs = {inherit inputs;};
      #   modules = [./hosts/nevarro];
      # };
      # mandalore = inputs.nixpkgs.lib.nixosSystem {
      #   specialArgs = {inherit inputs;};
      #   modules = [./hosts/mandalore];
      # };
      # coruscant = inputs.nixpkgs.lib.nixosSystem {
      #   specialArgs = {inherit inputs;};
      #   modules = [./hosts/coruscant];
      # };
      # };
    };
}
