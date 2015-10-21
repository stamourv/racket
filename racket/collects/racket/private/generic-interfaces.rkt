;; stub module
;; implementation lives in generic-interfaces.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module generic-interfaces '#%kernel
  (#%require (submod "all.rkt" generic-interfaces))
  (#%provide (all-from (submod "all.rkt" generic-interfaces))))
