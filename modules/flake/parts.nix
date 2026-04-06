{inputs, ...}: {
  imports = [
    # inputs.parts.flakeModules.modules
    # inputs.parts.flakeModules.flakeModules
    inputs.home-manager.flakeModules.home-manager
  ];
}
