;; stub module
;; implementation lives in misc.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module misc '#%kernel
  (#%require (submod "all.rkt" misc))
  (#%provide (all-from (submod "all.rkt" misc))))
