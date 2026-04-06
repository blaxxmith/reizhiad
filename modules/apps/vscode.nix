_: {
  flake.homeModules.apps = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.forgeOS.apps.vscode;
  in {
    options.forgeOS.apps.vscode.enable = lib.mkEnableOption "Visual Studio Code";

    config = lib.mkIf cfg.enable {
      programs.vscode = {
        enable = true;
        profiles.default = {
          enableExtensionUpdateCheck = false;
          enableUpdateCheck = false;

          userSettings = {
            files.autoSave = "off";

            workbench.startupEditor = "none";
            workbench.iconTheme = "material-icon-theme";
            workbench.layoutControl.enabled = false;

            editor.rulers = [80 120 160];
            editor.tabSize = 2;
            editor.formatOnSave = true;
            editor.fontSize = 12;
            window.zoomLevel = -1;

            explorer.confirmDelete = false;
            explorer.confirmDragAndDrop = false;
            window.menuBarVisibility = "hidden";
            window.commandCenter = true;

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
