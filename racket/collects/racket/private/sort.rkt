;; stub module
;; implementation lives in sort.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module sort '#%kernel
  (#%require (submod "all.rkt" sort))
  (#%provide (all-from (submod "all.rkt" sort))))
