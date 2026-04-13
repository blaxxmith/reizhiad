# `reizhiad`: Infrastructure as Nix

[![Built with Nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

_@blaxxmith's Infrastructure System Configuration using Dendritic Pattern_

> **Warning**  
> This project is _work in progress_, so it's not working now. This present
> README and especially the instruction part is not working at all.

## Hosts

### Geonosis

My main computer, a Lenovo ThinkPad E14.

### Mustafar

A Raspberry Pi 4, used as a Kubernetes Cluster single node running self-hosted services.

### More to come...

I have some other devices that I will add to this config one day.

## Linux Environment

- OS -> NixOS
- WM -> Sway
- Browser -> Zen / Firefox
- Editor -> Neovim via NixVim
- Shell -> ZSH
- Terminal -> Ghostty
- Secret Management -> SOPS

## Dependencies

- [Nix](https://nixos.org/nix/)
- [Nix Flakes](https://wiki.nixos.org/wiki/Flakes)
- [NixOS](https://nixos.org/)
- [Home Manager](https://github.com/nix-community/home-manager)
- [Nixvim](https://github.com/nix-community/nixvim)
- [Flake Parts](https://flake.parts)
- [SOPS Nix](https://github.com/mic92/sops-nix)
- [Treefmt Nix](https://github.com/numtide/treefmt-nix)

## Credits

Thanks to all these inspirations:

- [@pinpox/nixos](https://github.com/pinpox/nixos)
- [@fufexan/dotfiles](https://github.com/fufexan/dotfiles)
- [@GaetanLepage/nix-config](https://github.com/GaetanLepage/nix-config)
- [@Zaney/zaneyos](https://gitlab.com/Zaney/zaneyos)
- [@poz/niksos](https://git.jacekpoz.pl/poz/niksos)
- [@nezia/flocon](https://git.nezia.dev/nezia/flocon)
- [@drupol/infra](https://github.com/drupol/infra)
- [@mightyiam/infra](https://github.com/drupol/infra)

## Useful Commands

#### Rebuild mustafar

```sh
sudo nixos-rebuild switch --flake .#mustafar --target-host nixos@mustafar.forge --build-host nixos@mustafar.forge --sudo
```

#### Yubikeys

Add a Yubikey to the system:

```sh
nix-shell -p pam_u2f
mkdir -p ~/.config/Yubico
pamu2fcfg >> ~/.config/Yubico/u2f_keys
```
