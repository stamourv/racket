;; stub module
;; implementation lives in stxloc.rktl
;; real module is now a submodule of stxcase-scheme.rkt
;; see comment at the top of small-scheme.rkt for rationale
(module stxloc '#%kernel
  (#%require (submod "stxcase-scheme.rkt" stxloc))
  (#%provide (all-from (submod "stxcase-scheme.rkt" stxloc))))
