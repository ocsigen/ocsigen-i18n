  $ ocsigen-i18n
  Fatal error: exception Failure("hd")
  [2]

  $ ocsigen-i18n --languages ""
  Fatal error: exception Failure("hd")
  [2]

  $ ocsigen-i18n --header --languages en,fr --default-language es
  Fatal error: exception File "i18n_generate.mll", line 453, characters 6-12: Assertion failed
  [2]

  $ ocsigen-i18n --languages en non_existant.tsv
  type t = En
  exception Unknown_language of string
  let string_of_language = function 
  | En -> "en"
  let language_of_string = function
  | "en" -> En| s -> raise (Unknown_language s)
  let guess_language_of_string s = 
  try language_of_string s 
  with Unknown_language _ as e -> 
  try language_of_string (String.sub s 0 (String.index s '-')) 
  with Not_found -> 
  raise e 
  let languages = [En]
  let default_language = En
  (* We use a reference to store the language by default.
  Customize these functions if needed.
  For example use a scoped reference if you are using Eliom
  and want the language to depend on a session/tab or session group. *)
  let _language_ = ref default_language
  let get_language () = !_language_
  let set_language language = _language_ := language
  
  module Tr = struct
  
  end
