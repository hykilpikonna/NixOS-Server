# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./home-manager.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  time.timeZone = "America/Toronto";

  # Configured for Linode
  networking.usePredictableInterfaceNames = false;
  networking.useDHCP = false;
  networking.interfaces.eth0.useDHCP = true;
  networking.hostName = "HyDEV-Nix";

  # Nginx
  services.nginx.enable = true;
  services.nginx.virtualHosts."nix.hydev.org" = {
      addSSL = true;
      enableACME = true;
      root = builtins.fetchGit {
        url = "https://github.com/HyDevelop/hydevelop.github.io";
        ref = "master";
      };
  };
  security.acme.email = "me@hydev.org";
  security.acme.acceptTerms = true;

  # V2Ray
  services.v2ray = {
      enable = true;
      configFile = builtins.fetchurl {
          url = "https://gist.githubusercontent.com/hykilpikonna/b490377c22f92c9013ec31a1df2b40fb/raw/db4fbc1cccea0e5d571bdef4eb9ded042e2f7098/v2ray.config.json";
      };
  };

  # Nano
  programs.nano.nanorc = ''
      set tabstospaces
      set tabsize 2
      set autoindent
      set linenumbers
      set nonewlines

      bind ^z undo main
      bind ^y redo main
      bind ^f whereis main
      bind ^r replace main
  '';

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.jane = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  # };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    inetutils
    mtr
    sysstat
    nixpkgs-fmt
    python3
    jdk11
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 80 8080 7890 ];
  networking.firewall.allowedUDPPorts = [ 80 8080 7890 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

  services.openssh = {
    enable = true;
  };

  users.users.root.openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCrg1apHEeRam4/4AQYCUEKb0Sqy760/qqS7lWHSSDRoeoK6FKtBpMSwQAdjetdEzSJpVuJmTjniEckZb731FrGCh08tYZMAiuyLulHyrBCpwdqd3yAcgjfdPee8/RKLE+6OHHE3/MS2LNRd0NAwOu2PLewbyaOVZ0aigWq6J3ZhLZlj//OgaZDdvqi25ny50cVdzFJB9Pkykk2x/Nq7HNGsxVCbu5zCsHEqw0KEosxi9/ufr2zrZObQX0elipfGopV7Gyb3XFPZHEZic+/KWOMvU8rTuTiJDpCVFRFdMrQYx4SoM21c6qslC/t99X6q7m+96OpfviIWjmuHazGBaIn admin@moecraft.cc"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDAoms8qirQCt8InWouj6bMph20c22bh7qOxM7OeUiqW3fKdPU1/2MSkqmlcbvm2VM5dyXnZMUEGg6CWaF/kw2WYQzWPu10KpCATtnxqc6/BI5St5P2rEky6AXgcm1YcdxHe3dh13Oa5EK8L80t+AJ7JEYpLQy4gm/ZtDxXL0k7VEGT3pGDG3keBxnq0mvnDOiMKFQ7zSCHEsNseZj56U5l1z1JYBqrGA0yelWja3u0DrYC3BRBlcbaOxOX3UdrXZCVN6sXTQ3X38ZhEoiZ1ihDAxJ/doECKcL5GmkjGspyxr8mHEG0uI173lmH7cCYkOiyg7WVU7y2rM7MHkYVuL8yPRWy4gGdRWCjfkj40pvQeq0QAuTr5MfA/xwQXjJSBEkPdSpf60QvZOMnUFCwSSVHjvBDghKaO+x0z9GZrJzQ5lTHmyvj1NmawAh+Gkkd7kFyLmFuXAKkpuR/b+WaROcI7c6m9bfXuAVEz8XI4yrhpaINS7GhwIflzbh2hcXHfTU= neko@hydev.org"
  ];
}
