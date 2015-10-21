;; stub module
;; implementation lives in list.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module list '#%kernel
  (#%require (submod "all.rkt" list))
  (#%provide (all-from (submod "all.rkt" list))))
