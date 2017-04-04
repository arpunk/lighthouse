#|
@doc
  lighthouse repository API
@end
|#

(defmodule lighthouse-repo
  (export all))

;;; API

(defun init []
  (let* [(nodes `(,(node)))
         (attrs '[latitude longitude geohash])]
    (mnesia:stop)
    (mnesia:change_config 'extra_db_nodes nodes)
    (mnesia:create_schema nodes)
    (mnesia:start)
    (mnesia:create_table 'location `[#(attributes ,attrs)
                                     #(ram_copies ,nodes)])))

(defun insert [location]
  (mnesia:dirty_write location))