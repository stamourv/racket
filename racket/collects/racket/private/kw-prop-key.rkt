;; stub module
;; implementation lives in kw-prop-key.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module kw-prop-key '#%kernel
  (#%require (submod "all.rkt" kw-prop-key))
  (#%provide (all-from (submod "all.rkt" kw-prop-key))))
