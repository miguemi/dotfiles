{
  description = "MigueMI's nixos";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # darwin
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-darwin,
      ...
    }@inputs:
    let
      # users
      personalUser = "miguemi";

      # functions
      importPkgs =
        system:
        import nixpkgs {
          system = system;
          config = {
            allowUnfree = true;
          };
        };

      homeConfig =
        user: system: pkgs:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home-manager/home.nix
          ];
          extraSpecialArgs = {
            homeUser = user;
          };
        };

      # x86 declarations
      system = "x86_64-linux";
      pkgs = importPkgs system;

      aarchSystem = "aarch64-darwin";
      aarchPkgs = importPkgs aarchSystem;

    in
    {
      # Native Nix machine
      nixosConfigurations = {
        "nixos" = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./system/configuration.nix ];
        };
      };

      # MacOS
      darwinConfigurations = {
        "mb-pro" = nix-darwin.lib.darwinSystem {
          system = aarchSystem;
          modules = [ ./darwin/darwin.nix ];
          specialArgs = { inherit inputs; };
        };
      };

      # home-manager
      homeConfigurations = {
        "${personalUser}@mb-pro" = homeConfig personalUser aarchSystem aarchPkgs;
      };
    };
}
