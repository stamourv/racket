;; stub module
;; implementation lives in provide-transform.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module provide-transform '#%kernel
  (#%require (submod "all.rkt" provide-transform))
  (#%provide (all-from (submod "all.rkt" provide-transform))))
