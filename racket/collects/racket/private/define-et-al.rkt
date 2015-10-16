;; stub module
;; implementation lives in define-et-al.rktl
;; real module is now a submodule of small-scheme.rkt
;; see comment at the top of small-scheme.rkt for rationale
(module define-et-al '#%kernel
  (#%require (submod "small-scheme.rkt" define-et-al))
  (#%provide (all-from (submod "small-scheme.rkt" define-et-al))))
