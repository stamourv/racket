;; stub module
;; implementation lives in cert.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module cert '#%kernel
  (#%require (submod "all.rkt" cert))
  (#%provide (all-from (submod "all.rkt" cert))))
