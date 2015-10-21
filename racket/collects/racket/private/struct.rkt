;; stub module
;; implementation lives in struct.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module struct '#%kernel
  (#%require (submod "all.rkt" struct))
  (#%provide (all-from (submod "all.rkt" struct))))
