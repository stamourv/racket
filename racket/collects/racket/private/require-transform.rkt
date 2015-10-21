;; stub module
;; implementation lives in require-transform.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module require-transform '#%kernel
  (#%require (submod "all.rkt" require-transform))
  (#%provide (all-from (submod "all.rkt" require-transform))))
