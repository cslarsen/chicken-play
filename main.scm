; Example use of SQLITE3 and HTML5 renderer in Chicken Scheme
; By Christian Stigen Larsen
;
; To install sqlite3:
; $ chicken-install sqlite3
;
; To make and run this demo:
; $ make clean all

(require-extension
  (prefix sqlite3 sqlite3:)
  (prefix html5 html5:))

(let
  ((db (sqlite3:open-database "test.db"))
   (title "Chicken Play")
   (pass-through (lambda i i)))
  (print
    "<!DOCTYPE html>\n"
    (html5:render
      `(html
         (head (title ,title))
         (body
           ,(html5:make-table
             (sqlite3:map-row pass-through
                db "select * from users")))))))
