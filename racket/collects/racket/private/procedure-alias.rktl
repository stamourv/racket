(module procedure-alias '#%kernel
  (#%require (submod ".." define)
             (submod ".." small-scheme)
             (submod ".." more-scheme)
             (submod ".." kw-prop-key)
             (for-syntax '#%kernel
                         (submod ".." stx)
                         (submod ".." small-scheme)
                         (submod ".." stxcase-scheme)
                         (submod ".." name)
                         (submod ".." norm-define)
                         (submod ".." qqstx)
                         (submod ".." sort)))
  
  (#%provide syntax-procedure-alias-property alias-of)
  (define (syntax-procedure-alias-property stx)
    (unless (syntax? stx)
      (raise-argument-error 'syntax-procedure-alias "syntax?" stx))
    (syntax-property stx alias-of)))
