;; stub module
;; implementation lives in pre-base.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module pre-base '#%kernel
  (#%require (submod "all.rkt" pre-base))
  (#%provide (all-from (submod "all.rkt" pre-base))))
