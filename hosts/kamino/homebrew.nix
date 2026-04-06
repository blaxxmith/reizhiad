_: {
  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    taps = [];
    brews = [];

    casks = [
      "android-file-transfer"
      "appcleaner"
      "obsidian"
    ];
  };
}
