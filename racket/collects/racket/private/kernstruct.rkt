;; stub module
;; implementation lives in kernstruct.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module kernstruct '#%kernel
  (#%require (submod "all.rkt" kernstruct))
  (#%provide (all-from (submod "all.rkt" kernstruct))))
