;; stub module
;; implementation lives in more-scheme.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module more-scheme '#%kernel
  (#%require (submod "all.rkt" more-scheme))
  (#%provide (all-from (submod "all.rkt" more-scheme))))
