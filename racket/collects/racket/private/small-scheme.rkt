;; stub module
;; implementation lives in small-scheme.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module small-scheme '#%kernel
  (#%require (submod "all.rkt" small-scheme))
  (#%provide (all-from (submod "all.rkt" small-scheme))))
