(module natural-sort
  (number-re natural-sort-preprocessor
   natural-string-compare
   natural-string<? natural-string<=?
   natural-string=? natural-string<>?
   natural-string>? natural-string>=?
   natural-sort)

  (import scheme)
  (cond-expand
   (chicken-4
    (import chicken))
   (chicken-5
    (import (chicken base))))

  (include "natural-sort-impl.scm"))
