;; stub module
;; implementation lives in letstx-scheme.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module letstx-scheme '#%kernel
  (#%require (submod "all.rkt" letstx-scheme))
  (#%provide (all-from (submod "all.rkt" letstx-scheme))))
