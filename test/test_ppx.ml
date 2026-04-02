let () =
  (* == English (default language) == *)
  (* Simple key *)
  print_endline [%i18n foo];
  (* Variable: translated i18n value *)
  print_endline [%i18n bar ~x:[%i18n a_human]];
  (* Conditional: default (false) *)
  print_endline [%i18n baz];
  (* Conditional: true *)
  print_endline [%i18n baz ~c:true];
  (* Typed variables *)
  print_endline [%i18n bu ~x:[%i18n a_human] ~n:42];
  (* == French (explicit language) == *)
  print_endline [%i18n foo ~lang:Example_i18n.Fr];
  print_endline
    [%i18n bar ~lang:Example_i18n.Fr ~x:[%i18n a_human ~lang:Example_i18n.Fr]];
  print_endline [%i18n baz ~lang:Example_i18n.Fr];
  print_endline [%i18n baz ~lang:Example_i18n.Fr ~c:true];
  print_endline
    [%i18n
      bu ~lang:Example_i18n.Fr ~x:[%i18n a_human ~lang:Example_i18n.Fr] ~n:42]
