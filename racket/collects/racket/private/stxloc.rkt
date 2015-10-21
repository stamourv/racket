;; stub module
;; implementation lives in stxloc.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module stxloc '#%kernel
  (#%require (submod "all.rkt" stxloc))
  (#%provide (all-from (submod "all.rkt" stxloc))))
