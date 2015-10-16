(module procedure-alias '#%kernel
  (#%require "define.rkt"
             "small-scheme.rkt"
             "more-scheme.rkt"
             "kw-prop-key.rkt"
             (for-syntax '#%kernel
                         (submod "small-scheme.rkt" stx)
                         "small-scheme.rkt"
                         "stxcase-scheme.rkt"
                         "name.rkt"
                         (submod "define.rkt" norm-define)
                         (submod "define.rkt" qqstx)
                         "sort.rkt"))
  
  (#%provide syntax-procedure-alias-property alias-of)
  (define (syntax-procedure-alias-property stx)
    (unless (syntax? stx)
      (raise-argument-error 'syntax-procedure-alias "syntax?" stx))
    (syntax-property stx alias-of)))
