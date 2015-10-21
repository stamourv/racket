(module base (submod ".." pre-base)

  (#%require (submod ".." hash)
             (submod ".." list) ; shadows `reverse', `mem{q,v,ber}'
             (submod ".." string)
             (submod ".." stxcase-scheme)
             (submod ".." qqstx)
             (submod ".." stx)
             (submod ".." kw-file)
             (submod ".." namespace)
             (submod ".." struct)
             (submod ".." cert)
             (submod ".." submodule)
             (submod ".." generic-interfaces)
             (for-syntax (submod ".." stxcase-scheme)))

  (#%provide (all-from-except (submod ".." pre-base)
                              open-input-file
                              open-output-file
                              open-input-output-file
                              call-with-input-file
                              call-with-output-file
                              with-input-from-file
                              with-output-to-file
                              directory-list
                              regexp-replace*
                              new-apply-proc)
             struct
             (all-from-except (submod ".." hash) paired-fold)
             (all-from (submod ".." list))
             (all-from-except (submod ".." string) 
                              -regexp-replace*)
             (rename -regexp-replace* regexp-replace*)
             identifier?
             (all-from-except (submod ".." stxcase-scheme) datum datum-case with-datum)
             (all-from-except (submod ".." qqstx) quasidatum undatum undatum-splicing)
             (all-from (submod ".." namespace))
             (all-from (submod ".." cert))
             (all-from (submod ".." submodule))
             (all-from (submod ".." generic-interfaces))
             (for-syntax syntax-rules syntax-id-rules ... _)
             (rename -open-input-file open-input-file)
             (rename -open-output-file open-output-file)
             (rename -open-input-output-file open-input-output-file)
             (rename -call-with-input-file call-with-input-file)
             (rename -call-with-output-file call-with-output-file)
             (rename -with-input-from-file with-input-from-file)
             (rename -with-output-to-file with-output-to-file)
             (rename -directory-list directory-list)
             call-with-input-file*
             call-with-output-file*))
