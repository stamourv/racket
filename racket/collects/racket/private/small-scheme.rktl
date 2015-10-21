
;;----------------------------------------------------------------------
;; assembles all basic forms we have so far

(module small-scheme '#%kernel
  (#%require (submod ".." qq-and-or) (submod ".." cond) (submod ".." define-et-al))

  (#%provide (all-from (submod ".." qq-and-or))
             (all-from (submod ".." cond))
             (all-from (submod ".." define-et-al))))

