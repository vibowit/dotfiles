{ pkgs }:

pkgs.mkShell {
  packages = with pkgs; [
    go_1_22
    gopls
    python3
    pre-commit
    git
  ];

  shellHook = ''
    echo "🚀 Dev environment ready!"
    export LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH"
  '';
}
