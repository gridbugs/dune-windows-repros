# Repro 5

For this case we depend on `topkg` but its dependency on `ocamlbuild` is
manually removed from the lockdir to avoid the issue from Repro 4. Install
`ocamlbuild` with opam and make sure it's in your PATH for this case.

The build fails while building the `topkg` dependency:
```
> dune build
Error: CreateProcess(): Exec format error
-> required by _build/_private/default/.pkg/topkg/target
```

The build command is:
```
(build
 (run
  ocaml
  pkg/pkg.ml
  build
  --pkg-name
  %{pkg-self:name}
  --dev-pkg
  %{pkg-self:dev}))
```

The `ocaml` referenced there is not the `ocaml` executable from the compiler
package but instead the file
`.\_build\_private\default\.pkg\ocamlfind\target\bin\ocaml` which is a shell
script with contents:
```sh
#!/bin/sh

BINDIR=$(dirname "$(command -v ocamlc)")
"$BINDIR/ocaml" -I "$OCAML_TOPLEVEL_PATH" "$@"
```

This is the same type of problem as in Repro 1 where Windows can't execute
scripts with shebangs. The workaround is to change the build command to:
```
(build
 (run
  sh
  %{pkg:ocamlfind:bin}/ocaml
  pkg/pkg.ml
  build
  --pkg-name
  %{pkg-self:name}
  --dev-pkg
  %{pkg-self:dev}))
```
