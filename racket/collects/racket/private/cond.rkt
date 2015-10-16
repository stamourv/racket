;; stub module
;; implementation lives in cond.rktl
;; real module is now a submodule of small-scheme.rkt
;; see comment at the top of small-scheme.rkt for rationale
(module cond '#%kernel
  (#%require (submod "small-scheme.rkt" cond))
  (#%provide (all-from (submod "small-scheme.rkt" cond))))
