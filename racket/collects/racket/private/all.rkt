(module all '#%kernel

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

  ;; include all other racket files in racket/private, in topological order
  ;; of dependency
  (proto-include "stx.rktl")
  (proto-include "qq-and-or.rktl")
  (proto-include "cond.rktl")
  (proto-include "member.rktl")
  (proto-include "define-et-al.rktl")
  (proto-include "small-scheme.rktl")

  (proto-include "ellipses.rktl")
  (proto-include "sc.rktl")
  (proto-include "stxcase.rktl")
  (proto-include "stxloc.rktl")
  (proto-include "with-stx.rktl")
  (proto-include "stxcase-scheme.rktl")

  (proto-include "qqstx.rktl")
  (proto-include "letstx-scheme.rktl")
  (proto-include "norm-define.rktl")
  (proto-include "define.rktl")

  (proto-include "sort.rktl")
  (proto-include "case.rktl")
  (proto-include "logger.rktl")
  (proto-include "more-scheme.rktl")

  (proto-include "stxparamkey.rktl")
  (proto-include "stxparam.rktl")
  (proto-include "generic-methods.rktl")

  (proto-include "kw-prop-key.rktl")
  (proto-include "name.rktl")
  (proto-include "procedure-alias.rktl")
  (proto-include "struct-info.rktl")
  (proto-include "define-struct.rktl")

  (proto-include "require-transform.rktl")
  (proto-include "provide-transform.rktl")
  (proto-include "misc.rktl")
  (proto-include "reverse.rktl")
  (proto-include "performance-hint.rktl")

  (proto-include "kw.rktl")
  (proto-include "reqprov.rktl")
  (proto-include "modbeg.rktl")
  (proto-include "for.rktl")
  (proto-include "map.rktl")
  (proto-include "kernstruct.rktl")
  (proto-include "norm-arity.rktl")
  (proto-include "top-int.rktl")
  (proto-include "pre-base.rktl")

  (proto-include "generic-interfaces.rktl")
  (proto-include "submodule.rktl")
  (proto-include "cert.rktl")
  (proto-include "struct.rktl")
  (proto-include "namespace.rktl")
  (proto-include "kw-file.rktl")
  (proto-include "string.rktl")
  (proto-include "list.rktl")
  (proto-include "hash.rktl")
  (proto-include "base.rktl")

  ;; rest doesn't live below racket/base, so can go in whatever order
  ;; TODO for now, try not bringing those in
  ;; TODO ugh, will probably need to, otherwise those that don't use `base`, but require something further down will have to load the one big zo instead of a small one
  ;;   -> er, that shouldn't affect the loading timr for `base`, though...

  ;; TODO time to profile at the C level, to see what it's doing there
  
  ;; (proto-include "arity.rktl")
  ;; (proto-include "class-c-new.rktl") ;; TODO class stuff requires racket/stxparam (outside private)
  ;; (proto-include "class-c-old.rktl")
  ;; (proto-include "class-internal.rktl")
  ;; (proto-include "class-undef.rktl")
  ;; (proto-include "class-wrapped.rktl")
  ;; (proto-include "classidmap.rktl")
  ;; (proto-include "custom-hash.rktl")
  ;; (proto-include "custom-write.rktl")
  ;; (proto-include "dict.rktl")
  ;; (proto-include "generic.rktl")
  ;; (proto-include "increader.rktl")
  ;; (proto-include "local.rktl")
  ;; (proto-include "port.rktl")
  ;; (proto-include "portlines.rktl")
  ;;(proto-include "promise.rktl")
  ;; (proto-include "runtime-path-table.rktl")
  ;; (proto-include "sequence.rktl")
  ;; (proto-include "serialize-structs.rktl")
  ;; (proto-include "serialize.rktl")
  ;; (proto-include "set-types.rktl")
  ;; (proto-include "set.rktl")
  ;; (proto-include "shared-body.rktl")
  ;; (proto-include "so-search.rktl")
  ;; (proto-include "stream-cons.rktl")
  ;; (proto-include "streams.rktl")
  ;; (proto-include "this-expression-source-directory.rktl")
  ;; (proto-include "unit-compiletime.rktl")
  ;; (proto-include "unit-contract-syntax.rktl")
  ;; (proto-include "unit-contract.rktl")
  ;; (proto-include "unit-keywords.rktl")
  ;; (proto-include "unit-runtime.rktl")
  ;; (proto-include "unit-syntax.rktl")
  ;; (proto-include "unit-utils.rktl")
  ;; (proto-include "unix-rand.rktl")
  ;; (proto-include "vector-wraps.rktl")
  ;; (proto-include "windows-rand.rktl")
  )
