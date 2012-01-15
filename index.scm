; Example use of SQLITE3 and HTML5 renderer in Chicken Scheme
;
; Written By Christian Stigen Larsen
; http://csl.sublevel3.org
;
; To install sqlite3:
; $ chicken-install sqlite3
;
; To make and run this demo:
; $ make clean all

(require-extension
  (prefix sqlite3 sqlite3:)
  (prefix html5 html5:)
  (prefix sql sql:))

(let
  ((title     "Chicken Play")
   (db (sqlite3:open-database "test.db"))
   (pass-through (lambda i i))) ; can't use (identity)
  (print
    "Content-type: text/html\n"
    "\n"
    "<!DOCTYPE html>\n"
    (html5:to-string
      `(html
         (head (title ,title))
         (body
           ,(html5:make-table
             (sqlite3:map-row pass-through db
               (sql:to-string '(SELECT * FROM users)))))))))
