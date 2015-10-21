;; stub module
;; implementation lives in ellipses.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module ellipses '#%kernel
  (#%require (submod "all.rkt" ellipses))
  (#%provide (all-from (submod "all.rkt" ellipses))))
