;; stub module
;; implementation lives in submodule.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module submodule '#%kernel
  (#%require (submod "all.rkt" submodule))
  (#%provide (all-from (submod "all.rkt" submodule))))
