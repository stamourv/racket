;; stub module
;; implementation lives in with-stx.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module with-stx '#%kernel
  (#%require (submod "all.rkt" with-stx))
  (#%provide (all-from (submod "all.rkt" with-stx))))
