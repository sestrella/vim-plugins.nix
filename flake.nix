{
  description = "A collection of my favorite vim plugins";

  inputs = {
    auto-dark-mode-nvim.flake = false;
    auto-dark-mode-nvim.url = "github:f-person/auto-dark-mode.nvim";
    cmp-buffer.flake = false;
    cmp-buffer.url = "github:hrsh7th/cmp-buffer";
    cmp-nvim-lsp.flake = false;
    cmp-nvim-lsp.url = "github:hrsh7th/cmp-nvim-lsp";
    cmp-path.flake = false;
    cmp-path.url = "github:hrsh7th/cmp-path";
    cmp-vsnip.flake = false;
    cmp-vsnip.url = "github:hrsh7th/cmp-vsnip";
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11-small";
    nvim-cmp.flake = false;
    nvim-cmp.url = "github:hrsh7th/nvim-cmp";
    vim-vsnip.flake = false;
    vim-vsnip.url = "github:hrsh7th/vim-vsnip";
  };

  outputs = inputs@{ self, flake-utils, nixpkgs, ... }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        rec {
          checks = packages;
          # https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/vim.section.md
          packages = {
            auto-dark-mode-nvim = pkgs.vimUtils.buildVimPlugin {
              name = "auto-dark-mode.nvim";
              src = inputs.auto-dark-mode-nvim;
            };
            cmp-buffer = pkgs.vimUtils.buildVimPlugin {
              name = "cmp-buffer";
              src = inputs.cmp-buffer;
            };
            cmp-nvim-lsp = pkgs.vimUtils.buildVimPlugin {
              name = "cmp-nvim-lsp";
              src = inputs.cmp-nvim-lsp;
            };
            cmp-path = pkgs.vimUtils.buildVimPlugin {
              name = "cmp-path";
              src = inputs.cmp-path;
            };
            cmp-vsnip = pkgs.vimUtils.buildVimPlugin {
              name = "cmp-vsnip";
              src = inputs.cmp-vsnip;
            };
            nvim-cmp = pkgs.vimUtils.buildVimPlugin {
              name = "nvim-cmp";
              src = inputs.nvim-cmp;
            };
            vim-vsnip = pkgs.vimUtils.buildVimPlugin {
              name = "vim-vsnip";
              src = inputs.vim-vsnip;
            };
          };
        })
    //
    {
      # https://nixos.wiki/wiki/Overlays
      overlays.default = final: prev: {
        vimPlugins = prev.vimPlugins.extend (final': prev': self.packages.${prev.system});
      };
    };
}
