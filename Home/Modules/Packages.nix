{
  inputs,
  config,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [

    # Fetch
    fastfetch

    # Audio
    feishin
    pavucontrol

    spotify

    # System
    git
    gh
    pix
    localsend
    slurp
    gnome-disk-utility
    gnome-text-editor
    grim
    wofi
    lsd
    wl-clipboard
    nwg-look
    tldr
    swappy
    nautilus
    xdg-utils
    xdg-desktop-portal-wlr
    satty
    btop
    wofi

    # Social
    vesktop
    discord
    # Gaming
    lunar-client
    vulkan-tools
    protontricks
    protonplus

    # Coding
    antigravity
    kiro
    zed-editor

    # Coding Libraries
    nil
    nixd
    rust-analyzer

    # Themes
    adw-gtk3
    material-symbols

    # Filesystems
    gvfs
    udisks2
    udiskie
    udevil
    usbutils
    samba
    cifs-utils
    mtpfs
    libmtp
    fuse3
    ntfs3g
    exfatprogs
    dosfstools

    # Screenshot
    hyprshot

  ];

  programs.evie.enable = true;
  programs.eviefetch.enable = true;

  programs.zen-browser.enable = true;

  nixpkgs.config.allowUnfree = true;
}
