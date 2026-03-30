# `system`

[![Built with Nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

*Xavier2p `/forge` System Configuration*

> **Warning**  
> This project is *work in progress*, so it's not working now.

This repo contains all of my system configuration for all of my hosts,
built with Nix.

## Installation

```sh
nix run github:xavier2p/system#<host>
```

### Specifics

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

## Dependencies

- [Nix](https://nixos.org/nix/)
- [Nix Flakes](https://nixos.wiki/wiki/Flakes)
- [NixOS](https://nixos.org/)
- [Home Manager](https://github.com/nix-community/home-manager)
- [Nixvim](https://github.com/nix-community/nixvim)

## Credits

- [pinpox/nixos](https://github.com/pinpox/nixos)
- [fufexan/dotfiles](https://github.com/fufexan/dotfiles)
- [GaetanLepage/nix-config](https://github.com/GaetanLepage/nix-config)
- [Zaney/zaneyos](https://gitlab.com/Zaney/zaneyos)
- [poz/niksos](https://git.jacekpoz.pl/poz/niksos)
- [nezia/flocon](https://git.nezia.dev/nezia/flocon)

