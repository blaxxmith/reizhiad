{
  config,
  lib,
  sops,
  ...
}: let
  cfg = config.forgeOS.tools.git;
in {
  options.forgeOS.tools.git = {
    enable = lib.mkEnableOption "git, a powerful version control system";
    addAlias = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Use git command aliases";
    };
    addSSHConfig = lib.mkOption {
      type = lib.types.bool;
      default = config.forgeOS.tools.ssh.enable;
      description = "Auto add SSH configuration for GIT remotes";
    };

    extraAccounts = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule ({name, ...}: {
        options = {
          name = lib.mkOption {
            type = lib.types.str;
            default = name;
            description = "Name of the Git Account. Must be the FQDN for the SSH Config";
          };
          remote = lib.mkOption {
            type = lib.types.str;
            description = "Git IncludeIf pattern of the Account";
          };
          gitConfig = lib.mkOption {
            type = lib.types.str;
            description = "SOPS ID of the Git Config for this account";
          };
          sshConfig = lib.mkOption {
            type = lib.types.str;
            description = "SOPS ID of the SSH Config for this remote";
          };
        };
      }));
      default = {};
      description = "Extra GIT accounts to add";
    };
  };

  config = lib.mkIf cfg.enable {
    programs = lib.mkMerge [
      (lib.mkIf cfg.addAlias {zsh.shellAliases.g = "git";})

      (lib.mkIf cfg.addSSHConfig {
        ssh.includes =
          lib.mapAttrsToList (
            _: item: sops.secrets.${item.sshConfig}.path
          )
          cfg.extraAccounts;
      })

      {
        delta = {
          enable = true;
          enableGitIntegration = true;
          options = {
            line-numbers = true;
            side-by-side = true;
          };
        };

        git = {
          enable = true;

          includes =
            lib.mapAttrsToList (_: item: {
              condition = "hasconfig:remote.*.url:${item.remote}:*/**";
              path = sops.secrets."${item.gitConfig}".path;
            })
            cfg.extraAccounts;

          lfs.enable = true;
          signing.format = "ssh";

          settings = {
            gpg.format = "ssh";
            core = {
              compression = 9;
              whitespace = "error";
            };
            advices = {
              addEmptyPathspec = false;
              pushNonFastForward = false;
              statusHints = false;
            };
            status = {
              branch = true;
              short = true;
              showStash = true;
              showUntrackedFiles = "all";
            };
            init.defaultBranch = "master";
            color.ui = true;
            commit.gpgSign = true;
            push = {
              autoSetupRemote = true;
              default = "current";
            };
            pull.default = "current";

            alias = {
              a = "add";
              aa = "add --all";
              au = "add --update";
              b = "branch";
              bm = "branch -M main";
              cm = "commit -m";
              l = "log --all --oneline --graph --decorate";
              ls = "ls-files";
              t = "tag -ma";
              pft = "push --follow-tags";
              pl = "pull";
              st = "status";
              sw = "switch";
            };
          };

          ignores = [
            "__pycache__/"
            ".DS_Store"
            ".env*"
            "*.exe"
            ".idea/"
            ".vscode/"
            "*.d"
            "*.local"
            "*.o"
            "*.swp"
            "dist/"
            "node_modules/"
            "secrets/"
            "target/"
            "*.out"
            ".direnv/"
          ];
        };
      }
    ];
  };
}
