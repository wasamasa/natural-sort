(module natural-sort
  (number-re natural-sort-preprocessor
   natural-string-compare
   natural-string<? natural-string<=?
   natural-string=? natural-string<>?
   natural-string>? natural-string>=?
   natural-sort)

  (import chicken scheme)

  (include "natural-sort-impl.scm"))
