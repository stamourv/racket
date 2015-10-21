;; stub module
;; implementation lives in reverse.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module reverse '#%kernel
  (#%require (submod "all.rkt" reverse))
  (#%provide (all-from (submod "all.rkt" reverse))))
