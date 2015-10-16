;; stub module
;; implementation lives in stxcase.rktl
;; real module is now a submodule of stxcase-scheme.rkt
;; see comment at the top of small-scheme.rkt for rationale
(module stxcase '#%kernel
  (#%require (submod "stxcase-scheme.rkt" stxcase))
  (#%provide (all-from (submod "stxcase-scheme.rkt" stxcase))))
