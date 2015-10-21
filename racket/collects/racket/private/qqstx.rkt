;; stub module
;; implementation lives in qqstx.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module qqstx '#%kernel
  (#%require (submod "all.rkt" qqstx))
  (#%provide (all-from (submod "all.rkt" qqstx))))
