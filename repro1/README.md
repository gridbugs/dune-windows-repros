# Repro 1

Github issue: https://github.com/ocaml/dune/issues/11174

Dune can't build packages whose build/install commands run a script as though it
were an executable file (ie. a text file beginning with a shebang). Several
low-level packages such as `ocamlfind` use a `configure` script which does not
work on windows for this reason.

```
> dune build
Error: CreateProcess(): Exec format error
-> required by _build/_private/default/.pkg/ocamlfind/target
```

The workaround is to replace invocations of `./configure` with `sh configure`
(assuming `sh` is installed).
