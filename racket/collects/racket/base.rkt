(module base "private/base.rkt" ; (submod "private/all.rkt" base)
  (provide (all-from-out "private/base.rkt" ; (submod "private/all.rkt" base)
            ))

  (module reader syntax/module-reader
    racket/base))
