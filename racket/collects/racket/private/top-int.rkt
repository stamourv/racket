;; stub module
;; implementation lives in top-int.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module top-int '#%kernel
  (#%require (submod "all.rkt" top-int))
  (#%provide (all-from (submod "all.rkt" top-int))))
