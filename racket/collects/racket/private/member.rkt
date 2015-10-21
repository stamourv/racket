;; stub module
;; implementation lives in member.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module member '#%kernel
  (#%require (submod "all.rkt" member))
  (#%provide (all-from (submod "all.rkt" member))))
