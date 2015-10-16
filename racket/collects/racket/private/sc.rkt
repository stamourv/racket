;; stub module
;; implementation lives in sc.rktl
;; real module is now a submodule of stxcase-scheme.rkt
;; see comment at the top of small-scheme.rkt for rationale
(module sc '#%kernel
  (#%require (submod "stxcase-scheme.rkt" sc))
  (#%provide (all-from (submod "stxcase-scheme.rkt" sc))))
