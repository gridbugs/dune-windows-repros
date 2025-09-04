# Dune Windows Repros

While working on [Alice](https://www.gridbugs.org/porting-my-toy-ocaml-build-system-to-windows/)
I needed to build the `ocaml-lsp-server` and `ocamlformat` packages for Windows
using Dune package management. This highlighted a number of issues with Dune
package management on Windows. This repo is an attempt to isolate each issue
with a minimal reproduction case.

These reproduction cases were made for Dune 3.20.1.

Most of these reproduction cases require installing Alice's relocatable binary
compiler release. Install msys2 and use its `sh` program to run [this
script](https://github.com/alicecaml/alice/blob/main/boot/x86_64-windows.sh),
then add `$HOME\.alice\current\bin` to your PATH. This is requried to work
around issues Dune has installing the compiler issue which mask other issues
with Dune package management on Windows.
