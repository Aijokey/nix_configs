{pkgs}: let
  archPlugins = pkgs.fetchurl {
    url = "https://archlinux.org/packages/extra/x86_64/geany-plugins/download/";
    sha256 = "1rv3vq856hpbwhnw57zqf64kmgfwl478y4g2rymj8lr5hfvwrmcn";
  };

  # Extract and prepare plugins as a separate derivation
  geanyPluginsExtracted = pkgs.stdenv.mkDerivation {
    name = "geany-plugins-extracted";
    src = archPlugins;

    nativeBuildInputs = with pkgs; [zstd gnutar patchelf];

    unpackPhase = ''
      mkdir -p $out
      tar -xf $src -C $out
    '';

    installPhase = ''
      # Move everything from usr/ to the root
      mv $out/usr/lib $out/lib
      mv $out/usr/share $out/share
      rmdir $out/usr

      echo "Plugin count: $(ls -1 $out/lib/geany/*.so 2>/dev/null | wc -l)"

      # Fix rpaths
      for lib in $out/lib/geany/*.so $out/lib/geany-plugins/geanylua/*.so $out/lib/libgeanypluginutils.so*; do
        if [ -f "$lib" ]; then
          patchelf --set-rpath "${pkgs.lib.makeLibraryPath (with pkgs; [
        glib
        gtk3
        lua5_1
        gpgme
        enchant2
        vte
        libsoup
      ])}:$out/lib:$out/lib/geany:$out/lib/geany-plugins/geanylua" "$lib" 2>/dev/null || true
        fi
      done
    '';
  };
in
  # Merge geany-with-vte and the plugins
  pkgs.symlinkJoin {
    name = "geany-with-plugins";
    paths = [pkgs.geany-with-vte geanyPluginsExtracted];

    buildInputs = [pkgs.makeWrapper];

    postBuild = ''
      # Re-wrap the geany binary with plugin paths
      rm $out/bin/geany
      makeWrapper ${pkgs.geany-with-vte}/bin/geany $out/bin/geany \
        --prefix GEANY_PLUGINS_PATH : "$out/lib/geany" \
        --prefix LD_LIBRARY_PATH : "$out/lib:$out/lib/geany-plugins" \
        --prefix XDG_DATA_DIRS : "$out/share"
    '';
  }
