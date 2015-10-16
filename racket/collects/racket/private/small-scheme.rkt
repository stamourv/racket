
;;----------------------------------------------------------------------
;; assembles all basic forms we have so far

(module small-scheme '#%kernel

  ;; Trimmed down version of `include`.

  ;; The idea is: to reduce startup time, we want to load a few larger zos,
  ;; instead of a bunch of small ones. But, we want to develop in small files,
  ;; and we need small modules to build in layers.

  ;; Submodules to the rescue. We can turn a lot of the small low-level modules
  ;; necessary for layering into submodules of higher-level modules. That trades
  ;; multiple small zos for a few larger ones. With `include`, we also get the
  ;; benefits of developing with smaller, topical files.

  ;; Of course, some higher-level libraries require some of those small
  ;; low-level modules, so they need to still exist (if only for backwards
  ;; compatibility). But, those need to refer to the same module as the now-
  ;; submodules, otherwise bad things could happen (e.g., different versions of
  ;; structs). To do that, the actual implementation of these modules is moved
  ;; to .rktl files (that nonetheless contain modules) and the original .rkt
  ;; files just re-export from the submodules.

  (module proto-include '#%kernel

    (#%require (for-syntax '#%kernel '#%paramz))

    (#%provide proto-include)

    (begin-for-syntax
     (define-values (resolve-path-spec)
       (lambda (fn stx)
         (let-values ([(file) (string->path (syntax->datum fn))])
           (if (complete-path? file)
               file
               (path->complete-path
                file
                (if
                 ;; Src of include expression is a path?
                 (if (path? (syntax-source stx))
                     (complete-path? (syntax-source stx))
                     #f)
                 (let-values ([(base name dir?)
                               (split-path (syntax-source stx))])
                   (if dir?
                       (syntax-source stx)
                       base))
                 (let-values ([(cldr) (current-load-relative-directory)])
                   (if cldr
                       cldr
                       (let-values ([(cd) (current-directory)])
                         (if cd cd (void))))))))))))

    (define-syntaxes (proto-include)
      (lambda (stx) ; (_ fn)
        ;; Parse the file name
        ;; assumption: the file exists
        (let-values ([(c-file) (resolve-path-spec (cadr (syntax->list stx)) stx)])
          ;; (register-external-file c-file) ; eh, probably not necessary in this case

          (let-values ([(read-syntax)
                        (lambda (src in)
                          (with-continuation-mark
                           parameterization-key
                           (extend-parameterization
                            (continuation-mark-set-first #f parameterization-key)
                            read-accept-reader #t)
                           (read-syntax src in)))])

            ;; Open the included file
            (let-values ([(p) (open-input-file c-file)]) ; no error handling!
              (port-count-lines! p)
              ;; Read expressions from file
              (let-values
                  ([(content)
                    (letrec-values
                     ([(loop)
                       (lambda ()
                         (let-values ([(r) (read-syntax c-file p)]) ; no error handling!
                           (if (eof-object? r)
                               null
                               (cons r (loop)))))])
                     (loop))])
                (close-input-port p)
                ;; Preserve src info for content, but set its
                ;; lexical context to be that of the include expression
                (let-values
                    ([(lexed-content)
                      (letrec-values
                       ([(loop)
                         (lambda (content)
                           (if (pair? content)
                               (cons (loop (car content))
                                     (loop (cdr content)))
                               (if (null? content)
                                   null
                                   (let-values ([(v) (syntax-e content)])
                                     (datum->syntax
                                      stx
                                      (if (pair? v)
                                          (loop v)
                                          (if (vector? v)
                                              (list->vector (loop (vector->list v)))
                                              (if (box? v)
                                                  (box (loop (unbox v)))
                                                  v)))
                                      content
                                      content)))))])
                       (loop content))])
                  (datum->syntax
                   (quote-syntax here)
                   (cons 'begin lexed-content)
                   stx)))))))))

  (#%require (submod "." proto-include))

  ;; all the modules that live below us, in topological order
  (proto-include "stx.rktl")
  (proto-include "qq-and-or.rktl")
  (proto-include "cond.rktl")
  (proto-include "member.rktl")
  (proto-include "define-et-al.rktl")

  (#%require (submod "." qq-and-or)
             (submod "." cond)
             (submod "." define-et-al))

  (#%provide (all-from (submod "." qq-and-or))
             (all-from (submod "." cond))
             (all-from (submod "." define-et-al))))
