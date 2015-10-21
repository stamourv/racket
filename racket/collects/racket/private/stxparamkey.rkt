;; stub module
;; implementation lives in stxparamkey.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module stxparamkey '#%kernel
  (#%require (submod "all.rkt" stxparamkey))
  (#%provide (all-from (submod "all.rkt" stxparamkey))))
