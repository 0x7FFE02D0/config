# modules/users.nix
# The main user account and its groups.
{ user, ... }:

{
  users.users.${user.username} = {
    isNormalUser = true;
    description = user.username;
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "video"
      "input"
      "users"
      "docker"
    ];
  };
}
