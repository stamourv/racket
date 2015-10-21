;; stub module
;; implementation lives in performance-hint.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module performance-hint '#%kernel
  (#%require (submod "all.rkt" performance-hint))
  (#%provide (all-from (submod "all.rkt" performance-hint))))
