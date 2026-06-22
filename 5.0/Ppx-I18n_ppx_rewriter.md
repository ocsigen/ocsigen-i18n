
# Module `Ppx.I18n_ppx_rewriter`

```ocaml
val default_module_name : string Stdlib.ref
```
```ocaml
val module_prefix : string Stdlib.ref
```
```ocaml
val module_suffix : string Stdlib.ref
```
```ocaml
val mk_ident : Ppxlib.longident -> Ppxlib.longident
```
```ocaml
val unit : Ppxlib__.Location.t -> Ppxlib.arg_label * Ppxlib__.Import.expression
```
```ocaml
val lang_args : 
  (Ppxlib.arg_label * 'a) list ->
  (Ppxlib.arg_label * 'a) list * (Ppxlib.arg_label * 'a) list
```
```ocaml
val ident : 
  Ppxlib__.Location.t ->
  Ppxlib.longident ->
  Ppxlib__.Import.expression
```
```ocaml
val apply : 
  Ppxlib__.Location.t ->
  Ppxlib.longident ->
  (Ppxlib__.Import.arg_label * Ppxlib__.Import.expression) list ->
  Ppxlib__.Import.expression
```
```ocaml
val expand : 
  loc:Ppxlib__.Location.t ->
  path:'a ->
  Ppxlib__.Import.expression ->
  Ppxlib__.Import.expression
```
```ocaml
val extension : Ppxlib.Extension.t
```
```ocaml
val rule : Ppxlib.Context_free.Rule.t
```