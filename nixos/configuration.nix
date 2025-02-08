# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';
in
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];


  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "codes"; # Define your hostname.
  networking.networkmanager.enable = true;
  networking.wireless.enable = false; # Enables wireless support via wpa_supplicant.

  # able to write /etc/hosts as sudo
  environment.etc.hosts.mode = "0644";
  # networking.extraHosts = ''
  # 185.199.108.133 raw.githubusercontent.com
  # '';

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp7s0.useDHCP = true;
  networking.interfaces.wlp0s20f3.useDHCP = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" ];
  console = {
    font = "Ubuntu Mono 14";
    keyMap = "us";
  };

  # Enable the X11 windowing system.
  # Enable the GNOME Desktop Environment.
  # services.xserver = {
  #   enable = true;
  #   desktopManager.xterm.enable = false;
  #   exportConfiguration = true;
  #
  #   videoDrivers = [ "nvidia" ];
  #
  #   windowManager.i3 = {
  #     enable = true;
  #     package = pkgs.i3-gaps;
  #     extraPackages = with pkgs; [
  #       dmenu
  #       i3status-rust
  #     ];
  #   };
  #
  # };

  # services.displayManager = {
  #   defaultSession = "none+i3";
  # };


  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "greeter";
      };
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput = {
    enable = true;
    touchpad = {
      tapping = true;
      naturalScrolling = true;
    };
  };

  services.picom = import ./config/picom.nix { inherit pkgs; };

  hardware.nvidia.prime = {
    offload.enable = true;

    intelBusId = "PCI:00:02:0";
    nvidiaBusId = "PCI:01:00:0";
  };

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # SSD trim
  services.fstrim.enable = true;

  services.locate.enable = true;

  # Enable sound via Pipewire
  # sound.enable = false;

  security.rtkit.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  boot.extraModprobeConfig = ''
    options snd-hda-intel model=dell-headset-multi
  '';

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sidd = {
    isNormalUser = true;
    createHome = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "adbusers" "docker" "lxd" ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  # Enable flakes
  nix.package = pkgs.nixVersions.latest;
  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
    experimental-features = nix-command flakes
  '';

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    grim # screenshot for sway
    slurp # screenshot?
    wl-clipboard
    mako # notification system on sway

    bind
    binutils
    coreutils
    inetutils
    fd
    sd
    lsof
    file
    unzip
    git
    wget
    vim
    firefox
    nvidia-offload
    stdenv
    gnumake
    man-pages
    libnotify

    i3status-rust

    xfce.thunar
    # Optionals
    xfce.xfconf # Needed to save the preferences
  ];

  documentation.man.generateCaches = true;
  documentation.dev.enable = true;

  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  services.gnome.gnome-keyring.enable = true;

  # shared partition setup
  boot.supportedFilesystems = [ "ntfs" ];

  # fileSystems."/home/sidd/shared" = {
  #   device = "/dev/nvme0n1p8";
  #   fsType = "ntfs3";
  #   options = [ "rw" "uid=1000" ];
  # };
  #
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.noisetorch.enable = true;

  programs.dconf.enable = true;

  # Steam
  programs.steam.enable = true;

  # Docker
  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "sidd" ];

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  hardware.bluetooth.enable = true;
  systemd.user.services."dunst" = {
    enable = true;
    description = "";
    wantedBy = [ "default.target" ];
    serviceConfig.Restart = "always";
    serviceConfig.RestartSec = 2;
    serviceConfig.ExecStart = "${pkgs.dunst}/bin/dunst";
  };

  specialisation = {
    external-display.configuration = {
      system.nixos.tags = [ "external-display" ];
      hardware.nvidia = {
        prime.offload.enable = lib.mkForce false;
        powerManagement.enable = lib.mkForce false;
      };
    };
  };

  hardware.opentabletdriver.enable = true;
  hardware.opentabletdriver.daemon.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
}

