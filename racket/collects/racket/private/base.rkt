;; stub module
;; implementation lives in base.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module base '#%kernel
  (#%require "all.rkt" ; to initialize the submodule cache ; TODO didn't work...
             (submod "all.rkt" base))
  (#%provide (all-from (submod "all.rkt" base))))
