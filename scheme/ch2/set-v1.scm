#lang racket

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))
(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))
(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1) (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))
(define (union-set xs ab)
  (cond ((and (null? xs) (not (null? ab)))
         (ab))
        ((and (null? ab) (not (null? xs)))
         (xs))
        ((and (null? ab) (null? xs))
         '())
        ((element-of-set? (car xs) (cdr ab))
         (union-set (cdr xs) (cdr ab)))
        ((equal? (car xs) (car ab))
         (adjoin-set (car xs) (union-set (cdr xs) (cdr ab))))
        (else
         (adjoin-set (car xs)
                     (adjoin-set (car ab) (union-set (cdr xs) (cdr ab)))))))
(union-set '(1 2 3) '(3 4 5))
