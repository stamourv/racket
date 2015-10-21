;; stub module
;; implementation lives in struct-info.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module struct-info '#%kernel
  (#%require (submod "all.rkt" struct-info))
  (#%provide (all-from (submod "all.rkt" struct-info))))
