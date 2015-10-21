;; stub module
;; implementation lives in name.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module name '#%kernel
  (#%require (submod "all.rkt" name))
  (#%provide (all-from (submod "all.rkt" name))))
