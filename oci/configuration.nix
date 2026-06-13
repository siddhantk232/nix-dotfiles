# TODO: some services need first time setup: qbittorrent etc
# nix should set the username/password and any config that can be set so that
# it becomes a one cmd setup if I want to migrate away from oci
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
    defaultSopsFile = ./secrets/services.yaml;
    age.keyFile = "/var/lib/sops-nix/key.txt";
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    age.generateKey = true;

    secrets.cloudflare_api_token = {};
    secrets."homepage-dashboard/env" = {};
    secrets."slskd/env" = {};
    secrets."instahyre/curl" = {};
  };

  environment.systemPackages = map lib.lowPrio (with pkgs; [
    curl
    gitMinimal
    binutils
    coreutils
    inetutils
    lsof
    file
    tree
    unzip
    wget
    vim
  ]);

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
    extraGroups = [ "wheel" "networkmanager" "adbusers" "docker" "lxd" "media" ];
    shell = pkgs.fish;

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPPhp/5p6vOj9vSuFTCEPRdcSESCGosAlJcZb8UKi2/g siddhant@fifthtrys-MacBook-Pro.local"
    ];
  };
  users.users.jellyfin.extraGroups = [ "media" ];

  services.tailscale.enable = true;

  services.homepage-dashboard.enable = true;
  services.homepage-dashboard.environmentFile = config.sops.secrets."homepage-dashboard/env".path;
  services.homepage-dashboard.allowedHosts = "hm.siddhant.xyz,localhost:8082,127.0.0.1:8082";
  services.homepage-dashboard.services = [
    {
      "All" = [
        {
          "Navidrome" = {
            href = "https://navidrome.siddhant.xyz";
            target = "_self";
            icon = "navidrome";
            widget = {
              type = "navidrome";
              url = "https://navidrome.siddhant.xyz";
              user = "{{HOMEPAGE_VAR_NAVIDROME_USERNAME}}";
              salt = "{{HOMEPAGE_VAR_NAVIDROME_SALT}}";
              token = "{{HOMEPAGE_VAR_NAVIDROME_TOKEN}}";
            };
          };
        }
        {
          "Actual" = {
            href = "https://actual.siddhant.xyz";
            target = "_self";
            icon = "actual-budget";
          };
        }
        {
          "Qbittorrent" = {
            href = "https://qbit.siddhant.xyz";
            target = "_self";
            icon = "qbittorrent";
          };
        }
      ];
    }
  ];

  services.actual.enable = true;

  services.qbittorrent.enable = true;

  users.groups.media = {};
  users.users.qbittorrent.extraGroups = [ "media" ];
  users.users.navidrome.extraGroups = [ "media" ];
  users.users.slskd.extraGroups = [ "media" ];
  services.slskd.settings.directories.downloads = "/data/music";


  systemd.tmpfiles.rules = [
    "d /data 0755 root root -"
    "d /data/downloads 0775 qbittorrent media -"
    "d /data/music 0775 slskd media -"
    "d /var/lib/slskd 0755 slskd media -"
    "d /var/lib/jellyfin 0755 jellyfin media -"
  ];

  services.navidrome.enable = true;
  services.navidrome.settings = {
    MusicFolder = "/data/music";
    Scanner.Enabled = true;
    Scanner.PurgeMissing = "always";
  };

  services.slskd.enable = true;
  services.slskd.domain = "slskd.siddhant.xyz";
  services.slskd.environmentFile = config.sops.secrets."slskd/env".path;
  services.slskd.settings = {
    shares.directories = [];
  };
  systemd.services.slskd.serviceConfig = {
    ReadWritePaths = [ "/data/music" ];
  };

  services.jellyfin.enable = true;

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

      hm.siddhant.xyz {
        reverse_proxy localhost:8082
      }
      actual.siddhant.xyz {
        reverse_proxy localhost:3000
      }
      navidrome.siddhant.xyz {
        reverse_proxy localhost:4533
      }
      qbit.siddhant.xyz {
        reverse_proxy localhost:8080
      }
      slskd.siddhant.xyz {
        reverse_proxy localhost:5030
      }
      jellyfin.siddhant.xyz {
        reverse_proxy localhost:8096
      }
    '';
  };

  systemd.timers."instahyre" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 09:00:00";
      Persistent = true;
      AccuracySec = "1min";
    };
  };

  systemd.services."instahyre" = {
    # this file only contains a string that has the curl command to hit my instahyre. it's .gitignore(d)
    script = config.sops.secrets."instahyre/curl".path;
    serviceConfig = {
      Type = "oneshot";
      User = "sidd";
    };
  };

  systemd.services.caddy.serviceConfig.EnvironmentFile = [
    config.sops.templates.cloudflare-env.path
  ];

  system.stateVersion = "25.11";
}
