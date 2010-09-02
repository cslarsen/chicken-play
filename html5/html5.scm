; simple html5 rendering
(module html5
  *
  (import scheme chicken)

(define (html->string L)
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

  (cond ((null? L) "")
     ((not (list? L)) (->string L))
     (else
       (string-append
         (if (symbol? (car L))
           (enclose-first L)
           (string-append
             (html->string (car L))
             (html->string (cdr L))))))))

(define (html->indented-string L spaces)
  (define (->string s)
    (cond ((null? s) "")
      ((string? s) s)
      ((symbol? s) (symbol->string s))
      ((number? s) (number->string s))
      (else
        (format "~s" s))))

  (define (enclose-first L spaces)
    (let
      ((spaces+ (string-append " " spaces))
       (cond-spaces (if (list? (cadr L)) spaces "")))

      (string-append "\n" spaces
       "<" (html->indented-string (car L) spaces+) ">"

       (html->indented-string (cdr L) spaces+)

       cond-spaces "</" (html->indented-string (car L) spaces+) ">"
       "\n")))

  (cond ((null? L) "")
     ((not (list? L)) (->string L))
     (else
       (string-append
         (if (symbol? (car L))
           (enclose-first L spaces)
           (string-append
             (html->indented-string (car L) spaces)
             (html->indented-string (cdr L) spaces)))))))

  (define (html->pretty-string L)
    (html->indented-string L ""))
)
