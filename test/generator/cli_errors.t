  $ ocsigen-i18n
  Fatal error: exception Failure("hd")
  [2]

  $ ocsigen-i18n --languages ""
  Fatal error: exception Failure("hd")
  [2]

  $ ocsigen-i18n --header --languages en,fr --default-language es
  Fatal error: exception File "i18n_generate.mll", line 453, characters 6-12: Assertion failed
  [2]
