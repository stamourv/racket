;; stub module
;; implementation lives in stx.rktl
;; real module is now a submodule of small-scheme.rkt
;; see comment at the top of small-scheme.rkt for rationale
(module stx '#%kernel
  (#%require (submod "small-scheme.rkt" stx))
  (#%provide (all-from (submod "small-scheme.rkt" stx))))
