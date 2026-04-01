# 20 "i18n_generate.mll"
 
type i18n_expr =
  | Var of string                    (* {{ user }} *)
  | Var_typed of string * string     (* {{ n %.2f }} *)
  | Str of string                    (* This is a string *)
  | Cond of string * string * string (* {{{ many ? s || }}} *)

let flush buffer acc =
  let acc = match String.escaped (Buffer.contents buffer) with
    | "" -> acc
    | x -> Str x :: acc in
  Buffer.clear buffer
; acc

# 17 "i18n_generate.ml"
let __ocaml_lex_tables = {
  Lexing.lex_base =
   "\000\000\254\255\075\000\255\255\001\000\254\255\255\255\002\000\
    \010\000\251\255\252\255\011\000\103\000\222\000\251\000\025\001\
    \116\001\255\255\000\000\011\000\012\000\013\000\254\255\249\000\
    \014\000\041\000\253\255\119\000\254\255\043\000\255\255\121\000\
    \254\255\043\000\044\000\255\255";
  Lexing.lex_backtrk =
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \003\000\255\255\255\255\004\000\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\001\000\255\255\255\255\
    \255\255\001\000\255\255\255\255";
  Lexing.lex_default =
   "\255\255\000\000\255\255\000\000\007\000\000\000\000\000\007\000\
    \009\000\000\000\000\000\255\255\255\255\255\255\255\255\255\255\
    \255\255\000\000\255\255\023\000\255\255\255\255\000\000\023\000\
    \255\255\255\255\000\000\028\000\000\000\255\255\000\000\032\000\
    \000\000\255\255\255\255\000\000";
  Lexing.lex_trans =
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\006\000\006\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\010\000\255\255\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \018\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\255\255\000\000\021\000\000\000\000\000\
    \000\000\000\000\019\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\017\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\025\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\003\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\002\000\
    \000\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
    \002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
    \002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
    \002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
    \002\000\002\000\002\000\002\000\002\000\011\000\012\000\014\000\
    \255\255\022\000\020\000\026\000\002\000\002\000\002\000\002\000\
    \002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
    \002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
    \002\000\002\000\002\000\002\000\002\000\002\000\024\000\030\000\
    \034\000\035\000\002\000\000\000\002\000\002\000\002\000\002\000\
    \002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
    \002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
    \002\000\002\000\002\000\002\000\002\000\002\000\013\000\000\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \013\000\013\000\015\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\029\000\000\000\000\000\033\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\021\000\000\000\
    \001\000\005\000\255\255\019\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\255\255\255\255\000\000\000\000\013\000\013\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \000\000\025\000\000\000\014\000\000\000\000\000\000\000\013\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \013\000\015\000\000\000\000\000\000\000\013\000\000\000\013\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \013\000\000\000\013\000\020\000\013\000\013\000\013\000\013\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\024\000\255\255\
    \016\000\255\255\016\000\016\000\016\000\016\000\016\000\016\000\
    \016\000\016\000\016\000\016\000\016\000\016\000\016\000\016\000\
    \016\000\016\000\016\000\016\000\016\000\016\000\016\000\016\000\
    \016\000\016\000\016\000\016\000\018\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\016\000\016\000\016\000\016\000\
    \016\000\016\000\016\000\016\000\016\000\016\000\000\000\000\000\
    \000\000\000\000\000\000\017\000\000\000\016\000\016\000\016\000\
    \016\000\016\000\016\000\016\000\016\000\016\000\016\000\016\000\
    \016\000\016\000\016\000\016\000\016\000\016\000\016\000\016\000\
    \016\000\016\000\016\000\016\000\016\000\016\000\016\000\000\000\
    \000\000\000\000\000\000\016\000\000\000\016\000\016\000\016\000\
    \016\000\016\000\016\000\016\000\016\000\016\000\016\000\016\000\
    \016\000\016\000\016\000\016\000\016\000\016\000\016\000\016\000\
    \016\000\016\000\016\000\016\000\016\000\016\000\016\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\255\255\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000";
  Lexing.lex_check =
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\004\000\007\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\008\000\008\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \018\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\019\000\255\255\021\000\255\255\255\255\
    \255\255\255\255\021\000\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\018\000\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\025\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\002\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\000\000\
    \255\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\002\000\002\000\002\000\002\000\002\000\
    \002\000\002\000\002\000\002\000\002\000\008\000\011\000\012\000\
    \019\000\020\000\021\000\024\000\002\000\002\000\002\000\002\000\
    \002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
    \002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
    \002\000\002\000\002\000\002\000\002\000\002\000\025\000\029\000\
    \033\000\034\000\002\000\255\255\002\000\002\000\002\000\002\000\
    \002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
    \002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
    \002\000\002\000\002\000\002\000\002\000\002\000\012\000\255\255\
    \012\000\012\000\012\000\012\000\012\000\012\000\012\000\012\000\
    \012\000\012\000\012\000\012\000\012\000\012\000\012\000\012\000\
    \012\000\012\000\012\000\012\000\012\000\012\000\012\000\012\000\
    \012\000\012\000\012\000\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\027\000\255\255\255\255\031\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\013\000\255\255\
    \000\000\004\000\007\000\013\000\255\255\255\255\255\255\255\255\
    \255\255\255\255\008\000\019\000\255\255\255\255\013\000\013\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \255\255\023\000\255\255\014\000\255\255\255\255\255\255\013\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \013\000\015\000\255\255\255\255\255\255\013\000\255\255\013\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \013\000\255\255\014\000\013\000\014\000\014\000\014\000\014\000\
    \014\000\014\000\014\000\014\000\014\000\014\000\014\000\014\000\
    \014\000\014\000\014\000\014\000\014\000\014\000\014\000\014\000\
    \014\000\014\000\014\000\014\000\014\000\014\000\023\000\027\000\
    \015\000\031\000\015\000\015\000\015\000\015\000\015\000\015\000\
    \015\000\015\000\015\000\015\000\015\000\015\000\015\000\015\000\
    \015\000\015\000\015\000\015\000\015\000\015\000\015\000\015\000\
    \015\000\015\000\015\000\015\000\016\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\016\000\016\000\016\000\016\000\
    \016\000\016\000\016\000\016\000\016\000\016\000\255\255\255\255\
    \255\255\255\255\255\255\016\000\255\255\016\000\016\000\016\000\
    \016\000\016\000\016\000\016\000\016\000\016\000\016\000\016\000\
    \016\000\016\000\016\000\016\000\016\000\016\000\016\000\016\000\
    \016\000\016\000\016\000\016\000\016\000\016\000\016\000\255\255\
    \255\255\255\255\255\255\016\000\255\255\016\000\016\000\016\000\
    \016\000\016\000\016\000\016\000\016\000\016\000\016\000\016\000\
    \016\000\016\000\016\000\016\000\016\000\016\000\016\000\016\000\
    \016\000\016\000\016\000\016\000\016\000\016\000\016\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\023\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255";
  Lexing.lex_base_code =
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\027\000\119\000\147\000\178\000\
    \253\000\029\000\000\000\055\000\000\000\000\000\037\000\056\000\
    \000\000\000\000\042\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000";
  Lexing.lex_backtrk_code =
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000";
  Lexing.lex_default_code =
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\034\000\000\000\000\000\000\000\034\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000";
  Lexing.lex_trans_code =
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \023\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\001\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\006\000\001\000\013\000\013\000\013\000\013\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\020\000\023\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\013\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \013\000\000\000\000\000\001\000\000\000\000\000\000\000\000\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \013\000\013\000\020\000\000\000\000\000\000\000\013\000\000\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \013\000\013\000\013\000\000\000\013\000\013\000\013\000\013\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\000\000\000\000\
    \000\000\026\000\000\000\026\000\026\000\026\000\026\000\026\000\
    \026\000\026\000\026\000\026\000\026\000\026\000\026\000\026\000\
    \026\000\026\000\026\000\026\000\026\000\026\000\026\000\026\000\
    \026\000\026\000\026\000\026\000\026\000\026\000\026\000\026\000\
    \026\000\026\000\026\000\026\000\026\000\026\000\026\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\026\000\026\000\
    \026\000\026\000\026\000\026\000\026\000\026\000\026\000\026\000\
    \026\000\026\000\026\000\026\000\026\000\026\000\026\000\026\000\
    \026\000\026\000\026\000\026\000\026\000\026\000\026\000\026\000\
    \000\000\000\000\000\000\000\000\026\000\000\000\026\000\026\000\
    \026\000\026\000\026\000\026\000\026\000\026\000\026\000\026\000\
    \026\000\026\000\026\000\026\000\026\000\026\000\026\000\026\000\
    \026\000\026\000\026\000\026\000\026\000\026\000\026\000\026\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000";
  Lexing.lex_check_code =
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \021\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\012\000\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\019\000\
    \023\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\012\000\011\000\012\000\012\000\012\000\012\000\
    \012\000\012\000\012\000\012\000\012\000\012\000\012\000\012\000\
    \012\000\012\000\012\000\012\000\012\000\012\000\012\000\012\000\
    \012\000\012\000\012\000\012\000\012\000\012\000\012\000\013\000\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\013\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \013\000\255\255\255\255\014\000\019\000\023\000\255\255\255\255\
    \013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \013\000\013\000\015\000\255\255\255\255\255\255\013\000\255\255\
    \013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
    \013\000\013\000\014\000\255\255\014\000\014\000\014\000\014\000\
    \014\000\014\000\014\000\014\000\014\000\014\000\014\000\014\000\
    \014\000\014\000\014\000\014\000\014\000\014\000\014\000\014\000\
    \014\000\014\000\014\000\014\000\014\000\014\000\255\255\255\255\
    \255\255\015\000\255\255\015\000\015\000\015\000\015\000\015\000\
    \015\000\015\000\015\000\015\000\015\000\015\000\015\000\015\000\
    \015\000\015\000\015\000\015\000\015\000\015\000\015\000\015\000\
    \015\000\015\000\015\000\015\000\015\000\016\000\016\000\016\000\
    \016\000\016\000\016\000\016\000\016\000\016\000\016\000\019\000\
    \023\000\255\255\255\255\255\255\255\255\255\255\016\000\016\000\
    \016\000\016\000\016\000\016\000\016\000\016\000\016\000\016\000\
    \016\000\016\000\016\000\016\000\016\000\016\000\016\000\016\000\
    \016\000\016\000\016\000\016\000\016\000\016\000\016\000\016\000\
    \255\255\255\255\255\255\255\255\016\000\255\255\016\000\016\000\
    \016\000\016\000\016\000\016\000\016\000\016\000\016\000\016\000\
    \016\000\016\000\016\000\016\000\016\000\016\000\016\000\016\000\
    \016\000\016\000\016\000\016\000\016\000\016\000\016\000\016\000\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255";
  Lexing.lex_code =
   "\255\005\255\004\255\255\008\255\007\255\006\255\255\007\255\006\
    \255\008\255\255\009\255\255\008\255\255\010\255\255\000\009\001\
    \010\255\011\255\255\000\004\001\006\255\000\005\001\007\002\008\
    \003\011\255";
}

let rec parse_lines langs acc lexbuf =
   __ocaml_lex_parse_lines_rec langs acc lexbuf 0
and __ocaml_lex_parse_lines_rec langs acc lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
let
# 42 "i18n_generate.mll"
           key
# 360 "i18n_generate.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos (lexbuf.Lexing.lex_curr_pos + -1) in
# 42 "i18n_generate.mll"
                     (
      (* FIXME: Will break if List.map change its order of execution *)
      let tr = List.map (fun lang ->
        (lang, parse_expr (Buffer.create 0) [] lexbuf) ) langs in
    eol langs ((key, tr) :: acc) lexbuf )
# 368 "i18n_generate.ml"

  | 1 ->
# 47 "i18n_generate.mll"
        ( List.rev acc )
# 373 "i18n_generate.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_parse_lines_rec langs acc lexbuf __ocaml_lex_state

and eol langs acc lexbuf =
   __ocaml_lex_eol_rec langs acc lexbuf 4
and __ocaml_lex_eol_rec langs acc lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 50 "i18n_generate.mll"
                  ( Lexing.new_line lexbuf
    ; parse_lines langs acc lexbuf)
# 386 "i18n_generate.ml"

  | 1 ->
# 52 "i18n_generate.mll"
        ( List.rev acc )
# 391 "i18n_generate.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_eol_rec langs acc lexbuf __ocaml_lex_state

and parse_expr buffer acc lexbuf =
  lexbuf.Lexing.lex_mem <- Array.make 12 (-1); __ocaml_lex_parse_expr_rec buffer acc lexbuf 8
and __ocaml_lex_parse_expr_rec buffer acc lexbuf __ocaml_lex_state =
  match Lexing.new_engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
let
# 56 "i18n_generate.mll"
                      c
# 404 "i18n_generate.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_mem.(0) lexbuf.Lexing.lex_mem.(1) in
# 56 "i18n_generate.mll"
                                  (
      let s1 = parse_string_1 (Buffer.create 0) lexbuf in
      let s2 = parse_string_2 (Buffer.create 0) lexbuf in
      let acc = flush buffer acc in
      parse_expr buffer (Cond (c, s1, s2) :: acc) lexbuf
    )
# 413 "i18n_generate.ml"

  | 1 ->
let
# 63 "i18n_generate.mll"
                     x
# 419 "i18n_generate.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_mem.(0) lexbuf.Lexing.lex_mem.(1) in
# 63 "i18n_generate.mll"
                                  (
      let acc = flush buffer acc in
      parse_expr buffer (Var x :: acc) lexbuf )
# 425 "i18n_generate.ml"

  | 2 ->
let
# 67 "i18n_generate.mll"
                     x
# 431 "i18n_generate.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_mem.(0) lexbuf.Lexing.lex_mem.(1)
and
# 67 "i18n_generate.mll"
                                                  f
# 436 "i18n_generate.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_mem.(2) lexbuf.Lexing.lex_mem.(3) in
# 67 "i18n_generate.mll"
                                                                (
      let acc = flush buffer acc in
      parse_expr buffer (Var_typed (x, f) :: acc) lexbuf )
# 442 "i18n_generate.ml"

  | 3 ->
# 71 "i18n_generate.mll"
              ( List.rev (flush buffer acc ) )
# 447 "i18n_generate.ml"

  | 4 ->
let
# 73 "i18n_generate.mll"
                     c
# 453 "i18n_generate.ml"
= Lexing.sub_lexeme_char lexbuf lexbuf.Lexing.lex_start_pos in
# 73 "i18n_generate.mll"
                       ( Buffer.add_char buffer c
         ; parse_expr buffer acc lexbuf )
# 458 "i18n_generate.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_parse_expr_rec buffer acc lexbuf __ocaml_lex_state

and parse_string_1 buffer lexbuf =
   __ocaml_lex_parse_string_1_rec buffer lexbuf 27
and __ocaml_lex_parse_string_1_rec buffer lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 77 "i18n_generate.mll"
         ( String.escaped (Buffer.contents buffer) )
# 470 "i18n_generate.ml"

  | 1 ->
let
# 78 "i18n_generate.mll"
         c
# 476 "i18n_generate.ml"
= Lexing.sub_lexeme_char lexbuf lexbuf.Lexing.lex_start_pos in
# 78 "i18n_generate.mll"
           ( Buffer.add_char buffer c
    ; parse_string_1 buffer lexbuf )
# 481 "i18n_generate.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_parse_string_1_rec buffer lexbuf __ocaml_lex_state

and parse_string_2 buffer lexbuf =
   __ocaml_lex_parse_string_2_rec buffer lexbuf 31
and __ocaml_lex_parse_string_2_rec buffer lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 82 "i18n_generate.mll"
          ( String.escaped (Buffer.contents buffer) )
# 493 "i18n_generate.ml"

  | 1 ->
let
# 83 "i18n_generate.mll"
         c
# 499 "i18n_generate.ml"
= Lexing.sub_lexeme_char lexbuf lexbuf.Lexing.lex_start_pos in
# 83 "i18n_generate.mll"
           ( Buffer.add_char buffer c
    ; parse_string_2 buffer lexbuf )
# 504 "i18n_generate.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_parse_string_2_rec buffer lexbuf __ocaml_lex_state

;;

# 86 "i18n_generate.mll"
 

let print_list_of_languages_eliom fmt ~variants =
  Format.fprintf fmt
    "let%%shared languages = [%a]\n"
    (Format.pp_print_list
      ~pp_sep:(fun fmt () -> Format.pp_print_string fmt ";")
      Format.pp_print_string) variants

let print_list_of_languages fmt ~variants =
  Format.fprintf fmt
    "let languages = [%a]\n"
    (Format.pp_print_list
      ~pp_sep:(fun fmt () -> Format.pp_print_string fmt ";")
      Format.pp_print_string) variants

let print_type_eliom fmt ~variants =
  Format.fprintf fmt
    "[%%%%shared type t = %a [@@@@deriving json]]\n\
     [%%%%shared exception Unknown_language of string]\n"
    (Format.pp_print_list
      ~pp_sep:(fun fmt () -> Format.pp_print_string fmt "|")
      Format.pp_print_string) variants

let print_type fmt ~variants =
  Format.fprintf fmt
    "type t = %a\n\
     exception Unknown_language of string\n"
    (Format.pp_print_list
      ~pp_sep:(fun fmt () -> Format.pp_print_string fmt "|")
      Format.pp_print_string) variants

let print_generated_functions_eliom fmt ?primary_module ~default_language () =
  let server_language_reference =
    match primary_module with
    | None -> "Eliom.Reference.Volatile.eref\n\
               ~scope:Eliom.Common.default_process_scope default_language"
    | Some module_name -> module_name ^ "._language_"
  and client_language_reference =
    match primary_module with
    | None -> "ref default_language"
    | Some module_name -> module_name ^ "._language_"
  and default_lang =
    match primary_module with
    | None -> "let%shared default_language = " ^ default_language ^ "\n"
    | Some module_name -> ""
  in
  Format.pp_print_string fmt @@
  default_lang ^
  "let%server _language_ = " ^ server_language_reference ^ "\n\
  let%server get_language () = Eliom.Reference.Volatile.get _language_\n\
  let%server set_language language = \n\
  Eliom.Reference.Volatile.set _language_ language\n\
  \n\
  let%client _language_ = " ^ client_language_reference ^ "\n\
  let%client get_language () = !_language_\n\
  let%client set_language language = _language_ := language\n\
  \n\
  let%shared txt = Eliom.Content.Html.F.txt\n\
  "

let print_generated_functions fmt ?primary_module ~default_language () =
  let default_lang =
    match primary_module with
    | None -> "let default_language = " ^ default_language ^ "\n"
    | Some module_name -> "let default_language = " ^ module_name ^ ".default_language\n"
  in
  let language =
    match primary_module with
    | None -> "default_language"
    | Some module_name -> module_name ^ "._language_"
  in
  Format.pp_print_string fmt @@
  default_lang ^
  "(* We use a reference to store the language by default.\n\
      Customize these functions if needed.\n\
      For example use a scoped reference if you are using Eliom\n\
      and want the language to depend on a session/tab or session group. *)\n\
   let _language_ = ref " ^ language ^ "\n\
   let get_language () = !_language_\n\
   let set_language language = _language_ := language\n\
   \n\
  "

(** Print the function [string_of_language] returning the string representation of a
    value o type t. The string representation is simply the value as a string. For
    example, the string representation of [Us] is ["Us"]
*)

let helper_print_string_of_language ~eliom fmt ~variants ~strings =
  Format.pp_print_string fmt
  (if eliom then "let%shared string_of_language = function \n"
   else "let string_of_language = function \n") ;
  List.iter2 (fun v s -> Format.fprintf fmt "| %s -> %S" v s)
    variants strings ;
  Format.pp_print_string fmt "\n"
let print_string_of_language_eliom = helper_print_string_of_language ~eliom:true

let print_string_of_language = helper_print_string_of_language ~eliom:false

(** Print the function [language_of_string] returning the value of type t which
    corresponds to the given string. The exception [Unknown_language] is raised with
    the given string if the language doesn't exist.
*)

let helper_print_language_of_string ~eliom fmt ~variants ~strings =
  Format.pp_print_string fmt
  (if eliom then "let%shared language_of_string = function\n"
   else "let language_of_string = function\n") ;
  List.iter2 (fun v s -> Format.fprintf fmt "| %S -> %s" s v)
    variants strings ;
  Format.pp_print_string fmt "| s -> raise (Unknown_language s)\n"

let print_language_of_string_eliom  = helper_print_language_of_string ~eliom:true
let print_language_of_string = helper_print_language_of_string ~eliom:false

let helper_print_guess_language_of_string ~eliom fmt =
  let prefix = if eliom then "let%shared " else "let " in
  Format.pp_print_string fmt
    (prefix ^ "guess_language_of_string s = \n\
      try language_of_string s \n\
      with Unknown_language _ as e -> \n\
      try language_of_string (String.sub s 0 (String.index s '-')) \n\
      with Not_found -> \n\
      raise e \n")

let print_guess_language_of_string_eliom =
  helper_print_guess_language_of_string ~eliom:true

let print_guess_language_of_string =
  helper_print_guess_language_of_string ~eliom:false


let print_header_eliom output variants strings =
  print_type_eliom output ~variants ;
  print_string_of_language_eliom output ~variants ~strings ;
  print_language_of_string_eliom output ~variants ~strings ;
  print_guess_language_of_string_eliom output

let print_header ~tyxml output variants strings primary_module default_language =
  if tyxml then Format.fprintf output "open Tyxml.Html\n" ;
  print_type output ~variants ;
  print_string_of_language output ~variants ~strings ;
  print_language_of_string output ~variants ~strings ;
  print_guess_language_of_string output ;
  print_list_of_languages output ~variants ;
  print_generated_functions output ?primary_module ~default_language ()

type arg = M of string | O of string

let print_module_body ?primary_module print_expr =
  let args languages =
    let rec f a =
      function [] -> List.rev a
             | Var x :: t          -> f (M x :: a) t
             | Var_typed (x, _) :: t -> f (M x :: a) t
             | Cond (x, _, _) :: t -> f (O x :: a) t
             | _ :: t              -> f a t in
    List.map (f []) languages
    |> List.flatten
    |> List.sort_uniq compare in
  let print_args fmt args =
    Format.pp_print_list
      ~pp_sep:(fun fmt () -> Format.pp_print_char fmt ' ')
      (fun fmt -> function
         | M x -> Format.fprintf fmt "~%s" x
         | O x -> Format.fprintf fmt "?(%s=false)" x) fmt args in
  let get_language = match primary_module with
    | Some pm -> pm ^ ".get_language ()"
    | None -> "get_language ()" in
  Format.pp_print_list
    ~pp_sep:(fun fmt () -> Format.pp_print_string fmt "\n")
    (fun fmt (key, tr) ->
       let args = args (List.map snd tr) in
       Format.fprintf fmt "let %s ?(lang = %s) () %a () =\n\
                           match lang with\n%a"
         key
         get_language
         print_args args
         (Format.pp_print_list
            ~pp_sep:(fun fmt () -> Format.pp_print_string fmt "\n")
            (fun fmt (language, tr) ->
               Format.fprintf fmt "| %s -> %a"
                 language print_expr tr) ) tr )

let pp_print_list fmt printer =
  Format.fprintf fmt "[%a]"
    (Format.pp_print_list
       ~pp_sep:(fun fmt () -> Format.pp_print_string fmt ";")
       printer)

let print_expr_html fmt key_values =
  let print_key_value fmt =
    function
    | Str s -> Format.fprintf fmt "[txt \"%s\"]" s
    | Var v -> Format.pp_print_string fmt v
    | Var_typed (v, f) ->
      Format.fprintf fmt "[txt (Printf.sprintf \"%s\" %s)]" f v
    | Cond (c, s1, s2) ->
      Format.fprintf fmt "[txt (if %s then \"%s\" else \"%s\")]"
        c s1 s2
  in
  match key_values with
  | [] ->
    assert false
  | [key_value] ->
    print_key_value fmt key_value
  | _ ->
    Format.fprintf fmt "List.flatten " ;
    pp_print_list fmt print_key_value key_values

let print_expr_string fmt key_values =
  let print_key_value fmt =
    function
    | Str s -> Format.fprintf fmt "\"%s\"" s
    | Var v -> Format.pp_print_string fmt v
    | Var_typed (v, f) ->
      Format.fprintf fmt "(Printf.sprintf \"%s\" %s)" f v
    | Cond (c, s1, s2) ->
      Format.fprintf fmt "(if %s then \"%s\" else \"%s\")"
        c s1 s2
  in
  match key_values with
  | [] ->
    assert false
  | [key_value] ->
    print_key_value fmt key_value
  | _ ->
    Format.fprintf fmt "String.concat \"\" " ;
    pp_print_list fmt print_key_value key_values

let print_body_eliom output key_values =
  Format.pp_print_string output "[%%shared\n" ;
  Format.fprintf output "module Tr = struct\n" ;
  print_module_body print_expr_html output key_values ;
  Format.fprintf output "\nmodule S = struct\n" ;
  print_module_body print_expr_string output key_values ;
  Format.fprintf output "\nend\n" ;
  Format.fprintf output "end\n" ;
  Format.pp_print_string output "]\n"

let print_body ~tyxml output key_values primary_module =
  Format.fprintf output "module Tr = struct\n" ;
  if tyxml then print_module_body ?primary_module print_expr_html output key_values ;
  if tyxml then Format.fprintf output "\nmodule S = struct\n" ;
  print_module_body ?primary_module print_expr_string output key_values ;
  Format.fprintf output "\nend\n" ;
  if tyxml then Format.fprintf output "end\n"

let input_file = ref "-"
let output_file = ref "-"
let eliom_generation = ref false
let tyxml_generation = ref false
let header = ref false
let languages = ref ""
let default_language = ref ""
let external_type = ref false
let primary_file = ref ""
let options = Arg.align
    [ ( "--languages", Arg.Set_string languages
      , " Comma-separated languages (e.g. en,fr-fr, or Foo.Fr,Foo.Us if \
         using external types). \
         Must be ordered as in source TSV file.")
    ; ( "--default-language", Arg.Set_string default_language
      , " Set the default language (default is the first one in --languages).")
    ; ( "--input-file", Arg.Set_string input_file
      , " TSV file containing keys and translations. \
         If option is omited or set to -, read on stdin.")
    ; ( "--output-file", Arg.Set_string output_file
      , " File TSV file containing keys and translations. \
         If option is omited or set to -, write on stdout.")
    ; ( "--external-type", Arg.Set external_type
      , " Values passed to --languages option come from a predefined type \
         (do not generate the type nor from/to string functions).")
    ; ( "--primary", Arg.Set_string primary_file
      , " Generated file is secondary and depends on given primary file.")
    ; ( "--eliom", Arg.Set eliom_generation
      , " Generate code for a client-server Eliom app (implies --tyxml).")
    ; ( "--tyxml", Arg.Set tyxml_generation
      , " Generate code for a Tyxml-based app (for example a server-side Eliom app).")
    ; ( "--header", Arg.Set header
      , " Generate only the file header.")
    ]

let usage = "usage: ocsigen-i18n [options] [< input] [> output]"

let _ = Arg.parse options (fun s -> ()) usage
let () = if !eliom_generation then tyxml_generation := true

let normalize_type ?primary_module s =
  let constr =
    String.lowercase_ascii s
    |> Str.(global_replace (regexp "-") "_")
    |> String.capitalize_ascii
  in
  match primary_module with
  | None -> constr
  | Some module_name -> module_name ^ "." ^ constr

let _ =
  let out_chan =
    match !output_file with
    | "-" -> stdout
    | file -> open_out file in
  let primary_module = match !primary_file with
    | "" -> None
    | file -> let base = Filename.remove_extension file in
      Some (String.capitalize_ascii base)
  in
  let strings = Str.split (Str.regexp ",") !languages in
  let variants =
    if !primary_file = "" || not (!external_type)
    then List.map (normalize_type ?primary_module) strings
    else strings in
  let default_language =
    match !default_language with
    | "" -> (List.hd variants)
    | x ->
      let x = normalize_type ?primary_module x in
      assert (List.mem x variants) ;
      x in
  let output = Format.formatter_of_out_channel out_chan in
  let tyxml = !tyxml_generation in
  if !header then (
    if !eliom_generation then (
      print_header_eliom output variants strings ;
      print_list_of_languages_eliom output ~variants ;
      print_generated_functions_eliom output ?primary_module ~default_language ()
    ) else
      print_header ~tyxml output variants strings primary_module default_language
  ) else (
    let in_chan =
      match !input_file with
      | "-" -> stdin
      | file -> open_in file in
    let lexbuf = Lexing.from_channel in_chan in
    (try
       let key_values = parse_lines variants [] lexbuf in
       if !eliom_generation then (
         if primary_module = None && not !external_type then
           print_header_eliom output variants strings ;
         print_list_of_languages_eliom output ~variants ;
         print_generated_functions_eliom output ?primary_module ~default_language () ;
         print_body_eliom output key_values
       ) else (
         if primary_module = None && not !external_type then
           print_header ~tyxml output variants strings primary_module default_language
         else (match primary_module with
           | Some module_name -> Format.fprintf output "open %s \n" module_name
           | None -> ()) ;
         print_body ~tyxml output key_values primary_module
       )
     with Failure _ ->
       failwith (Printf.sprintf "line: %d"
                   lexbuf.Lexing.lex_curr_p.Lexing.pos_lnum)) ;
    close_in in_chan
  ) ;
  close_out out_chan

# 871 "i18n_generate.ml"
