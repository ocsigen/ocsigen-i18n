Test the options that affect the output.

  $ ocsigen-i18n --languages en,fr --input-file example.tsv
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
  let foo ?(lang = get_language ()) ()  () =
  match lang with
  | En -> "This is a simple key."
  | Fr -> "Ceci est une cl\195\169 toute simple."
  let a_human ?(lang = get_language ()) ()  () =
  match lang with
  | En -> "a human"
  | Fr -> "un humain"
  let bar ?(lang = get_language ()) () ~x () =
  match lang with
  | En -> String.concat "" ["I am ";x;"."]
  | Fr -> String.concat "" ["Je suis ";x;"."]
  let baz ?(lang = get_language ()) () ?(c=false) () =
  match lang with
  | En -> String.concat "" ["There ";(if c then "are" else "is an");" apple";(if c then "s" else "");" here!"]
  | Fr -> String.concat "" ["Il y a ";(if c then "des" else "une");" pomme";(if c then "s" else "");" ici !"]
  let bu ?(lang = get_language ()) () ~n ~x () =
  match lang with
  | En -> String.concat "" ["I am ";(Printf.sprintf "%s" x);" (";(Printf.sprintf "%d" n);")."]
  | Fr -> String.concat "" ["Je suis ";(Printf.sprintf "%s" x);" (";(Printf.sprintf "%d" n);")."]
  let someone_important ?(lang = get_language ()) ()  () =
  match lang with
  | En -> "someone important"
  | Fr -> "quelqu'un d'important"
  end

  $ ocsigen-i18n --languages en,fr --input-file example.tsv --tyxml
  open Tyxml.Html
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
  let foo ?(lang = get_language ()) ()  () =
  match lang with
  | En -> [txt "This is a simple key."]
  | Fr -> [txt "Ceci est une cl\195\169 toute simple."]
  let a_human ?(lang = get_language ()) ()  () =
  match lang with
  | En -> [txt "a human"]
  | Fr -> [txt "un humain"]
  let bar ?(lang = get_language ()) () ~x () =
  match lang with
  | En -> List.flatten [[txt "I am "];x;[txt "."]]
  | Fr -> List.flatten [[txt "Je suis "];x;[txt "."]]
  let baz ?(lang = get_language ()) () ?(c=false) () =
  match lang with
  | En -> List.flatten [[txt "There "];[txt (if c then "are" else "is an")];[txt " apple"];[txt (if c then "s" else "")];[txt " here!"]]
  | Fr -> List.flatten [[txt "Il y a "];[txt (if c then "des" else "une")];[txt " pomme"];[txt (if c then "s" else "")];[txt " ici !"]]
  let bu ?(lang = get_language ()) () ~n ~x () =
  match lang with
  | En -> List.flatten [[txt "I am "];[txt (Printf.sprintf "%s" x)];[txt " ("];[txt (Printf.sprintf "%d" n)];[txt ")."]]
  | Fr -> List.flatten [[txt "Je suis "];[txt (Printf.sprintf "%s" x)];[txt " ("];[txt (Printf.sprintf "%d" n)];[txt ")."]]
  let someone_important ?(lang = get_language ()) ()  () =
  match lang with
  | En -> [txt "someone important"]
  | Fr -> [txt "quelqu'un d'important"]
  module S = struct
  let foo ?(lang = get_language ()) ()  () =
  match lang with
  | En -> "This is a simple key."
  | Fr -> "Ceci est une cl\195\169 toute simple."
  let a_human ?(lang = get_language ()) ()  () =
  match lang with
  | En -> "a human"
  | Fr -> "un humain"
  let bar ?(lang = get_language ()) () ~x () =
  match lang with
  | En -> String.concat "" ["I am ";x;"."]
  | Fr -> String.concat "" ["Je suis ";x;"."]
  let baz ?(lang = get_language ()) () ?(c=false) () =
  match lang with
  | En -> String.concat "" ["There ";(if c then "are" else "is an");" apple";(if c then "s" else "");" here!"]
  | Fr -> String.concat "" ["Il y a ";(if c then "des" else "une");" pomme";(if c then "s" else "");" ici !"]
  let bu ?(lang = get_language ()) () ~n ~x () =
  match lang with
  | En -> String.concat "" ["I am ";(Printf.sprintf "%s" x);" (";(Printf.sprintf "%d" n);")."]
  | Fr -> String.concat "" ["Je suis ";(Printf.sprintf "%s" x);" (";(Printf.sprintf "%d" n);")."]
  let someone_important ?(lang = get_language ()) ()  () =
  match lang with
  | En -> "someone important"
  | Fr -> "quelqu'un d'important"
  end
  end

  $ ocsigen-i18n --languages en,fr --input-file example.tsv --eliom
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
  let foo ?(lang = get_language ()) ()  () =
  match lang with
  | En -> [txt "This is a simple key."]
  | Fr -> [txt "Ceci est une cl\195\169 toute simple."]
  let a_human ?(lang = get_language ()) ()  () =
  match lang with
  | En -> [txt "a human"]
  | Fr -> [txt "un humain"]
  let bar ?(lang = get_language ()) () ~x () =
  match lang with
  | En -> List.flatten [[txt "I am "];x;[txt "."]]
  | Fr -> List.flatten [[txt "Je suis "];x;[txt "."]]
  let baz ?(lang = get_language ()) () ?(c=false) () =
  match lang with
  | En -> List.flatten [[txt "There "];[txt (if c then "are" else "is an")];[txt " apple"];[txt (if c then "s" else "")];[txt " here!"]]
  | Fr -> List.flatten [[txt "Il y a "];[txt (if c then "des" else "une")];[txt " pomme"];[txt (if c then "s" else "")];[txt " ici !"]]
  let bu ?(lang = get_language ()) () ~n ~x () =
  match lang with
  | En -> List.flatten [[txt "I am "];[txt (Printf.sprintf "%s" x)];[txt " ("];[txt (Printf.sprintf "%d" n)];[txt ")."]]
  | Fr -> List.flatten [[txt "Je suis "];[txt (Printf.sprintf "%s" x)];[txt " ("];[txt (Printf.sprintf "%d" n)];[txt ")."]]
  let someone_important ?(lang = get_language ()) ()  () =
  match lang with
  | En -> [txt "someone important"]
  | Fr -> [txt "quelqu'un d'important"]
  module S = struct
  let foo ?(lang = get_language ()) ()  () =
  match lang with
  | En -> "This is a simple key."
  | Fr -> "Ceci est une cl\195\169 toute simple."
  let a_human ?(lang = get_language ()) ()  () =
  match lang with
  | En -> "a human"
  | Fr -> "un humain"
  let bar ?(lang = get_language ()) () ~x () =
  match lang with
  | En -> String.concat "" ["I am ";x;"."]
  | Fr -> String.concat "" ["Je suis ";x;"."]
  let baz ?(lang = get_language ()) () ?(c=false) () =
  match lang with
  | En -> String.concat "" ["There ";(if c then "are" else "is an");" apple";(if c then "s" else "");" here!"]
  | Fr -> String.concat "" ["Il y a ";(if c then "des" else "une");" pomme";(if c then "s" else "");" ici !"]
  let bu ?(lang = get_language ()) () ~n ~x () =
  match lang with
  | En -> String.concat "" ["I am ";(Printf.sprintf "%s" x);" (";(Printf.sprintf "%d" n);")."]
  | Fr -> String.concat "" ["Je suis ";(Printf.sprintf "%s" x);" (";(Printf.sprintf "%d" n);")."]
  let someone_important ?(lang = get_language ()) ()  () =
  match lang with
  | En -> "someone important"
  | Fr -> "quelqu'un d'important"
  end
  end
  ]

  $ ocsigen-i18n --languages en,fr --header
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
  

  $ ocsigen-i18n --languages en,fr --header --eliom
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

  $ ocsigen-i18n --languages en,fr --header --default-language fr
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
  let default_language = Fr
  (* We use a reference to store the language by default.
  Customize these functions if needed.
  For example use a scoped reference if you are using Eliom
  and want the language to depend on a session/tab or session group. *)
  let _language_ = ref default_language
  let get_language () = !_language_
  let set_language language = _language_ := language
  

  $ ocsigen-i18n --languages en,fr --header --tyxml
  open Tyxml.Html
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
  

  $ ocsigen-i18n --languages en,fr --input-file extra.tsv --primary example_i18n.ml
  open Example_i18n 
  module Tr = struct
  let welcome ?(lang = Example_i18n.get_language ()) ()  () =
  match lang with
  | Example_i18n.En -> "Welcome!"
  | Example_i18n.Fr -> "Bienvenue !"
  let thanks ?(lang = Example_i18n.get_language ()) () ~name () =
  match lang with
  | Example_i18n.En -> String.concat "" ["Thank you ";name;"."]
  | Example_i18n.Fr -> String.concat "" ["Merci ";name;"."]
  end

  $ ocsigen-i18n --languages en,fr --input-file extra.tsv --primary example_i18n.eliom --eliom
  let%shared languages = [Example_i18n.En;Example_i18n.Fr]
  let%server _language_ = Example_i18n._language_
  let%server get_language () = Eliom_reference.Volatile.get _language_
  let%server set_language language = 
  Eliom_reference.Volatile.set _language_ language
  
  let%client _language_ = Example_i18n._language_
  let%client get_language () = !_language_
  let%client set_language language = _language_ := language
  
  let%shared txt = Eliom_content.Html.F.txt
  [%%shared
  module Tr = struct
  let welcome ?(lang = get_language ()) ()  () =
  match lang with
  | Example_i18n.En -> [txt "Welcome!"]
  | Example_i18n.Fr -> [txt "Bienvenue !"]
  let thanks ?(lang = get_language ()) () ~name () =
  match lang with
  | Example_i18n.En -> List.flatten [[txt "Thank you "];name;[txt "."]]
  | Example_i18n.Fr -> List.flatten [[txt "Merci "];name;[txt "."]]
  module S = struct
  let welcome ?(lang = get_language ()) ()  () =
  match lang with
  | Example_i18n.En -> "Welcome!"
  | Example_i18n.Fr -> "Bienvenue !"
  let thanks ?(lang = get_language ()) () ~name () =
  match lang with
  | Example_i18n.En -> String.concat "" ["Thank you ";name;"."]
  | Example_i18n.Fr -> String.concat "" ["Merci ";name;"."]
  end
  end
  ]
