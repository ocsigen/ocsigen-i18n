let () =
  (* Simple key *)
  print_endline [%i18n foo];
  (* With variable *)
  print_endline [%i18n bar ~x:[%i18n a_human]];
  print_endline [%i18n bar ~x:("Jean-Michel (" ^ string_of_int 22 ^ ")")];
  (* Conditional (default false) *)
  print_endline [%i18n baz];
  (* Conditional (true) *)
  print_endline [%i18n baz ~c:true];
  (* Typed variables *)
  print_endline [%i18n bu ~x:"Jean-Michel" ~n:44];
  (* Explicit language *)
  print_endline [%i18n foo ~lang:Example_i18n.Fr]
