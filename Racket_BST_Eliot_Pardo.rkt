#lang racket

(struct node (value count left right) #:mutable #:transparent)

(define-namespace-anchor anc)
(define ns (namespace-anchor->namespace anc))

(define (bst? n)
  (cond
    ((null? n) #t)
    ((not (node? n)) #f)
    ((and (null? (node-left n))
          (null? (node-right n))) #t)

    ((and (null? (node-right n))
          (< (node-value (node-left n)) (node-value n))
          (bst? (node-left n))) #t)

    ((and (null? (node-left n))
          (> (node-value (node-right n)) (node-value n))
          (bst? (node-right n))) #t)

    ((and (not (null? (node-left n))) (not (null? (node-right n)))
          (< (node-value (node-left n)) (node-value n))
          (bst? (node-left n))
          (> (node-value (node-right n)) (node-value n))
          (bst? (node-right n))))
))

(define (find-path n v)
  (cond
    ((null? n) '())
    ((= v (node-value n)) (list n))
    
    ((and (< v (node-value n)) (null? (node-left n))) (list n))
    
    ((and (< v (node-value n))
          (not (null? (node-left n))))
          (append (find-path (node-left n)v) (list n)))
    
    ((and (> v (node-value n)) (null? (node-right n))) (list n))
    
    ((and (> v (node-value n))
          (not (null? (node-right n))))
          (append (find-path (node-right n) v) (list n)))
))

(define (node-list-to-value-list x)
  (cond
    ((null? x) '())
    ((null? (cdr x)) (list (node-value (car x))))
    (else (cons (node-value (car x)) (node-list-to-value-list (cdr x))))
))

(define (traverse n)
  (cond
    ((null? n) '())
    (else (append (traverse (node-left n)) (list n) (traverse (node-right n))))
))

(define (inorder? x) ;??????
  (cond
    ((= (length x) 1) #t)
    (else (< (node-value(car x)) (node-value(cadr x)))
          (inorder? (cdr x)) x)
))

(define (insert n v)
  (let ((stack (find-path n v)))
    (cond
      ((null? stack) (node v 1 null null))
      ((and (= v (node-value(car stack))))
            (set-node-count! (car stack) (+ 1 (node-count(car stack)))) n)
      ((and (< v (node-value(car stack))))
            (set-node-left! (car stack) (node v 1 null null)) n)
      ((and (> v (node-value(car stack))))
            (set-node-right! (car stack) (node v 1 null null)) n)
)))

(define (random-value range)
  (inexact->exact (floor (* range (random))))
)
  
(define (random-list n range)
  (cond
    ((= n 0) '())
    (else (cons (random-value range) (random-list (- n 1) range))
)))

(define (get-child-count n)
  (cond
    ((and (null? (node-left n))
          (null? (node-right n))) 0)
    ((and (not (null? (node-left n))) (not (null? (node-right n)))) 2)
    (else 1)
))

(define (find-path-iop n)
  (cond
    ((null? (node-right (node-left n))) (list (node-left n) n))
    ((append (find-path-iop-right (node-left n)) (list n)))
))

(define (find-path-iop-right n)
  (cond
    ((null? (node-right n)) (list n))
    ((append (find-path-iop-right (node-right n)) (list n)))
))

(define (delete-0 n stack)
  (cond
    ((null? (cdr stack)) null)
    
    ((equal? (node-left (cadr stack)) (car stack))
     (set-node-left! (cadr stack) null) n)

    ((equal? (node-right (cadr stack)) (car stack))
     (set-node-right! (cadr stack) null) n)
))

(define (delete-1 n stack)
  (cond
    ((and (null? (cdr stack))
          (not (null? (node-left (car stack))))) (node-left (car stack)))

    ((and (null? (cdr stack))
          (not (null? (node-right (car stack))))) (node-right (car stack)))
    
    ((and (equal? (node-left (cadr stack)) (car stack))
          (not (null? (node-left (car stack))))) (set-node-left! (cadr stack) (node-left (car stack))) n)
    
    ((and (equal? (node-left (cadr stack)) (car stack))
          (not (null? (node-right (car stack))))) (set-node-left! (cadr stack) (node-right (car stack))) n)
    
    ((and (equal? (node-right (cadr stack)) (car stack))
          (not (null? (node-left (car stack))))) (set-node-right! (cadr stack) (node-left (car stack))) n)
    
    ((and (equal? (node-right (cadr stack)) (car stack))
          (not (null? (node-right (car stack))))) (set-node-right! (cadr stack) (node-right (car stack))) n)
))

(define (delete-2 n stack)
  (let ((iopstack (find-path-iop (car stack))))
    (cond
      ((and (equal? (node-left (cadr iopstack)) (car iopstack)) (empty? (node-right (car iopstack))))
        (set-node-value! (car stack)(node-value (car iopstack)))
        (set-node-count! (car stack)(node-count (car iopstack)))
        (set-node-left! (cadr iopstack)(node-left (car iopstack))) n)
      
      ((and (equal? (node-right (cadr iopstack)) (car iopstack)) (empty? (node-right (car iopstack))))
        (set-node-value! (car stack)(node-value (car iopstack)))
        (set-node-count! (car stack)(node-count (car iopstack)))
        (set-node-right! (cadr iopstack)(node-left (car iopstack))) n)
)))

(define (delete-by-case n stack)
  (let ((count (get-child-count (car stack))))
    (cond
      ((= count 0) (delete-0 n stack))
      ((= count 1) (delete-1 n stack))
      ((= count 2) (delete-2 n stack))
)))

(define (delete n v)
  (let ((stack (find-path n v)))
    (cond
      ((null? stack) '())
      
      ((not (= v (node-value(car stack)))) n)
      
      ((and (= v (node-value(car stack)))
            (> (node-count (car stack)) 1)) (set-node-count! (car stack) (- (node-count(car stack)) 1)) n)
      
      ((and (= v (node-value(car stack)))
            (= (node-count (car stack)) 1))
               (delete-by-case n stack))
)))

;***************testing***************
(define tree-01 '())
(define list-01 (random-list 20 1000))
(map (lambda (v) (set! tree-01 (insert tree-01 v))(node-list-to-value-list (traverse tree-01)))list-01)
(map (lambda (x) (set! tree-01 (delete tree-01 x))(node-list-to-value-list (traverse tree-01)))list-01)
