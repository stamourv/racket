(module base "pre-base.rkt"

  (#%require (for-syntax "pre-base.rkt"))

  ;; TODO just copied from syntax collect, then trimmed. fix this
  ;; TODO kept just the "file" case, so I should just use that for my proto-include
  (begin-for-syntax
   (define (resolve-path-spec fn stx)
     (let ([file
            (let ([l (syntax->datum fn)])
              (string->path l))])
       (if (complete-path? file)
           file
           (path->complete-path
            file
            (cond
             ;; Src of include expression is a path?
             [(and (path? (syntax-source stx))
                   (complete-path? (syntax-source stx)))
              (let-values ([(base name dir?)
                            (split-path (syntax-source stx))])
                (if dir?
                    (syntax-source stx)
                    base))]
             ;; Load relative?
             [(current-load-relative-directory)]
             ;; Current directory
             [(current-directory)]))))))

  (define-syntax (do-include stx)
    (let-values ([(l) (syntax->list stx)])
      ;; (_ orig-stx fn)
      (let-values ([(orig-stx) (cadr l)]
                   [(fn) (caddr l)])
        ;; Parse the file name
        (let-values ([(orig-c-file) (resolve-path-spec fn orig-stx)]
                     [(rkt->ss) (lambda (p)
                                  (let ([b (path->bytes p)])
                                    (if (regexp-match? #rx#"[.]rkt$" b)
                                        (path-replace-suffix p #".ss")
                                        p)))])

          (let-values ([(c-file) (if (file-exists? orig-c-file)
                                     orig-c-file
                                     (let ([p2 (rkt->ss orig-c-file)])
                                       (if (file-exists? p2)
                                           p2
                                           orig-c-file)))])

            ;; (register-external-file c-file) ; eh, probably not necessary in this case

            (let ([read-syntax (lambda (src in)
                                 (parameterize ([read-accept-reader #t])
                                   (read-syntax src in)))])

              ;; Open the included file
              (let ([p (with-handlers ([exn:fail?
                                        (lambda (exn)
                                          (raise-syntax-error
                                           #f
                                           (format
                                            "can't open include file (~a)"
                                            (if (exn? exn)
                                                (exn-message exn)
                                                exn))
                                           orig-stx
                                           c-file))])
                         (open-input-file c-file))])
                (port-count-lines! p)
                ;; Read expressions from file
                (let ([content
                       (let loop ()
                         (let ([r (with-handlers ([exn:fail?
                                                   (lambda (exn)
                                                     (close-input-port p)
                                                     (raise-syntax-error
                                                      #f
                                                      (format
                                                       "read error (~a)"
                                                       (if (exn? exn)
                                                           (exn-message exn)
                                                           exn))
                                                      orig-stx))])
                                    (read-syntax c-file p))])
                           (if (eof-object? r)
                               null
                               (cons r (loop)))))])
                  (close-input-port p)
                  ;; Preserve src info for content, but set its
                  ;; lexical context to be that of the include expression
                  (let ([lexed-content
                         (let loop ([content content])
                           (cond
                            [(pair? content)
                             (cons (loop (car content))
                                   (loop (cdr content)))]
                            [(null? content) null]
                            [else
                             (let ([v (syntax-e content)])
                               (datum->syntax
                                orig-stx
                                (cond
                                 [(pair? v) 
                                  (loop v)]
                                 [(vector? v)
                                  (list->vector (loop (vector->list v)))]
                                 [(box? v)
                                  (box (loop (unbox v)))]
                                 [else
                                  v])
                                content
                                content))]))])
                    (datum->syntax
                     (quote-syntax here)
                     (cons 'begin lexed-content)
                     orig-stx))))))))))

  (define-syntax (include stx)
    (let-values ([(fn) (cadr (syntax->list stx))])
      (datum->syntax stx (list 'do-include stx fn) stx)))

  (include "hash.rkt")
  (include "list.rkt")
  (include "string.rkt")
  (include "kw-file.rkt")
  (include "namespace.rkt")
  (include "struct.rkt")
  (include "cert.rkt")
  (include "submodule.rkt")
  (include "generic-interfaces.rkt")

  (#%require (submod "." hash)
             (submod "." list) ; shadows `reverse', `mem{q,v,ber}'
             (submod "." string)
             "stxcase-scheme.rkt" ; below pre-base, so can't pull in here
             "qqstx.rkt" ; idem
             "stx.rkt" ; idem
             (submod "." kw-file)
             (submod "." namespace)
             (submod "." struct)
             (submod "." base) ; cert.rkt
             (submod "." module+) ; submodule.rkt
             (submod "." generic-interfaces)
             (for-syntax "stxcase-scheme.rkt"))

  (#%provide (all-from-except "pre-base.rkt"
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
             (all-from-except (submod "." hash) paired-fold)
             (all-from (submod "." list))
             (all-from-except (submod "." string)
                              -regexp-replace*)
             (rename -regexp-replace* regexp-replace*)
             identifier?
             (all-from-except "stxcase-scheme.rkt" datum datum-case with-datum)
             (all-from-except "qqstx.rkt" quasidatum undatum undatum-splicing)
             (all-from (submod "." namespace))
             (all-from (submod "." base)) ; cert.rkt
             (all-from (submod "." module+)) ; submodule.rkt
             (all-from (submod "." generic-interfaces))
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
