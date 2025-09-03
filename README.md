# Dune Windows Repros

While working on [Alice](https://www.gridbugs.org/porting-my-toy-ocaml-build-system-to-windows/)
I needed to build the `ocaml-lsp-server` and `ocamlformat` packages for Windows
using Dune package management. This highlighted a number of issues with Dune
package management on Windows. This repo is an attempt to isolate each issue
with a minimal reproduction case.

These reproduction cases were made for Dune 3.20.1.
