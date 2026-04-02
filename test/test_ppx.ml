let () =
  (* == English (default language) == *)
  (* Simple key *)
  print_endline [%i18n foo];
  (* Variable: string argument *)
  print_endline [%i18n bar ~x:[%i18n a_human]];
  (* Variable: computed string *)
  print_endline [%i18n bar ~x:("participant " ^ string_of_int 3)];
  (* Conditional: default (false) *)
  print_endline [%i18n baz];
  (* Conditional: true *)
  print_endline [%i18n baz ~c:true];
  (* Typed variables *)
  print_endline [%i18n bu ~x:"Alice" ~n:42];
  (* == French (explicit language) == *)
  print_endline [%i18n foo ~lang:Example_i18n.Fr];
  print_endline
    [%i18n bar ~lang:Example_i18n.Fr ~x:[%i18n a_human ~lang:Example_i18n.Fr]];
  print_endline [%i18n baz ~lang:Example_i18n.Fr];
  print_endline [%i18n baz ~lang:Example_i18n.Fr ~c:true];
  print_endline [%i18n bu ~lang:Example_i18n.Fr ~x:"Alice" ~n:42]
