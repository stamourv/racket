;; stub module
;; implementation lives in kw-file.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module kw-file '#%kernel
  (#%require (submod "all.rkt" kw-file))
  (#%provide (all-from (submod "all.rkt" kw-file))))
