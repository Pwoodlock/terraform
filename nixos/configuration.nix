{ modulesPath, lib, pkgs, config, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
  ];

  boot.kernelParams = [ "panic=60" "boot.panic_on_fail" "console=ttyS0,115200" "console=tty1" ];
  boot.kernel.sysctl = {
    "vm.max_map_count" = 262144;
    "fs.file-max" = 65536;
  };

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  boot.initrd = {
    availableKernelModules = [
      "ata_piix"
      "uhci_hcd"
      "virtio_pci"
      "virtio_scsi"
      "sd_mod"
      "sr_mod"
    ];
    verbose = true;
  };

  boot.consoleLogLevel = 7;

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  users.users.patrick = {
    isNormalUser = true;
    extraGroups = [ "wheel" "podman" "docker" ];
  };

  users.users.root = {};

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "prohibit-password";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  environment.systemPackages = with pkgs; [
    curl
    gitMinimal
    htop
    podman
    podman-compose
    buildah
    skopeo
  ];

  security.polkit.enable = true;
  system.stateVersion = "24.05";
}