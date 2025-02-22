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

  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

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
    kitty # required by hyprland
    wofi # rofi but wayland
    grim # scrots
    slurp # scrots
    hyprpaper # wallpaper
    waybar # statusbar
    hyprpicker
    wl-clipboard
    xdg-utils
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

