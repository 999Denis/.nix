{ config, pkgs, ... }:

{
  # 1. Configurazione del Cursore
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  # 2. Configurazione Temi GTK
  gtk = {
    enable = true;
    
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    iconTheme = {
      name = "Tela-circle-dark";
      package = pkgs.tela-circle-icon-theme;
    };

    # Forza il dark mode sia per GTK3 che per GTK4
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  # 3. Ottimizzazione dconf (Essenziale per le app moderne e libadwaita)
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  # 4. Variabili d'ambiente per forzare il rendering scuro (Opzionale ma consigliato)
  home.sessionVariables = {
    GTK_THEME = "adw-gtk3-dark";
  };
}
