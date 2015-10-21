;; stub module
;; implementation lives in norm-define.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module norm-define '#%kernel
  (#%require (submod "all.rkt" norm-define))
  (#%provide (all-from (submod "all.rkt" norm-define))))
