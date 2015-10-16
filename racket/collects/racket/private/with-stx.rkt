;; stub module
;; implementation lives in with-stx.rktl
;; real module is now a submodule of stxcase-scheme.rkt
;; see comment at the top of small-scheme.rkt for rationale
(module with-stx '#%kernel
  (#%require (submod "stxcase-scheme.rkt" with-stx))
  (#%provide (all-from (submod "stxcase-scheme.rkt" with-stx))))
