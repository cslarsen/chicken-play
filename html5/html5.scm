; Simple HTML5 rendering
; by Christian Stigen Larsen
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
    (define (if-has-children? html-node true-value false-value)
      (if (list? (cadr html-node)) true-value false-value))

    (define (open-tag name)
      (string-append "<" name ">"))

    (define (close-tag name)
      (string-append "</" name ">"))

    (let
      ((current-node (car L))
       (child-nodes (cdr L)))

      (string-append spaces
       ; <tag>
       (open-tag (html->indented-string current-node ""))
         (if-has-children? L "\n" "")

       ; recurse
       (html->indented-string child-nodes (string-append " " spaces))

       ; </tag>
       (if-has-children? L spaces "")
         (close-tag (html->indented-string current-node "")) "\n")))

  (cond ((null? L) "")
     ((not (list? L)) (->string L))
     (else
       (string-append
         (if (symbol? (car L))
           ; render node ...
           (enclose-first L spaces)

           ; ... and recurse
           (string-append
             (html->indented-string (car L) spaces)
             (html->indented-string (cdr L) spaces)))))))

  (define (html->pretty-string L)
    (html->indented-string L ""))
)
