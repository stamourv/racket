;; stub module
;; implementation lives in kw.rktl
;; real module is now a submodule of all.rkt
;; see comment at the top of all.rkt for rationale
(module kw '#%kernel
  (#%require (submod "all.rkt" kw))
  (#%provide (all-from (submod "all.rkt" kw))))
