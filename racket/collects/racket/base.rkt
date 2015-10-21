(module base (submod "private/all.rkt" base)
  (provide (all-from-out (submod "private/all.rkt" base)))

  (module reader syntax/module-reader
    racket/base))
