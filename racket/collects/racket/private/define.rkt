
;;----------------------------------------------------------------------
;; #%define : define and define-syntax

(module define '#%kernel
  (#%require (submod "small-scheme.rkt" proto-include))

  ;; all the modules below us, but above stxcase-scheme.rkt, in topological order
  ;; see comments in small-scheme.rkt for rationale
  (proto-include "qqstx.rktl")
  (proto-include "norm-define.rktl")
  (proto-include "letstx-scheme.rktl")

  (#%require (for-syntax '#%kernel
                         "stxcase-scheme.rkt"
                         (submod "small-scheme.rkt" stx)
                         (submod "." letstx-scheme)
                         (submod "." qqstx)
                         (submod "." norm-define)))

  (#%provide define 
             define-syntax 
             define-values-for-syntax
             define-for-syntax)

  (define-syntaxes (define-values-for-syntax)
    (lambda (stx)
      (syntax-case stx ()
        [(_ (id ...) expr)
         (begin
           (for-each (lambda (x)
                       (unless (identifier? x)
                         (raise-syntax-error #f "not an identifier" x stx)))
                     (syntax->list #'(id ...)))
           #'(begin-for-syntax
              (define-values (id ...) expr)))])))

  (define-syntaxes (define define-syntax define-for-syntax)
    (let ([go
	   (lambda (define-values-stx stx)
             (let-values ([(id rhs)
                           (normalize-definition stx #'lambda #t #f)])
               (quasisyntax/loc stx
                 (#,define-values-stx (#,id) #,rhs))))])
      (values (lambda (stx) (go #'define-values stx))
	      (lambda (stx) (go #'define-syntaxes stx))
              (lambda (stx) (go #'define-values-for-syntax stx))))))
