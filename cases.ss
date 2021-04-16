;; Test Cases for the project
;(prog 10)
;(prog (myadd 1 2))
;(prog (mymul 2 5))
;(prog (mysub 0 10))
;(prog (myif 0 5 10))
;(prog (mylet x 10 (myadd x x)))
;(prog (myadd 10 (mylet x 5 (mymul x x))))
;(prog (mylet x (mysub (mylet x 10 x)) (myadd x (mylet x 1 (myadd x x)))))
;(prog (mylet x (mysub (myadd 10 11)) (mylet y x (mymul x y))))
;(prog (myif (myadd 0 1) (mylet x 10 x) (mylet x 15 x)))

; In case you want to load the test cases into the interpreter, I have included the following defintions. 
; Load this file into the interpreter using ,load cases.ss or (load "cases.ss")
; After they are loaded, you can test your interpeter using this command:
; (myinterpreter cases)
(define c0 '(prog 10))
(define c1 '(prog (myadd 1 2)))
(define c2 '(prog (mymul 2 5)))
(define c3 '(prog (mysub 0 10)))
(define c4 '(prog (myif 0 5 10)))
(define c5 '(prog (mylet x 10 (myadd x x))))
(define c6 '(prog (myadd 10 (mylet x 5 (mymul x x)))))
(define c7 '(prog (mylet x (mysub 0 (mylet x 10 x)) (myadd x (mylet x 1 (myadd x x))))))
(define c8 '(prog (mylet x (mysub 0 (myadd 10 11)) (mylet y x (mymul x y)))))
(define c9 '(prog (myif (myadd 0 1) (mylet x 10 x) (mylet x 15 x))))

(define cases (list c0 c1 c2 c3 c4 c5 c6 c7 c8 c9))

; Here are the correct outputs for each case, from c0-c9
(define official '(10 3 10 -10 10 20 35 -8 441 10))