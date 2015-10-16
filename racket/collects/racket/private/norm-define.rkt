;; stub module
;; implementation lives in norm-define.rktl
;; real module is now a submodule of define.rkt
;; see comment at the top of small-scheme.rkt for rationale
(module norm-define '#%kernel
  (#%require (submod "define.rkt" norm-define))
  (#%provide (all-from (submod "define.rkt" norm-define))))
