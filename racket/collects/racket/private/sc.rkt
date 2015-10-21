;; stub module
;; implementation lives in sc.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module sc '#%kernel
  (#%require (submod "all.rkt" sc))
  (#%provide (all-from (submod "all.rkt" sc))))
