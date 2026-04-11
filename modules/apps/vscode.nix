_: {
  flake.nixosModules.apps = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.forgeOS.apps.vscode;
  in {
    options.forgeOS.apps.vscode.enable = lib.mkEnableOption "Visual Studio Code";

    config.home-manager.users."${config.forgeOS.profile.user}" = lib.mkIf cfg.enable {
      programs.vscode = {
        enable = true;
        profiles.default = {
          enableExtensionUpdateCheck = false;
          enableUpdateCheck = false;

          userSettings = {
            files.autoSave = "off";
            workbench = {
              startupEditor = "none";
              iconTheme = "material-icon-theme";
              layoutControl.enabled = false;
            };
            editor = {
              rulers = [80 120 160];
              tabSize = 2;
              formatOnSave = true;
              fontSize = 12;
            };
            window = {
              zoomLevel = -1;
              menuBarVisibility = "hidden";
              commandCenter = true;
            };
            explorer = {
              confirmDelete = false;
              confirmDragAndDrop = false;
            };
            chat.commandCenter.enabled = false;
            update.showReleaseNotes = false;
          };

          extensions = with pkgs.vscode-extensions; [
            hashicorp.terraform
            pkief.material-icon-theme
            github.copilot
            redhat.ansible
            esbenp.prettier-vscode
            vscodevim.vim
            usernamehw.errorlens
          ];
        };
      };
    };
  };
}
