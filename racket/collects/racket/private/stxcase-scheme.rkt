;; stub module
;; implementation lives in stxcase-scheme.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module stxcase-scheme '#%kernel
  (#%require (submod "all.rkt" stxcase-scheme))
  (#%provide (all-from (submod "all.rkt" stxcase-scheme))))
