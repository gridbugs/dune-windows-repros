# Repro 6

Dune can't find the `menhir` executable even though the `menhir` executable was built successfully:

```
> dune build
File "dune", lines 1-2, characters 0-27:
1 | (menhir
2 |  (modules parser))
Error: Program menhir not found in the tree or in PATH
 (context: default)
Hint: opam install menhir
```

...even though:

```
> ls .\_build\_private\default\.pkg\menhir\target\bin\menhir.exe

    Directory: C:\Users\s\src\dune-windows-repros\repro6\_build\_private\default\.pkg\menhir\target\bin

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-ar--          04/09/2025    18:35        9523600 menhir.exe
```
