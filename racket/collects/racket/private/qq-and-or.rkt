;; stub module
;; implementation lives in qq-and-or.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module qq-and-or '#%kernel
  (#%require (submod "all.rkt" qq-and-or))
  (#%provide (all-from (submod "all.rkt" qq-and-or))))
