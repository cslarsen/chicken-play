(require-extension
  (prefix sqlite3 sqlite3:)
  (prefix html5 html5:))

(define (rows->table rows)
  (define (cell->td cell)
    `(td ,cell))

  (define (cells->tds cells)
    (map cell->td cells))

  (define (row->tr row)
    `(tr ,(cells->tds row)))

  `(table
	,(list (map row->tr rows))))

;(define db
;  (sqlite3:open-database "test.db"))

; unimplemented html5 validation
(define (html5:validate doc)
  doc)

; unimplemented html5 pretty-printer
(define (html5:html->pretty-string doc)
  (html5:html->string doc))

; validate html5 and return indented text document
(define (html5:render doc)
  (html5:html->pretty-string (html5:validate doc)))

; print contents and pass on untouched
(define (dbg-pass-print! x)
  (print (format "~s" x)) x)

; just pass the value on
; use where (identity) can't be
(define pass (lambda x x))

(let
  ((db (sqlite3:open-database "test.db"))
   (title "Chicken Play")
   (doctype "<!DOCTYPE html>"))

  (print
    doctype "\n"
    (html5:render
      `(html
         (head ,title)
         (body
           ,(rows->table
             (sqlite3:map-row
  	     pass
             db "select * from users")))))))
