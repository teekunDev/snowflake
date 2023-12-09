#
#  server nixOS configuration.
#
#  flake.nix
#   └─ ./hosts
#       ├─ hosts.nix !
#       └─ ./server
#           └─ ./configuration
#               ├─ configuration.nix *
#               └─ hardware-configuration.nix +
#

{ pkgs, inputs, vars, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./vm.nix
  ];

  security.sudo.wheelNeedsPassword = false;
  console.keyMap = "de";
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  users.users.${vars.user} = {
    isNormalUser = true;
    password = "123";
    extraGroups = [ "wheel" "docker" ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC9lCNP8EUEVlQFPZ9PJYEUqhxSlbJA8kYunpmy3ay5QNpLuGw7Gp9sjb0K/DXyzV3PgbSm6wxEbLmg1jXPiohGSqoXeTzgc500lKlpxtk89XKp6nmCF2uCykuKA8zSOhj+lWmfuyIZcsz23LHM8ksAji3VrhQy3Rb1jHLyvtm0yX2INlC3VsHWKazBtpqH3ZA5QdmVkYs5DzXOQS0THtq0R3+PRiUArQIZLiA5x5fkgnu1r6klPYvovlKNoyxp+SFxnN29mRKBVKhcvuUPxrWLlSYyhtV0Q3uz8kOAqUarRQpbOZJ8494z/ZwT+6K23wttyMfcSZJ1zX0m6viGQO4TQdMUa7l9cs4aOlqwMEB7dLo11LFQFkQBHJgxZICmXC9a74uhElbBVU9WFu1P+fVjmr8Jvl0th5/O2tCx3RegSxDBmcnVHGYJ1JkBkNGzPH9IkHJKZU6Tbe0PJpF1gsNY7LV8z6zzySFLVALbau7tFjS7xt6558pVbY4PU9blxW2hFZoYW9/wynuHtttOs7pQBffntA4I9pJR/B/Gf3NSCVqc3te83gvdMkbICPRknjbd88KhOHCmXa86wMvfCc9XnTGYoX5POHdVw/JR4gTuGcx/YAoDGiHrP1pGlXNhyhc1JxD/EpZz8KBMVz+9zkKuNUcFgP9V7xRUmgSEqC5yBQ== github@keifufu.dev"
    ];
  };

  networking.firewall = {
    enable = true;
    # http https smb qbit minecraft
    allowedTCPPorts = [ 80 443 445 8999 25565 ];
    # qbit
    allowedUDPPorts = [ 8999 ];
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };
  
  virtualisation.docker.enable = true;

  services.samba = {
    enable = true;
    securityType = "user";
    extraConfig = ''
      workgroup = WORKGROUP
      server string = Samba (NixOS)
      security = user
      guest account = nobody
      map to guest = bad user
    '';
    shares = {
      data = {
        path = "/stuff/data";
        writeable = "yes";
        "guest ok" = "no";
        "force user" = "${vars.user}";
        "force group" = "users";
        "force create mode" = "0775";
        "force directory mode" = "0775";
        "inherit permissions" = "yes";
      };
    };
  };

  environment = {
    variables = {
      NIXOS_ALLOW_UNFREE = "1";
      NIXOS_SECRETS = "${vars.secrets}";
      NIXOS_FILES = "${vars.location}/files";
      PATH = [
        "${vars.location}/files/scripts"
      ];
    };
    systemPackages = with pkgs; [
      kitty         # because otherwise it'll cry
      killall       # killall
      nano          # nano
      curl          # curl
      git           # git
      wget          # some scripts use wget instead of curl
      screen        # screen
    ];
  };

  nix = {
    settings = {
      trusted-users = [ "${vars.user}" "@wheel" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    ''; 
  };

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.11";
}
