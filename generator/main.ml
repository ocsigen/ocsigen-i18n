let with_in_chan file f =
  match file with
  | "-" -> f stdin
  | file -> In_channel.with_open_text file f

let with_out_chan file f =
  match file with
  | "-" -> f stdout
  | file -> Out_channel.with_open_text file f

let with_out_fmt file f =
  with_out_chan file (fun out_chan ->
      let fmt = Format.formatter_of_out_channel out_chan in
      let r = f fmt in
      Format.pp_print_flush fmt (); (* Explicit flush to notice IO errors. *)
      r)

let parse_file ~variants input_file =
  with_in_chan input_file (fun in_chan ->
      let lexbuf = Lexing.from_channel in_chan in
      try
        Parser.parse_lines variants [] lexbuf
      with Failure _ ->
        failwith
          (Printf.sprintf "line: %d" lexbuf.Lexing.lex_curr_p.Lexing.pos_lnum))

let input_file = ref "-"
let output_file = ref "-"
let eliom_generation = ref false
let tyxml_generation = ref false
let header = ref false
let languages = ref ""
let default_language = ref ""
let external_type = ref false
let primary_file = ref ""
let options = Arg.align
    [ ( "--languages", Arg.Set_string languages
      , " Comma-separated languages (e.g. en,fr-fr, or Foo.Fr,Foo.Us if \
         using external types). \
         Must be ordered as in source TSV file.")
    ; ( "--default-language", Arg.Set_string default_language
      , " Set the default language (default is the first one in --languages).")
    ; ( "--input-file", Arg.Set_string input_file
      , " TSV file containing keys and translations. \
         If option is omited or set to -, read on stdin.")
    ; ( "--output-file", Arg.Set_string output_file
      , " File TSV file containing keys and translations. \
         If option is omited or set to -, write on stdout.")
    ; ( "--external-type", Arg.Set external_type
      , " Values passed to --languages option come from a predefined type \
         (do not generate the type nor from/to string functions).")
    ; ( "--primary", Arg.Set_string primary_file
      , " Generated file is secondary and depends on given primary file.")
    ; ( "--eliom", Arg.Set eliom_generation
      , " Generate code for a client-server Eliom app (implies --tyxml).")
    ; ( "--tyxml", Arg.Set tyxml_generation
      , " Generate code for a Tyxml-based app (for example a server-side Eliom app).")
    ; ( "--header", Arg.Set header
      , " Generate only the file header.")
    ]

let usage = "usage: ocsigen-i18n [options] [< input] [> output]"

let _ = Arg.parse options (fun s -> ()) usage
let () = if !eliom_generation then tyxml_generation := true

let normalize_type ?primary_module s =
  let constr =
    String.lowercase_ascii s
    |> Str.(global_replace (regexp "-") "_")
    |> String.capitalize_ascii
  in
  match primary_module with
  | None -> constr
  | Some module_name -> module_name ^ "." ^ constr

let _ =
  let primary_module = match !primary_file with
    | "" -> None
    | file -> let base = Filename.remove_extension file in
      Some (String.capitalize_ascii base)
  in
  let strings = Str.split (Str.regexp ",") !languages in
  let variants =
    if !primary_file = "" || not (!external_type)
    then List.map (normalize_type ?primary_module) strings
    else strings in
  let default_language =
    match !default_language with
    | "" -> (List.hd variants)
    | x ->
      let x = normalize_type ?primary_module x in
      assert (List.mem x variants) ;
      x in
  with_out_fmt !output_file (fun output ->
      let tyxml = !tyxml_generation in
      let eliom = !eliom_generation in
      if !header then
        Gen.gen_header ~tyxml ~eliom ~variants ~strings ?primary_module
          ~default_language output
      else (
        let key_values = parse_file ~variants !input_file in
        Gen.gen_module ~tyxml ~eliom ~variants ~strings ?primary_module
          ~default_language ~external_type:!external_type ~key_values output
      )
    )
