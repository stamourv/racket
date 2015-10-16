;; stub module
;; implementation lives in qqstx.rktl
;; real module is now a submodule of define.rkt
;; see comment at the top of small-scheme.rkt for rationale
(module qqstx '#%kernel
  (#%require (submod "define.rkt" qqstx))
  (#%provide (all-from (submod "define.rkt" qqstx))))
