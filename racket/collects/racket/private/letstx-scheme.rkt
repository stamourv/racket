;; stub module
;; implementation lives in letstx-scheme.rktl
;; real module is now a submodule of define.rkt
;; see comment at the top of small-scheme.rkt for rationale
(module letstx-scheme '#%kernel
  (#%require (submod "define.rkt" letstx-scheme))
  (#%provide (all-from (submod "define.rkt" letstx-scheme))))
