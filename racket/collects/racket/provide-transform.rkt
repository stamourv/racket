(module require-transform '#%kernel
  (#%require "private/provide-transform.rkt")
  (#%provide (all-from "private/provide-transform.rkt")))
