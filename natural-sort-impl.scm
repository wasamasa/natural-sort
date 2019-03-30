(define number-re (make-parameter '(+ num)))

(define (tokenize string)
  (irregex-fold
   (number-re)
   (lambda (i m acc)
     (let ((number (string->number (irregex-match-substring m)))
           (start (irregex-match-start-index m)))
       (if (= start i)
           (cons number acc)
           ;; fetch token before number
           (cons number (cons (substring string i start) acc)))))
   '() string
   (lambda (i acc)
     (let ((end (string-length string)))
       (if (= i end)
           (reverse acc)
           ;; fetch token after last number
           (reverse (cons (substring string i end) acc)))))))

(define natural-sort-preprocessor (make-parameter identity))

(define (natural-string-compare string1 string2)
  (define (clamp lower x upper)
    (min (max lower x) upper))
  (define (inner as bs)
    (cond
     ((and (null? as) (null? bs)) 0)
     ((null? as) -1)
     ((null? bs) 1)
     (else
      (let ((a (car as))
            (b (car bs)))
        (if (and (number? a) (number? b))
            (cond
             ((< a b) -1)
             ((> a b) 1)
             (else (inner (cdr as) (cdr bs))))
            (let* ((a (if (number? a) (number->string a) a))
                   (b (if (number? b) (number->string b) b))
                   (result (string-compare3 a b)))
              (if (zero? result)
                  (inner (cdr as) (cdr bs))
                  (clamp -1 result 1))))))))
  (inner (tokenize ((natural-sort-preprocessor) string1))
         (tokenize ((natural-sort-preprocessor) string2))))

(define (natural-string<? string1 string2)
  (if (< (natural-string-compare string1 string2) 0) #t #f))

(define (natural-string<=? string1 string2)
  (if (<= (natural-string-compare string1 string2) 0) #t #f))

(define (natural-string=? string1 string2)
  (if (zero? (natural-string-compare string1 string2)) #t #f))

(define (natural-string<>? string1 string2)
  (if (not (zero? (natural-string-compare string1 string2))) #t #f))

(define (natural-string>? string1 string2)
  (if (> (natural-string-compare string1 string2) 0) #t #f))

(define (natural-string>=? string1 string2)
  (if (>= (natural-string-compare string1 string2) 0) #t #f))

(define (natural-sort strings)
  (sort strings natural-string<?))
