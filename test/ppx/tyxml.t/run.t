  $ dune build

  $ ocamlc -stop-after parsing -dsource _build/default/test.ml
  let to_string nodes =
    Format.asprintf "%a"
      (Format.pp_print_list ~pp_sep:(fun _ () -> ()) (Tyxml.Html.pp_elt ()))
      nodes
  let () =
    print_endline (to_string ([%i18n foo]));
    print_endline (to_string ([%i18n bar ~x:([%i18n a_human])]));
    print_endline (to_string ([%i18n bar ~x:([%i18n someone_important])]));
    print_endline (to_string ([%i18n baz]));
    print_endline (to_string ([%i18n baz ~c:true]));
    print_endline (to_string ([%i18n foo ~lang:Example_i18n_tyxml.Fr]));
    print_endline
      (to_string
         ([%i18n
            bar ~lang:Example_i18n_tyxml.Fr
              ~x:([%i18n a_human ~lang:Example_i18n_tyxml.Fr])]));
    print_endline
      (to_string
         ([%i18n
            bar ~lang:Example_i18n_tyxml.Fr
              ~x:([%i18n someone_important ~lang:Example_i18n_tyxml.Fr])]));
    print_endline ([%i18n S.foo]);
    print_endline ([%i18n S.bar ~x:([%i18n S.a_human])]);
    print_endline ([%i18n S.baz]);
    print_endline ([%i18n S.baz ~c:true]);
    print_endline ([%i18n S.bu ~x:([%i18n S.a_human]) ~n:42]);
    print_endline ([%i18n S.foo ~lang:Example_i18n_tyxml.Fr]);
    print_endline
      ([%i18n
         S.bar ~lang:Example_i18n_tyxml.Fr
           ~x:([%i18n S.a_human ~lang:Example_i18n_tyxml.Fr])]);
    print_endline
      ([%i18n
         S.bu ~lang:Example_i18n_tyxml.Fr
           ~x:([%i18n S.a_human ~lang:Example_i18n_tyxml.Fr]) ~n:42])

  $ dune exec ./test.exe
  This is a simple key.
  I am a human.
  I am someone important.
  There is an apple here!
  There are apples here!
  Ceci est une clé toute simple.
  Je suis un humain.
  Je suis quelqu'un d'important.
  This is a simple key.
  I am a human.
  There is an apple here!
  There are apples here!
  I am a human (42).
  Ceci est une clé toute simple.
  Je suis un humain.
  Je suis un humain (42).
