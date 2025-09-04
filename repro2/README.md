# Repro 2

Dune's `BUILD_PATH_PREFIX_MAP` environment variable is a colon-separated list
of `key=value` pairs. One of the entries in this list must contain an absolute
path (beginning with `C:\`), and the colon following the drive letter is being
treated as a separator.

```
> dune build
File "dune.lock/ocamlfind.pkg", line 36, characters 7-14:
36 |   (run %{make} all)
            ^^^^^^^
Error: Logs for package ocamlfind
>> Fatal error: Invalid value for the environment variable BUILD_PATH_PREFIX_MAP: invalid key/value pair "C", no '=' separator
Fatal error: exception Misc.Fatal_error
make[1]: *** [Makefile:181: fl_compat.cmo] Error 2
make: *** [Makefile:14: all] Error 2
```

The workaround is to rebuild Dune after applying the following patch:
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
