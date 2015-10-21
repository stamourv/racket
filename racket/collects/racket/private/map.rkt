;; stub module
;; implementation lives in map.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module map '#%kernel
  (#%require (submod "all.rkt" map))
  (#%provide (all-from (submod "all.rkt" map))))
