#lang racket
;; Provide access to functions to
;; 1. make a treap
;; 2. insert an arbitrary element into a treap
;; 3. lookup the kth element in a treap
;; 4. test if an element exists in a treap
;; 5. delete an element in a treap
(provide make-treap insert-treap lookup-treap search-treap delete-treap)

;; Definition of treap type: contains node value for searches, priority for self-balancing, and pointers to left, right subtrees
(struct treap (val priority left right size))

;; Constructs a treap given a value; this automatically generates a priority
(define (make-treap v)
  (treap v (random 1 (expt 2 31)) null null 1))

;; merge: treap, treap -> treap
;; constructs a treap consisting of all the elements
;; in both treaps. all elements in t1 must be less than
;; all elements in t2
(define (merge t1 t2)
  (cond
    [(null? t1) t2]
    [(null? t2) t1]
    [(< (treap-priority t1) (treap-priority t2)) (treap (treap-val t1) (treap-priority t1) (treap-left t1) (merge (treap-right t1) t2) (+ 1 (size-treap t1) (size-treap t2)))]
    [else (treap (treap-val t2) (treap-priority t2) (merge t1 (treap-left t2)) (treap-right t2) (+ 1 (size-treap t1) (size-treap t2)))]))

;; split: treap, number -> (cons treap treap)
;; splits a treap around a given value, returning
;; all numbers less than the value in car, and
;; all elements not less in cdr
(define (split t k)
  (cond
    [(null? t) (cons null null)]
    [(< (treap-val t) k) (let ([r (split (treap-right t) k)])
                           (cons (merge (treap (treap-val t) (treap-priority t) (treap-left t) null (+ 1 (size-treap (treap-left t)))) (car r)) (cdr r)))]
    [else (let ([r (split (treap-left t) k)])
            (cons (car r) (merge (cdr r) (treap (treap-val t) (treap-priority t) null (treap-right t) (+ 1 (size-treap (treap-right t)))))))]))

;; returns the size of the treap in O(1)
(define (size-treap t)
  (if (null? t)
      0
      (treap-size t)))

;; lookup-treap: treap, number -> number
;; returns the i'th larges element (0-indexed) in the treap
;; runs in 
(define (lookup-treap t i)
  (cond
    [(< (size-treap (treap-left t)) i) (lookup-treap (treap-left t) i)]
    [(= (size-treap (treap-left t)) i) (treap-val t)]
    [else (lookup-treap (treap-right t) (- i (add1 (size-treap (treap-left t)))))]))

;; insert-treap: treap, number -> treap
;; returns a treap consisting of every element
;; in the original treap, as well as
;; the given new value
(define (insert-treap t v)
  (let ([r (split t v)])
    (merge (merge (car r) (make-treap v)) (cdr r))))

;; delete-treap: treap, number -> treap
;; returns a treap consisting of every element
;; in the original treap except the given number
;; runs in O(log |T|)
(define (delete-treap t v)
  (merge (car (split t v)) (cdr (split t (add1 v)))))

;; search-treap: treap, number -> boolean
;; test if the number given is a value for some node in the treap
;; returns #t if it is, #f otherwise
;; runs in O(log |T|)
(define (search-treap t v)
  (cond
    [(empty? t) #f]
    [(= v (treap-val t)) #t]
    [(> v (treap-val t)) (search-treap (treap-right t) v)]
    [else (search-treap (treap-left t) v)]))

;; Helper for testing
(define (list-treap t)
  (if (null? t)
      '()
      (append (list-treap (treap-left t)) (list (treap-val t)) (list-treap (treap-right t)))))
