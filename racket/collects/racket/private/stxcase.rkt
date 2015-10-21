;; stub module
;; implementation lives in stxcase.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module stxcase '#%kernel
  (#%require (submod "all.rkt" stxcase))
  (#%provide (all-from (submod "all.rkt" stxcase))))
