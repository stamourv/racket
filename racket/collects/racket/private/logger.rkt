;; stub module
;; implementation lives in logger.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module logger '#%kernel
  (#%require (submod "all.rkt" logger))
  (#%provide (all-from (submod "all.rkt" logger))))
