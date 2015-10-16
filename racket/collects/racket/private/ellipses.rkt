;; stub module
;; implementation lives in ellipses.rktl
;; real module is now a submodule of stxcase-scheme.rkt
;; see comment at the top of small-scheme.rkt for rationale
(module ellipses '#%kernel
  (#%require (submod "stxcase-scheme.rkt" ellipses))
  (#%provide (all-from (submod "stxcase-scheme.rkt" ellipses))))
