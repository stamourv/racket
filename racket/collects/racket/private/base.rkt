;; stub module
;; implementation lives in base.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module base '#%kernel
  (#%require (submod "all.rkt" base))
  (#%provide (all-from (submod "all.rkt" base))))
