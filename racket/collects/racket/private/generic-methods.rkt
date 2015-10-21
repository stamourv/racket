;; stub module
;; implementation lives in generic-methods.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module generic-methods '#%kernel
  (#%require (submod "all.rkt" generic-methods))
  (#%provide (all-from (submod "all.rkt" generic-methods))))
