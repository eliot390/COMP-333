#lang racket/base
(define (rotate-list-left lst)
  (if (null? lst) '()
    (append (cdr lst)
      (cons (car lst)
        '()))))


(define (rotate-list-left-n lst n)
  (cond ((null? lst) lst)
    ((= n 0) lst)
      (else (rotate-list-left-n (append (cdr lst) (list (car lst))) (- n 1)))))


(define (count-list-elements lst)
  (cond ((null? lst) 0)
   (else (+ 1 (count-list-elements (cdr lst))))))


(define (list-element-n lst n)
  (cond ((null? lst) lst)
    ((= n 0) (car lst))
      ((list-element-n (cdr lst)(- n 1)))))


(define (list-minus-element-n lst n)
  (cond ((null? lst) lst)
    ((= n 0) (cdr lst))
      (else(cons (car lst) (list-minus-element-n (cdr lst)(- n 1))))))


(define (rotate-list-right lst)
  (define n(count-list-elements lst)) 
  (cond ((null? lst) lst)
        (else (cons (list-element-n lst (- n 1))(list-minus-element-n lst (- n 1))))))


(define (reverse-list lst)
  (if (null? lst) lst
    (append (reverse-list (cdr lst)) (cons (car lst) '()))))

      
(define (cons-to-all a lst)
  (cond ((null? lst) lst)
        (else (map (lambda (y)(cons 'a y)) lst))))


(define (ph-1 lst n)
  (cons-to-all (list-element-n lst n)(permute (list-minus-element-n lst n)))
  )

(define (ph-2 lst n)
  (cond ((= n 0)(ph-1 lst 0))
        (else (append(ph-1 lst n)(ph-2 lst (- n 1))))
        )
  )

(define (permute lst)
  (cond ((null? lst) lst)
        ((= (count-list-elements lst) 1) (list lst))
        ((= (count-list-elements lst) 2) (append(list lst)(list(reverse-list lst))))
        (else (ph-2 lst (- (count-list-elements lst) 1)))
        )
  )


(rotate-list-left '())
(rotate-list-left '(a))
(rotate-list-left '(a b c))
(rotate-list-left-n '(a b c) 0)
(rotate-list-left-n '(a b c d e) 2)
(rotate-list-left-n '(a b c d e) 5)
(count-list-elements '())
(count-list-elements '(a))
(count-list-elements '(a b c d e))
(list-element-n '(a b c d e) 0)
(list-element-n '(a b c d e) 4)
(list-element-n '(a b c d e) 1)
(list-minus-element-n '(a b c d e) 0)
(list-minus-element-n '(a b c d e) 1)
(list-minus-element-n '(a b c d e) 2)
(list-minus-element-n '(a b c d e) 4)
(rotate-list-right '(a b c d e))
(rotate-list-right '(a))
(rotate-list-right '(a b))
(rotate-list-right '(a b c d e f g))
(reverse-list '(a))
(reverse-list '(a b))
(reverse-list '(a b c d e))
(cons-to-all 'a '((b c) (d e) (f g)))
(permute '(a b))
(permute '(a b c))
(permute '(a b c d))