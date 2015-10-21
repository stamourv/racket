;; stub module
;; implementation lives in norm-arity.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module norm-arity '#%kernel
  (#%require (submod "all.rkt" norm-arity))
  (#%provide (all-from (submod "all.rkt" norm-arity))))
