# Repro 0

The error suggests that dune fails to create a certain directory target:

```
> dune build
File "dune.lock/ocaml-compiler.pkg", line 111, characters 3-76:
111 |    https://github.com/ocaml/ocaml/releases/download/5.3.0/ocaml-5.3.0.tar.gz)
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Error: This rule defines a directory target
"checksum/sha256=22c1dd9de21bf43b62d1909041fb5fad648905227bf69550a6a6bef31e654f38/dir"
that matches the requested path
"checksum/sha256=22c1dd9de21bf43b62d1909041fb5fad648905227bf69550a6a6bef31e654f38/dir"
but the rule's action didn't produce it
-> required by _build/_private/default/.pkg/ocaml-compiler/source
-> required by _build/_private/default/.pkg/ocaml-compiler/target
-> required by _build/_private/default/.pkg/ocaml-base-compiler/target/cookie
-> required by loading the OCaml compiler for context "default"
```

... but the directory target is present after dune exits:
```
> ls .\_build\_fetch\checksum\sha256=22c1dd9de21bf43b62d1909041fb5fad648905227bf69550a6a6bef31e654f38\dir\

    Directory: C:\Users\s\src\dune-windows-repros\repro0-compiler-configure-script\_build\_fetch\checksum\sha256=22c1dd9de21bf4
3b62d1909041fb5fad648905227bf69550a6a6bef31e654f38\dir

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d----          08/01/2025    20:01                .github
d----          08/01/2025    20:01                api_docgen
d----          08/01/2025    20:01                asmcomp
d----          08/01/2025    20:01                boot
d----          08/01/2025    20:01                build-aux
d----          08/01/2025    20:01                bytecomp
d----          08/01/2025    20:01                compilerlibs
d----          08/01/2025    20:01                debugger
d----          08/01/2025    20:01                driver
d----          08/01/2025    20:01                file_formats
d----          08/01/2025    20:01                flexdll
d----          08/01/2025    20:01                lambda
d----          08/01/2025    20:01                lex
d----          08/01/2025    20:01                man
d----          08/01/2025    20:01                manual
d----          08/01/2025    20:01                middle_end
d----          08/01/2025    20:01                ocamldoc
d----          08/01/2025    20:01                ocamltest
d----          08/01/2025    20:01                otherlibs
d----          08/01/2025    20:01                parsing
d----          08/01/2025    20:01                release-info
d----          08/01/2025    20:01                runtime
d----          08/01/2025    20:01                stdlib
d----          08/01/2025    20:01                testsuite
d----          08/01/2025    20:01                tools
d----          08/01/2025    20:01                toplevel
d----          08/01/2025    20:01                typing
d----          08/01/2025    20:01                utils
d----          08/01/2025    20:01                winpthreads
d----          08/01/2025    20:01                yacc
-ar--          08/01/2025    20:01         310235 .depend
-ar--          08/01/2025    20:01            980 .depend.menhir
-ar--          08/01/2025    20:01          10201 .gitattributes
-ar--          08/01/2025    20:01           7685 .gitignore
-ar--          08/01/2025    20:01            188 .gitmodules
-ar--          08/01/2025    20:01           5912 .mailmap
-ar--          08/01/2025    20:01             32 .ocp-indent
-ar--          08/01/2025    20:01          17270 aclocal.m4
-ar--          08/01/2025    20:01           2299 appveyor.yml
-ar--          08/01/2025    20:01           3972 BOOTSTRAP.adoc
-ar--          08/01/2025    20:01         639246 Changes
-ar--          08/01/2025    20:01            312 CODE_OF_CONDUCT.md
-ar--          08/01/2025    20:01         659478 configure
-ar--          08/01/2025    20:01          92903 configure.ac
-ar--          08/01/2025    20:01          19220 CONTRIBUTING.md
-ar--          08/01/2025    20:01           7794 dune
-ar--          08/01/2025    20:01             76 dune-project
-ar--          08/01/2025    20:01          31316 HACKING.adoc
-ar--          08/01/2025    20:01           7663 INSTALL.adoc
-ar--          08/01/2025    20:01          27179 LICENSE
-ar--          08/01/2025    20:01          96125 Makefile
-ar--          08/01/2025    20:01           3624 Makefile.best_binaries
-ar--          08/01/2025    20:01           6705 Makefile.build_config.in
-ar--          08/01/2025    20:01          16613 Makefile.common
-ar--          08/01/2025    20:01           1585 Makefile.config_if_required
-ar--          08/01/2025    20:01           6968 Makefile.config.in
-ar--          08/01/2025    20:01           2051 Makefile.dev
-ar--          08/01/2025    20:01          11453 Makefile.menhir
-ar--          08/01/2025    20:01             98 ocaml-variants.install
-ar--          08/01/2025    20:01           5420 ocaml-variants.opam
-ar--          08/01/2025    20:01           7773 README.adoc
-ar--          08/01/2025    20:01          14095 README.win32.adoc
-ar--          08/01/2025    20:01            579 VERSION
```

The workaround is to use `ocaml-system` which avoids the need for Dune to
install the compiler package.
