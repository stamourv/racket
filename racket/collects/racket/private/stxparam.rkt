;; stub module
;; implementation lives in stxparam.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module stxparam '#%kernel
  (#%require (submod "all.rkt" stxparam))
  (#%provide (all-from (submod "all.rkt" stxparam))))
