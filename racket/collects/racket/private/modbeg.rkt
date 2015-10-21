;; stub module
;; implementation lives in modbeg.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module modbeg '#%kernel
  (#%require (submod "all.rkt" modbeg))
  (#%provide (all-from (submod "all.rkt" modbeg))))
