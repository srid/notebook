let
  jupyter = import (builtins.fetchGit {
    url = https://github.com/tweag/jupyterWith;
    rev = "35eb565c6d00f3c61ef5e74e7e41870cfa3926f7";
  }) {};

  iPython = jupyter.kernels.iPythonWith {
    name = "python";
    packages = p: with p; [ numpy ];
  };

  iHaskell = jupyter.kernels.iHaskellWith {
    extraIHaskellFlags = "--codemirror Haskell";  # for jupyterlab syntax highlighting
    name = "haskell";
    packages = p: with p; [ 
      aeson
      relude
      containers
      streamly
    ];
  };

  jupyterEnvironment =
    jupyter.jupyterlabWith {
      kernels = [ iHaskell ];
    };
in
  jupyterEnvironment.env

/*
let 
  pkgs = import <nixpkgs> {};
in 
  pkgs.mkShell {
    buildInputs = with pkgs; [
      jupyter
      ghc
      cabal-install
      ghcid
      haskellPackages.streamly
    ];
  }
*/