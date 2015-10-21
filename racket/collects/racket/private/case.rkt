;; stub module
;; implementation lives in case.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module case '#%kernel
  (#%require (submod "all.rkt" case))
  (#%provide (all-from (submod "all.rkt" case))))
