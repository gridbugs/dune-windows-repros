# Repro 4

Here we depend on `ocamlbuild` and it fails to build with:
```
> dune build
Error: opendir(): No such file or directory
-> required by
   _build/_fetch/checksum/sha512=9bf33e2e3cd70495c6ff5987f7e8c1c2fb3dccb02da490140726fed3b374489cb93d500f57bea32a1a71da1c9d3dd207e476109d1aaa759f54c3ef07d5b7ccd8/dir
-> required by _build/_private/default/.pkg/ocamlbuild/source
-> required by _build/_private/default/.pkg/ocamlbuild/target
```

Building a second time gives a different error:
```
> dune build
Error: opendir(): No such file or directory
-> required by
   _build/_fetch/checksum/sha512=9bf33e2e3cd70495c6ff5987f7e8c1c2fb3dccb02da490140726fed3b374489cb93d500f57bea32a1a71da1c9d3dd207e476109d1aaa759f54c3ef07d5b7ccd8/dir
-> required by _build/_private/default/.pkg/ocamlbuild/source
-> required by _build/_private/default/.pkg/ocamlbuild/target
```

Running `dune clean` also fails:
```
> dune clean
Error:
rmdir(_build\_fetch\checksum\sha512=9bf33e2e3cd70495c6ff5987f7e8c1c2fb3dccb02da490140726fed3b374489cb93d500f57bea32a1a71da1c9d3dd207e476109d1aaa759f54c3ef07d5b7ccd8\dir\samples): Directory not empty
```
