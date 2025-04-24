{
  inputs,
  outputs,
  user,
  ...
}:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs outputs user; };
    users.${user}.imports = [ ../../home ];
  };
}
