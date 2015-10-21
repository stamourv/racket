;; stub module
;; implementation lives in define.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module define '#%kernel
  (#%require (submod "all.rkt" define))
  (#%provide (all-from (submod "all.rkt" define))))
