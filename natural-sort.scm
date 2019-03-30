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
    (import chicken)
    (use irregex data-structures))
   (chicken-5
    (import (chicken base))
    (import (chicken irregex))
    (import (chicken sort))
    (import (chicken string))))

  (include "natural-sort-impl.scm"))
