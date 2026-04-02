{inputs, ...}: {
  imports = [
    inputs.parts.flakeModules.modules
    inputs.parts.flakeModules.flakeModules
  ];
}
