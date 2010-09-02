; simple html5 rendering
(module html5
  *
  (import scheme chicken)

  (define (->string s)
    (cond ((null? s) "")
      ((string? s) s)
      ((symbol? s) (symbol->string s))
      ((number? s) (number->string s))
      (else
        (format "~s" s))))

  (define (enclose-first L)
    (string-append
     "<" (html->string (car L)) ">"
     (html->string (cdr L))
     "</" (html->string (car L)) ">"))

  (define (html->string L)
    (cond ((null? L) "")
       ((not (list? L)) (->string L))
       (else
         (string-append
           (if (symbol? (car L))
             (enclose-first L)
             (string-append
               (html->string (car L))
               (html->string (cdr L))))))))
)
