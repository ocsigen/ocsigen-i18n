  $ printf "\n\n" | ocsigen-i18n --languages en,fr
  Fatal error: exception Failure("line: 1")
  [2]

  $ printf "a\tb\n" | ocsigen-i18n --languages en,fr
  type t = En|Fr
  exception Unknown_language of string
  let string_of_language = function 
  | En -> "en"| Fr -> "fr"
  let language_of_string = function
  | "en" -> En| "fr" -> Fr| s -> raise (Unknown_language s)
  let guess_language_of_string s = 
  try language_of_string s 
  with Unknown_language _ as e -> 
  try language_of_string (String.sub s 0 (String.index s '-')) 
  with Not_found -> 
  raise e 
  let languages = [En;Fr]
  let default_language = En
  (* We use a reference to store the language by default.
  Customize these functions if needed.
  For example use a scoped reference if you are using Eliom
  and want the language to depend on a session/tab or session group. *)
  let _language_ = ref default_language
  let get_language () = !_language_
  let set_language language = _language_ := language
  
  module Tr = struct
  let a ?(lang = get_language ()) ()  () =
  match lang with
  | En -> "b"
  | Fr -> Fatal error: exception File "generator/gen.ml", line 225, characters 4-10: Assertion failed
  [2]

  $ printf "a\tb\n" | ocsigen-i18n --eliom --languages en,fr
  [%%shared type t = En|Fr [@@deriving json]]
  [%%shared exception Unknown_language of string]
  let%shared string_of_language = function 
  | En -> "en"| Fr -> "fr"
  let%shared language_of_string = function
  | "en" -> En| "fr" -> Fr| s -> raise (Unknown_language s)
  let%shared guess_language_of_string s = 
  try language_of_string s 
  with Unknown_language _ as e -> 
  try language_of_string (String.sub s 0 (String.index s '-')) 
  with Not_found -> 
  raise e 
  let%shared languages = [En;Fr]
  let%shared default_language = En
  let%server _language_ = Eliom_reference.Volatile.eref
  ~scope:Eliom_common.default_process_scope default_language
  let%server get_language () = Eliom_reference.Volatile.get _language_
  let%server set_language language = 
  Eliom_reference.Volatile.set _language_ language
  
  let%client _language_ = ref default_language
  let%client get_language () = !_language_
  let%client set_language language = _language_ := language
  
  let%shared txt = Eliom_content.Html.F.txt
  [%%shared
  module Tr = struct
  let a ?(lang = get_language ()) ()  () =
  match lang with
  | En -> [txt "b"]
  | Fr -> Fatal error: exception File "generator/gen.ml", line 205, characters 4-10: Assertion failed
  [2]
