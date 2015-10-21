;; stub module
;; implementation lives in cond.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module cond '#%kernel
  (#%require (submod "all.rkt" cond))
  (#%provide (all-from (submod "all.rkt" cond))))
