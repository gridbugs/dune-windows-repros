# Repro 3

The entries in `ocamlfind.install` omit the `.exe` extension but when the files
they describe are compiled on windows they have a `.exe` extension. This leads
to Dune believing that the files listed in `ocamlfind.install` do not exist.

```
> dune build
Error: entry
_build/.sandbox/b5bb9b241be80d0a0513d55474f899ef/_private/default/.pkg/ocamlfind/source/src/findlib/ocamlfind
in
_build/.sandbox/b5bb9b241be80d0a0513d55474f899ef/_private/default/.pkg/ocamlfind/source/ocamlfind.install
does not exist
-> required by _build/_private/default/.pkg/ocamlfind/target
```

The workaround is to add `(run sed -i "'s/ocamlfind\\(_opt\\)\\?/&.exe/'" ocamlfind.install)`
at the start of the list of install commands to modify `ocamlfind.install` to
add the `.ext` extensions.

This is enough to get the `ocamlfind` package building as a dependency.
