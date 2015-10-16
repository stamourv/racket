;; stub module
;; implementation lives in qq-and-or.rktl
;; real module is now a submodule of small-scheme.rkt
;; see comment at the top of small-scheme.rkt for rationale
(module qq-and-or '#%kernel
  (#%require (submod "small-scheme.rkt" qq-and-or))
  (#%provide (all-from (submod "small-scheme.rkt" qq-and-or))))
