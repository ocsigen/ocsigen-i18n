open Ast

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
    | None -> "Eliom_reference.Volatile.eref\n\
               ~scope:Eliom_common.default_process_scope default_language"
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
  let%server get_language () = Eliom_reference.Volatile.get _language_\n\
  let%server set_language language = \n\
  Eliom_reference.Volatile.set _language_ language\n\
  \n\
  let%client _language_ = " ^ client_language_reference ^ "\n\
  let%client get_language () = !_language_\n\
  let%client set_language language = _language_ := language\n\
  \n\
  let%shared txt = Eliom_content.Html.F.txt\n\
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

let gen_header ~tyxml ~eliom ~variants ~strings ?primary_module
    ~default_language output =
  if eliom then (
    print_header_eliom output variants strings ;
    print_list_of_languages_eliom output ~variants ;
    print_generated_functions_eliom output ?primary_module ~default_language ()
  ) else
    print_header ~tyxml output variants strings primary_module default_language

let gen_module ~tyxml ~eliom ~variants ~strings ?primary_module
    ~default_language ~external_type ~key_values output =
  if eliom then (
    if primary_module = None && not external_type then
      print_header_eliom output variants strings ;
    print_list_of_languages_eliom output ~variants ;
    print_generated_functions_eliom output ?primary_module ~default_language () ;
    print_body_eliom output key_values
  ) else (
    if primary_module = None && not external_type then
      print_header ~tyxml output variants strings primary_module default_language
    else (match primary_module with
        | Some module_name -> Format.fprintf output "open %s \n" module_name
        | None -> ()) ;
    print_body ~tyxml output key_values primary_module
  )
