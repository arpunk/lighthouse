#|
@doc
  lighthouse public API
@end
|#

(defmodule lighthouse-app
  (behaviour application)

  ;; Application callbacks
  (export (start 2)
          (stop 1)))

;;; API

(defun start (_type _args)
  (lighthouse-sup:start_link))

(defun stop (_state)
  'ok)

;;; Internal functions
