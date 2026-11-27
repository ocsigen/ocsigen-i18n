  $ ocsigen-i18n
  Usage: ocsigen-i18n [--help] [OPTION]…
  ocsigen-i18n: required option --languages is missing
  [124]

  $ ocsigen-i18n --languages ""
  Usage: ocsigen-i18n [--help] [OPTION]…
  ocsigen-i18n: option --languages: must define at least one language
  [124]

  $ ocsigen-i18n --header --languages en,fr --default-language es
  ocsigen-i18n: Default language "es" is not in --languages.
  [123]

  $ ocsigen-i18n --languages en --input-file=non_existant.tsv
  ocsigen-i18n: non_existant.tsv: No such file or directory
  [123]
