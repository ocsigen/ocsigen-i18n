let ( let* ) = Result.bind

let with_in_chan file f =
  match file with "-" -> f stdin | file -> In_channel.with_open_text file f

let with_out_chan file f =
  match file with "-" -> f stdout | file -> Out_channel.with_open_text file f

let with_out_fmt file f =
  try
    with_out_chan file (fun out_chan ->
        let fmt = Format.formatter_of_out_channel out_chan in
        let r = f fmt in
        Format.pp_print_flush fmt ();
        (* Explicit flush to notice IO errors. *)
        Ok r
    )
  with Sys_error msg -> Error msg

let parse_file ~variants input_file =
  with_in_chan input_file (fun in_chan ->
      let lexbuf = Lexing.from_channel in_chan in
      try Parser.parse_lines variants [] lexbuf
      with Failure _ ->
        failwith
          (Printf.sprintf "line: %d" lexbuf.Lexing.lex_curr_p.Lexing.pos_lnum)
  )

let normalize_type ?primary_module s =
  let constr =
    String.lowercase_ascii s
    |> Str.(global_replace (regexp "-") "_")
    |> String.capitalize_ascii
  in
  match primary_module with
  | None -> constr
  | Some module_name -> module_name ^ "." ^ constr

open! Cmdliner

let languages =
  let lang_conv =
    let conv = Arg.(list string) in
    let parser s =
      match Arg.Conv.parser conv s with
      | Ok [] -> Error "must define at least one language"
      | r -> r
    in
    Arg.Conv.of_conv conv ~docv:"LANGS" ~parser
  in
  let doc =
    "Comma-separated languages (e.g. $(b,en,fr-fr), or $(b,Foo.Fr,Foo.Us) if \
     using external types). Must be ordered as in source TSV file."
  in
  Arg.(required & opt (some lang_conv) None & info ["languages"] ~doc)

let default_language =
  let doc =
    "Set the default language (default is the first one in $(b,--languages))."
  in
  Arg.(
    value & opt (some string) None & info ["default-language"] ~docv:"LANG" ~doc
  )

let input_file =
  let doc =
    "TSV file containing keys and translations. If option is omitted or set to \
     $(b,-), read on stdin."
  in
  Arg.(value & opt string "-" & info ["input-file"] ~docv:"FILE" ~doc)

let output_file =
  let doc =
    "Path for the generated OCaml code. If option is omitted or set to $(b,-), \
     write on stdout."
  in
  Arg.(value & opt string "-" & info ["output-file"] ~docv:"FILE" ~doc)

let external_type =
  let doc =
    "Values passed to $(b,--languages) option come from a predefined type (do \
     not generate the type nor from/to string functions)."
  in
  Arg.(value & flag & info ["external-type"] ~doc)

let primary_module =
  let module_conv =
    let parser file =
      Ok (String.capitalize_ascii (Filename.remove_extension file))
    in
    Arg.Conv.of_conv Arg.string ~docv:"FILE" ~parser
  in
  let doc = "Generated file is secondary and depends on given primary file." in
  Arg.(value & opt (some module_conv) None & info ["primary"] ~doc)

let eliom =
  let doc =
    "Generate code for a client-server Eliom app (implies $(b,--tyxml))."
  in
  Arg.(value & flag & info ["eliom"] ~doc)

let tyxml =
  let doc =
    "Generate code for a Tyxml-based app (for example a server-side Eliom app)."
  in
  Arg.(value & flag & info ["tyxml"] ~doc)

let header =
  let doc = "Generate only the file header." in
  Arg.(value & flag & info ["header"] ~doc)

let term =
  let open Term.Syntax in
  let+ languages
  and+ default_language
  and+ input_file
  and+ output_file
  and+ external_type
  and+ primary_module
  and+ eliom
  and+ tyxml
  and+ header in
  let tyxml = tyxml || eliom in
  let variants =
    match primary_module with
    | Some _ when external_type -> languages
    | Some _ | None -> List.map (normalize_type ?primary_module) languages
  in
  let* default_language =
    match default_language with
    | None -> Ok (List.hd variants)
    | Some lang ->
        let constr = normalize_type ?primary_module lang in
        if List.mem constr variants
        then Ok constr
        else
          Error
            (Printf.sprintf "Default language %S is not in --languages." lang)
  in
  with_out_fmt output_file (fun output ->
      if header
      then
        Gen.gen_header ~tyxml ~eliom ~variants ~strings:languages
          ?primary_module ~default_language output
      else
        let key_values = parse_file ~variants input_file in
        Gen.gen_module ~tyxml ~eliom ~variants ~strings:languages
          ?primary_module ~default_language ~external_type ~key_values output
  )

let cmd =
  let doc =
    "Generate OCaml code for the translations described in a TSV file."
  in
  Cmd.v (Cmd.info "ocsigen-i18n" ~doc) term

let () = exit (Cmd.eval_result ~catch:false cmd)
