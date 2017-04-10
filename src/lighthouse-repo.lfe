#|
@doc
  lighthouse repository API
@end
|#

(defmodule lighthouse-repo

  ;; API
  (export (init 0)
          (insert 1)))

(include-lib "include/location.lfe")

;;; API

(defun init []
  (let* [(nodes `(,(node)))
         (attrs `,(fields-location))]
    (mnesia:stop)
    (mnesia:change_config 'extra_db_nodes nodes)
    (mnesia:create_schema nodes)
    (mnesia:start)
    (mnesia:create_table 'location `[#(attributes ,attrs)
                                     #(ram_copies ,nodes)])))

(defun insert [location]
  (mnesia:dirty_write location))