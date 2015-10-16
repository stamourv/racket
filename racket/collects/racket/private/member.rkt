;; stub module
;; implementation lives in member.rktl
;; real module is now a submodule of small-scheme.rkt
;; see comment at the top of small-scheme.rkt for rationale
(module member '#%kernel
  (#%require (submod "small-scheme.rkt" member))
  (#%provide (all-from (submod "small-scheme.rkt" member))))
