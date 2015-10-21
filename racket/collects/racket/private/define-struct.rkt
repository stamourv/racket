;; stub module
;; implementation lives in define-struct.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module define-struct '#%kernel
  (#%require (submod "all.rkt" define-struct))
  (#%provide (all-from (submod "all.rkt" define-struct))))
