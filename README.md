# treap
Racket package implementing balanced binary search trees using treaps.

## Functions

### (make-treap v)

This function takes a number v, and returns a treap containing that value. 

#### Examples
``` Scheme
> (make-treap 1)
#<treap>
> (list-treap (make-treap 2))
'(1)
```

### (insert-treap t v)

This function consumes a treap t, and a number v, and returns t after v is inserted.

#### Examples
``` Scheme
> (list-treap (insert-treap (make-treap 2) 3))
'(2 3)
> (list-treap (insert-treap (make-treap 2) 1))
'(1 2)
```

### (lookup-treap t i)

This function consumes a treap t and a zero-based index i, and returns the i'th largest element of t

#### Examples
``` Scheme
> (lookup-treap (make-treap 2) 0)
2
> (lookup-treap (insert-treap (make-treap 2) 3) 1)
3
> (lookup-treap (insert-treap (make-treap 2) 1) 1)
2
```

### (delete-treap t v)

This function consumes a treap t and a value v and returns t with v deleted

#### Examples
``` Scheme
> (list-treap (delete-treap (make-treap 2) 2))
'()
> (list-treap (delete-treap (insert-treap (make-treap 2) 3) 3))
'(2)
> (list-treap (delete-treap (insert-treap (make-treap 2) 3) 2))
'(3)
```

### (search-treap t v)

Searches a treap t for a value v; returns true if v is found, false otherwise

#### Examples
``` Scheme
> (search-treap (make-treap 2) 2)
#t
> (search-treap (make-treap 2) 3)
#f
```
