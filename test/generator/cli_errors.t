  $ ocsigen-i18n
  Fatal error: exception Failure("hd")
  [2]

  $ ocsigen-i18n --languages ""
  Fatal error: exception Failure("hd")
  [2]

  $ ocsigen-i18n --header --languages en,fr --default-language es
  Fatal error: exception File "generator/main.ml", line 93, characters 6-12: Assertion failed
  [2]
