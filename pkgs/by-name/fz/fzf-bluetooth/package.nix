{ pkgs, stdenv, fetchFromGitHub, runCommand, bluez, fzf, bash }:
stdenv.mkDerivation rec {
  pname = "fzf-bluetooth";
  version = "0.0.1";
  src = fetchFromGitHub {
    owner = "varbhat";
    repo = "fzf-bluetooth";
    rev = "v0.0.1";
    hash = "sha256-j0ssvc6vS6tvDg3BCdCPSWCPNP03IwzDhTI8Bo1nEQs=";
  };
  dontBuild = true;
  installPhase = ''
runHook preInstall

mkdir -p $out/bin
cat - fzf-bluetooth > $out/bin/fzf-bluetooth <<EOF
#!/usr/bin/env bash

export PATH="$PATH:${bluez}/bin:${fzf}/bin"
EOF
chmod +x $out/bin/fzf-bluetooth
runHook postInstall
'';
  propagatedBuildInputs = [ bluez fzf bash ];
  passthru.tests.simple = runCommand "${pname}-test" {} ''
fzf-bluetooth
'';
}
