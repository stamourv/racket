
(module struct '#%kernel
  (#%require (submod ".." define)
             (submod ".." define-struct)
             (for-syntax '#%kernel (submod ".." define)
                         (submod ".." stx) (submod ".." stxcase-scheme) (submod ".." small-scheme) 
                         (submod ".." stxloc)))

  (#%provide struct)

  (define-syntax (struct stx)
    (define (config-has-name? config)
      (cond
       [(syntax? config) (config-has-name? (syntax-e config))]
       [(pair? config) (or (eq? (syntax-e (car config)) '#:constructor-name)
                           (eq? (syntax-e (car config)) '#:extra-constructor-name)
                           (config-has-name? (cdr config)))]
       [else #f]))
    (with-syntax ([orig stx])
      (syntax-case stx ()
        [(_ id super-id fields . config)
         (and (identifier? #'id)
              (identifier? #'super-id))
         (if (not (config-has-name? #'config))
             (syntax/loc stx
               (define-struct/derived orig (id super-id) fields  #:constructor-name id . config))
             (syntax/loc stx
               (define-struct/derived orig (id super-id) fields . config)))]
        [(_ id fields . config)
         (identifier? #'id)
         (if (not (config-has-name? #'config))
             (syntax/loc stx
               (define-struct/derived orig id fields  #:constructor-name id . config))
             (syntax/loc stx
               (define-struct/derived orig id fields . config)))]
        [(_ id . rest)
         (identifier? #'id)
         (syntax/loc stx
           (define-struct/derived orig id . rest))]
        [(_ thing . _)
         (raise-syntax-error #f
                             "expected an identifier for the structure type name"
                             stx
                             #'thing)]))))
