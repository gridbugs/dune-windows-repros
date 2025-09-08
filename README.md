# Dune Windows Repros

While working on [Alice](https://www.gridbugs.org/porting-my-toy-ocaml-build-system-to-windows/)
I needed to build the `ocaml-lsp-server` and `ocamlformat` packages for Windows
using Dune package management. This highlighted a number of issues with Dune
package management on Windows. This repo is an attempt to isolate each issue
with a minimal reproduction case.

Most of these reproduction cases require installing Alice's relocatable binary
compiler release. Install msys2 and use its `sh` program to run [this
script](https://github.com/alicecaml/alice/blob/main/boot/x86_64-windows.sh),
then add `$HOME\.alice\current\bin` to your PATH. This is requried to work
around issues Dune has installing the compiler issue which mask other issues
with Dune package management on Windows.

These reproduction cases were made for Dune 3.20.1, though all repro cases after
repro2 requiring applying this patch:
```patch
diff --git a/src/dune_util/build_path_prefix_map0.ml b/src/dune_util/build_path_prefix_map0.ml
index e7c23b5eb..30ed8f045 100644
--- a/src/dune_util/build_path_prefix_map0.ml
+++ b/src/dune_util/build_path_prefix_map0.ml
@@ -1,14 +1,4 @@
-open Stdune
+open! Stdune

 let _BUILD_PATH_PREFIX_MAP = "BUILD_PATH_PREFIX_MAP"
-
-let extend_build_path_prefix_map env how map =
-  let new_rules = Build_path_prefix_map.encode_map map in
-  Env.update env ~var:_BUILD_PATH_PREFIX_MAP ~f:(function
-    | None -> Some new_rules
-    | Some existing_rules ->
-      Some
-        (match how with
-         | `Existing_rules_have_precedence -> new_rules ^ ":" ^ existing_rules
-         | `New_rules_have_precedence -> existing_rules ^ ":" ^ new_rules))
-;;
+let extend_build_path_prefix_map env _how _map = env
```

Each repro case contains REAMDE file with an explanation, a dune-workspace file
with opam repos frozen at specific revisions, and a checked-in non-portable
lockdir generated on Windows to help keep build failures reproducible over
time.

See also: https://github.com/ocaml/dune/issues/11161
