;; stub module
;; implementation lives in hash.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module hash '#%kernel
  (#%require (submod "all.rkt" hash))
  (#%provide (all-from (submod "all.rkt" hash))))
