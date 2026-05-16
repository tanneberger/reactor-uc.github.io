{ pkgs }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    (python3.withPackages (ps: with ps; [
      mkdocs-material
      mkdocs-minify-plugin
      mkdocs-glightbox
      pillow
      cairosvg
    ]))
  ];

  shellHook = ''
    echo "reactor-uc docs environment loaded"
    echo "Run 'mkdocs serve' to start the development server"
  '';
}
