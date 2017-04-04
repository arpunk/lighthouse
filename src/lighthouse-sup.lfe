#|
@doc
  lighthouse top level supervisor
@end
|#

(defmodule lighthouse-sup
  (behaviour supervisor)

  ;; API
  (export (start_link 0))

  ;; Supervisor callbacks
  (export (init 1)))

;;; API functions

(defun server-name ()
  'lighthouse-sup)

(defun start_link ()
  (supervisor:start_link
    `#(local ,(server-name)) (MODULE) '()))

;;; Supervisor callbacks

(defun init (_args)
  (let* [(httpd (httpd-spec))]
    (lighthouse-repo:init)
    `#(ok #(#(one_for_one 0 1) (,httpd)))))

;;; Internal functions

(defun httpd-spec ()
  `#(lighthouse-http #(lighthouse-http start ())
                     permanent
                     5000
                     supervisor
                     (lighthouse-http)))