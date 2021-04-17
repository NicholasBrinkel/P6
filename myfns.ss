(define (myinterpreter list)
  (if (null? list)
    '()
    (cons (evalProg (car list)) (myinterpreter (cdr list)))
  )
)

(define (evalProg p)
    (evalExpr (car (cdr p)) (list ()))
)

(define (evalExpr exp b)
  ;Check to see what kind of expression it is
  (cond

    ; This expression is an integer
    ((integer? exp)
      exp
    )

    ; This expression is an ID
    ((symbol? exp)
      (evalId exp b)
    )

    ; This expression is a myadd
    ((equal? (car exp) 'myadd)
      (evalMyArith + exp b)
    )

    ; This expression is a mymul
    ((equal? (car exp) 'mymul)
      (evalMyArith * exp b)
    )

    ; This expression is a mysub
    ((equal? (car exp) 'mysub)
      (evalMyArith - exp b)
    )

    ; This expression is a myif
    ((equal? (car exp) 'myif)
      (evalMyIf exp)
    )

    ; This expression is a mylet
    ((equal? (car exp) 'mylet)
      (evalMyLet exp b)
    )

    ; This expression is a function call
    (#t
      (evalFuncCall exp b)  
    )
  )
)

(define (evalMyArith f expr b)
  (f (evalExpr (car (cdr expr)) b) (evalExpr (car (cdr (cdr expr))) b))
)

(define (evalMyIf ifExpr b)
  (cond
    ((= (evalExpr (car (cdr ifExpr)) b) 0)
    ; Then eval the 2nd expr
      (evalExpr (cons (car (cdr (cdr ifExpr))) '()) b)
    )

    ; Otherwise eval the 3rd expr
    (#t
      (evalExpr (car (cdr (cdr (cdr ifExpr)))) b)
    )
  )
)

(define (evalMyLet letExpr b)
  (cond 
    ((symbol? (car (cdr (cdr letExpr))))
      (evalExpr (myLetExpr letExpr) (cons (cons (myletId letExpr) (myLetVal letExpr b)) b))
    )

    ((integer? (car (cdr (cdr letExpr))))
      (evalExpr (myLetExpr letExpr) (cons (cons (myletId letExpr) (myLetVal letExpr b)) b))
    )

    (#t
      (evalExpr (myLetExpr letExpr) (cons (cons (myletId letExpr) (myLetFuncVal letExpr)) b))
    )
  )
)

(define (evalId id b)
  (cond
    ((null? b) #f)
    (#t (cond
      ((equal? id (car (car b))) (cdr (car b)))
      (#t(evalId id (cdr b)))))
  )
)

(define (evalFuncCall expr b)
  (evalExpr   (car (cdr (cdr (evalId (car expr) b))))   (cons (cons (car (cdr (evalId (car expr) b))) (car (cdr expr))) b))
)

;-------------- Helper functions ---------------    (Used by evalMyLet)

(define (myletId letExpr)
  (car (cdr letExpr))
)

(define (myLetVal letExpr b)
  (evalExpr (car (cdr (cdr letExpr))) b)
)

(define (myLetFuncVal letExpr b)
  (car (cdr (cdr letExpr)))
)

(define (myLetExpr letExpr)
  (car (cdr (cdr (cdr letExpr))))
)