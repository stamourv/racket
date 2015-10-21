;; stub module
;; implementation lives in namespace.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module namespace '#%kernel
  (#%require (submod "all.rkt" namespace))
  (#%provide (all-from (submod "all.rkt" namespace))))
