;; stub module
;; implementation lives in reqprov.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module reqprov '#%kernel
  (#%require (submod "all.rkt" reqprov))
  (#%provide (all-from (submod "all.rkt" reqprov))))
