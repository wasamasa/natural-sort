(import scheme)
(cond-expand
 (chicken-4
  (use natural-sort test srfi-13))
 (chicken-5
  (import natural-sort)
  (import test)
  (import (srfi 13))))

(test-group "Comparison"
  (test  0 (natural-string-compare "" ""))
  (test -1 (natural-string-compare "" "foo"))
  (test +1 (natural-string-compare "foo" ""))
  (test  0 (natural-string-compare "foo" "foo"))
  (test -1 (natural-string-compare "bar" "foo"))
  (test +1 (natural-string-compare "foo" "bar"))
  (test  0 (natural-string-compare "foo123" "foo123"))
  (test -1 (natural-string-compare "foo" "foo123"))
  (test +1 (natural-string-compare "foo123" "foo"))
  (test -1 (natural-string-compare "foo2" "foo123"))
  (test -1 (natural-string-compare "foo99" "foo123"))
  (test  0 (natural-string-compare "foo123bar" "foo123bar"))
  (test -1 (natural-string-compare "foo123bar" "foo123baz"))
  (test +1 (natural-string-compare "foo123qux" "foo123baz")))

(test-group "Predicates"
  (test #t (natural-string<?  "foo9" "foo10"))
  (test #t (natural-string<=? "foo9" "foo10"))
  (test #f (natural-string=?  "foo9" "foo10"))
  (test #t (natural-string<>? "foo9" "foo10"))
  (test #f (natural-string>?  "foo9" "foo10"))
  (test #f (natural-string>=? "foo9" "foo10")))

(test-group "Flonums (default)"
  (test #f (natural-string<? "1.001" "1.01"))
  (test #f (natural-string<? "1.01" "1.1")))

(test-group "Flonums (custom)"
  (parameterize ((number-re '(: (+ num) (? (: "." (+ num))))))
    (test #t (natural-string<? "1.001" "1.01"))
    (test #t (natural-string<? "1.01" "1.1"))))

(test-group "Sorting (default)"
  (test '("1" "2" "3" "4" "10" "20" "30" "100")
        (natural-sort '("1" "10" "100" "2" "20" "3" "30" "4")))
  (test '("a" "a0" "a1" "a1a" "a1b" "a2" "a10" "a20")
        (natural-sort '("a10" "a" "a20" "a1b" "a1a" "a2" "a0" "a1")))
  (test '("1.2.3.4" "8.8.8.8" "127.0.0.1" "192.168.178.1")
        (natural-sort '("127.0.0.1" "8.8.8.8" "192.168.178.1" "1.2.3.4"))))

(test-group "Sorting (custom)"
  (parameterize ((natural-sort-preprocessor string-trim))
    (test '(" a9" "a10" " a11" "a20")
          (natural-sort '("a10" " a9" "a20" " a11"))))
  (parameterize ((natural-sort-preprocessor string-downcase))
    (test '("a9" "A10" "a11" "A20")
          (natural-sort '("A10" "a9" "A20" "a11")))))

(test-exit)
