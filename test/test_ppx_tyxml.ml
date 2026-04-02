let to_string nodes =
  Format.asprintf "%a"
    (Format.pp_print_list ~pp_sep:(fun _ () -> ()) (Tyxml.Html.pp_elt ()))
    nodes

let () =
  (* == HTML output (Tr module) — English == *)
  (* Simple key *)
  print_endline (to_string [%i18n foo]);
  (* Variable: translated i18n value *)
  print_endline (to_string [%i18n bar ~x:[%i18n a_human]]);
  (* Variable: HTML markup *)
  print_endline
    (to_string
       [%i18n bar ~x:[Tyxml.Html.em [Tyxml.Html.txt "someone important"]]]);
  (* Conditional *)
  print_endline (to_string [%i18n baz]);
  print_endline (to_string [%i18n baz ~c:true]);
  (* == HTML output — French == *)
  print_endline (to_string [%i18n foo ~lang:Example_i18n_tyxml.Fr]);
  print_endline
    (to_string
       [%i18n
         bar ~lang:Example_i18n_tyxml.Fr
           ~x:[%i18n a_human ~lang:Example_i18n_tyxml.Fr]]);
  (* == String output (S. prefix) — English == *)
  print_endline [%i18n S.foo];
  print_endline [%i18n S.bar ~x:[%i18n S.a_human]];
  print_endline [%i18n S.baz];
  print_endline [%i18n S.baz ~c:true];
  print_endline [%i18n S.bu ~x:"Alice" ~n:42];
  (* == String output — French == *)
  print_endline [%i18n S.foo ~lang:Example_i18n_tyxml.Fr];
  print_endline
    [%i18n
      S.bar ~lang:Example_i18n_tyxml.Fr
        ~x:[%i18n S.a_human ~lang:Example_i18n_tyxml.Fr]];
  print_endline [%i18n S.bu ~lang:Example_i18n_tyxml.Fr ~x:"Alice" ~n:42]
