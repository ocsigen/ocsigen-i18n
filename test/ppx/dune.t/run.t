  $ dune build

  $ ocamlc -stop-after parsing -dsource _build/default/test.pp.ml
  [@@@ocaml.ppx.context
    {
      tool_name = "ppx_driver";
      include_dirs = [];
      hidden_include_dirs = [];
      load_path = ([], []);
      open_modules = [];
      for_package = None;
      debug = false;
      use_threads = false;
      use_vmthreads = false;
      recursive_types = false;
      principal = false;
      no_alias_deps = false;
      unboxed_types = false;
      unsafe_string = false;
      cookies = []
    }]
  let () =
    print_endline (Example_i18n.Tr.foo () ());
    print_endline
      (Example_i18n.Tr.bar () ~x:(Example_i18n.Tr.a_human () ()) ());
    print_endline (Example_i18n.Tr.baz () ());
    print_endline (Example_i18n.Tr.baz () ~c:true ());
    print_endline
      (Example_i18n.Tr.bu () ~x:(Example_i18n.Tr.a_human () ()) ~n:42 ());
    print_endline (Example_i18n.Tr.foo () ~lang:Example_i18n.Fr ());
    print_endline
      (Example_i18n.Tr.bar () ~lang:Example_i18n.Fr
         ~x:(Example_i18n.Tr.a_human () ~lang:Example_i18n.Fr ()) ());
    print_endline (Example_i18n.Tr.baz () ~lang:Example_i18n.Fr ());
    print_endline (Example_i18n.Tr.baz () ~lang:Example_i18n.Fr ~c:true ());
    print_endline
      (Example_i18n.Tr.bu () ~lang:Example_i18n.Fr
         ~x:(Example_i18n.Tr.a_human () ~lang:Example_i18n.Fr ()) ~n:42 ())

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
