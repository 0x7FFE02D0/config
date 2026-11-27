# flake-modules.nix
# NixOS modules provided by flake inputs.
{ inputs, system }:

[
  # Hardware profiles matching this machine (AMD CPU and GPU, NVMe storage).
  inputs.nixos-hardware.nixosModules.common-cpu-amd
  inputs.nixos-hardware.nixosModules.common-gpu-amd
  inputs.nixos-hardware.nixosModules.common-pc-ssd

  # Gaming tweaks: Steam platform optimisations and low-latency PipeWire.
  inputs.nix-gaming.nixosModules.platformOptimizations
  inputs.nix-gaming.nixosModules.pipewireLowLatency

  # Prebuilt nix-index database, plus `comma` for running uninstalled programs.
  inputs.nix-index-database.nixosModules.nix-index

  # Catppuccin theming for NixOS and Home Manager.
  inputs.catppuccin.nixosModules.catppuccin

  # Imported but not enabled. Each needs manual setup before use:
  # - disko: declare `disko.devices` (disk layout).
  # - lanzaboote: create Secure Boot keys with sbctl, then set `boot.lanzaboote.enable`.
  # - sops-nix: add an age key and a secrets file, then set `sops.secrets`.
  # - impermanence: set `environment.persistence` (requires an ephemeral root).
  inputs.disko.nixosModules.disko
  inputs.lanzaboote.nixosModules.lanzaboote
  inputs.sops-nix.nixosModules.sops
  inputs.impermanence.nixosModules.impermanence

  {
    nix.settings.extra-substituters = [ "https://nix-gaming.cachix.org" ];
    nix.settings.extra-trusted-public-keys = [
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ee49MHTZQ4="
    ];

    programs.steam.platformOptimizations.enable = true;
    services.pipewire.lowLatency.enable = true;

    programs.nix-index = {
      enable = true;
      package = inputs.nix-index.packages.${system}.default;
    };
    programs.nix-index-database.comma.enable = true;

    environment.systemPackages = [ inputs.umu.packages.${system}.default ];

    catppuccin = {
      enable = true;
      flavor = "mocha";
    };

    home-manager.sharedModules = [
      inputs.catppuccin.homeModules.catppuccin
      {
        catppuccin = {
          enable = true;
          flavor = "mocha";
        };
      }
    ];
  }
]
