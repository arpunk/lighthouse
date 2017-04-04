#|
@doc
  lighthouse HTTP worker
@end
|#

(defmodule lighthouse-http
  ;; API
  (export (start 0)))

;;; API

(defun start ()
  (let [(dispatch (cowboy_router:compile (routes)))]
    (cowboy:start_clear 'http_listener 100
                        '(#(port 8080))
                        `#M(env
                            #M(dispatch ,dispatch
                               request_timeout 60000)))))

;;; Internal functions

(defun routes ()
  '[#(_ [#("/api" lighthouse-http-api [])])])