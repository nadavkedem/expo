let
  pin = builtins.fromJSON (builtins.readFile ./nixpkgs.json);

  nixpkgs = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs-channels/archive/${pin.rev}.tar.gz";
    inherit (pin) sha256;
  };

in

{ ... } @ args:

  import nixpkgs (args // {
    config = {
      allowUnfree = true;
      android_sdk.accept_license = true;
    };
    overlays = [ (import ./all-packages.nix) ];
  })
