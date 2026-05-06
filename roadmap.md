# Roadmap to `/forgeOS`

## Dendritic Pattern

### Tree

```
- modules/
  - system/     # old nixos folder
  - apps/
  - shell/
  - tools/
  - neovim/
  - desktop/
  - services/
- hosts/
- profiles/
- .secrets/
- .assets/
- flake.nix
```

### Principles

- All files must be a NixOS module
- For HM, use a module in a nix file, for only one feature / app etc.
- Use imports and pass args to file for user + home manager path.
  - User: variable `config.forgeOS.profile.user`
  - HM: no variable needed, if it's on the tree of imports.

## Addings / Improvments/ Next Steps

- thunderbird pro/perso
- test nushell
