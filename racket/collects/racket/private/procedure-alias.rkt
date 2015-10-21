;; stub module
;; implementation lives in procedure-alias.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module procedure-alias '#%kernel
  (#%require (submod "all.rkt" procedure-alias))
  (#%provide (all-from (submod "all.rkt" procedure-alias))))
