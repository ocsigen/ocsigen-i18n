let to_string nodes =
  Format.asprintf "%a"
    (Format.pp_print_list ~pp_sep:(fun _ () -> ()) (Tyxml.Html.pp_elt ()))
    nodes

let () =
  (* HTML output *)
  print_endline (to_string [%i18n foo]);
  print_endline (to_string [%i18n bar ~x:[%i18n a_human]]);
  (* HTML variable with markup *)
  print_endline
    (to_string [%i18n bar ~x:[Tyxml.Html.em [Tyxml.Html.txt "World"]]]);
  (* String output via S. prefix *)
  print_endline [%i18n S.foo];
  print_endline [%i18n S.bar ~x:[%i18n S.a_human]];
  (* Conditional *)
  print_endline [%i18n S.baz ~c:true];
  (* Explicit language *)
  print_endline [%i18n S.foo ~lang:Example_i18n_tyxml.Fr]
