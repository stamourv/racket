;; stub module
;; implementation lives in define-et-al.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module define-et-al '#%kernel
  (#%require (submod "all.rkt" define-et-al))
  (#%provide (all-from (submod "all.rkt" define-et-al))))
