;; stub module
;; implementation lives in stx.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module stx '#%kernel
  (#%require (submod "all.rkt" stx))
  (#%provide (all-from (submod "all.rkt" stx))))
