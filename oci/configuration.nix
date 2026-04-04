{
  modulesPath,
  lib,
  pkgs,
  config,
  ...
} @ args:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
    ./hardware-configuration.nix
  ];
  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };
  services.openssh.enable = true;

  sops = {
    defaultSopsFile = ./secrets/cloudflare.yaml;
    age.keyFile = "/var/lib/sops-nix/key.txt";
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    age.generateKey = true;

    secrets.cloudflare_api_token = {};
  };

  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal
  ];

  users.users.root.openssh.authorizedKeys.keys =
  [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPPhp/5p6vOj9vSuFTCEPRdcSESCGosAlJcZb8UKi2/g siddhant@fifthtrys-MacBook-Pro.local"
  ] ++ (args.extraPublicKeys or []); # this is used for unit-testing this module and can be removed if not needed

  # Enable flakes
  nix.package = pkgs.nix;
  nix.settings.experimental-features = "nix-command flakes";
  nix.settings.trusted-users = [ "sidd" ];

  programs.fish.enable = true;
  users.users.sidd = {
    isNormalUser = true;
    createHome = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "adbusers" "docker" "lxd" ];
    shell = pkgs.fish;

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPPhp/5p6vOj9vSuFTCEPRdcSESCGosAlJcZb8UKi2/g siddhant@fifthtrys-MacBook-Pro.local"
    ];
  };

  services.tailscale.enable = true;
  services.actual.enable = true;

  sops.templates.cloudflare-env = {
    content = ''
      CLOUDFLARE_API_TOKEN=${config.sops.placeholder.cloudflare_api_token}
    '';
  };

  services.caddy = {
    enable = true;

    package = pkgs.caddy.withPlugins {
      plugins = [ "github.com/caddy-dns/cloudflare@v0.2.4" ];
      hash = "sha256-8HpPZ/VoiV/k0ZYcnXHmkwuEYKNpURKTN19aYZRLPoM=";
    };


    configFile = pkgs.writeText "Caddyfile" ''
      {
        acme_dns cloudflare {env.CLOUDFLARE_API_TOKEN}
      }

      actual.siddhant.xyz {
        reverse_proxy localhost:3000
      }
    '';
  };

  systemd.services.caddy.serviceConfig.EnvironmentFile = [
    config.sops.templates.cloudflare-env.path
  ];

  system.stateVersion = "25.11";
}
