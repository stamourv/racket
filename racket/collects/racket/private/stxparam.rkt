
(module stxparam '#%kernel
  (#%require "define.rkt"
             "letstx-scheme.rkt"
             (for-syntax '#%kernel 
                         "stx.rkt" "stxcase-scheme.rkt" 
                         "small-scheme.rkt" 
                         "stxloc.rkt" "stxparamkey.rkt"))

  (#%provide (for-syntax do-syntax-parameterize)
             define-syntax-parameter syntax-parameterize)

  (define-for-syntax (do-syntax-parameterize stx let-syntaxes-id empty-body-ok? keep-orig?)
    (syntax-case stx ()
      [(_ ([id val] ...) body ...)
       (let ([ids (syntax->list #'(id ...))])
	 (with-syntax ([(gen-id ...)
			(map (lambda (id)
			       (unless (identifier? id)
				 (raise-syntax-error
				  #f
				  "not an identifier"
				  stx
				  id))
			       (let* ([rt (syntax-local-value id (lambda () #f))]
				      [sp (if (set!-transformer? rt)
					      (set!-transformer-procedure rt)
					      rt)])
				 (unless (syntax-parameter? sp)
				   (raise-syntax-error
				    #f
				    "not bound as a syntax parameter"
				    stx
				    id))
				 (syntax-local-get-shadower
				  (syntax-local-introduce (syntax-parameter-target sp))
                                  #t)))
			     ids)])
	   (let ([dup (check-duplicate-identifier ids)])
	     (when dup
	       (raise-syntax-error
		#f
		"duplicate binding"
		stx
		dup)))
           (unless empty-body-ok?
             (when (null? (syntax-e #'(body ...)))
               (raise-syntax-error
                #f
                "missing body expression(s)"
                stx)))
           (with-syntax ([let-syntaxes let-syntaxes-id]
                         [(orig ...) (if keep-orig?
                                         (list ids)
                                         #'())])
             (syntax/loc stx
               (let-syntaxes ([(gen-id) (convert-renamer val)] ...)
                 orig ...
                 body ...)))))]))

  (define-syntax (define-syntax-parameter stx)
    (syntax-case stx ()
      [(_ id init-val)
       (with-syntax ([gen-id (car (generate-temporaries (list #'id)))])
	 #'(begin
	     (define-syntax gen-id (convert-renamer init-val))
	     (define-syntax id
	       (let ([gen-id #'gen-id])
		 (make-set!-transformer
		  (make-syntax-parameter
		   (lambda (stx)
		     (let ([v (syntax-parameter-target-value gen-id)])
		       (apply-transformer v stx #'set!)))
		   gen-id))))))]))

  (define-syntax (syntax-parameterize stx)
    (do-syntax-parameterize stx #'let-syntaxes #f #f)))
