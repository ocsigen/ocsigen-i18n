  $ dune build

  $ ocamlc -stop-after parsing -dsource _build/default/test.ml
  let () =
    print_endline ([%i18n foo]);
    print_endline ([%i18n bar ~x:([%i18n a_human])]);
    print_endline ([%i18n baz]);
    print_endline ([%i18n baz ~c:true]);
    print_endline ([%i18n bu ~x:([%i18n a_human]) ~n:42]);
    print_endline ([%i18n foo ~lang:Example_i18n.Fr]);
    print_endline
      ([%i18n
         bar ~lang:Example_i18n.Fr ~x:([%i18n a_human ~lang:Example_i18n.Fr])]);
    print_endline ([%i18n baz ~lang:Example_i18n.Fr]);
    print_endline ([%i18n baz ~lang:Example_i18n.Fr ~c:true]);
    print_endline
      ([%i18n
         bu ~lang:Example_i18n.Fr ~x:([%i18n a_human ~lang:Example_i18n.Fr])
           ~n:42])

  $ dune exec ./test.exe
  This is a simple key.
  I am a human.
  There is an apple here!
  There are apples here!
  I am a human (42).
  Ceci est une clé toute simple.
  Je suis un humain.
  Il y a une pomme ici !
  Il y a des pommes ici !
  Je suis un humain (42).
