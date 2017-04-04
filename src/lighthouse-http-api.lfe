#|
@doc
  lighthouse HTTP API handler
@end
|#

(defmodule lighthouse-http-api
  (export (init 2)))

;;; Request callbacks

(defun init [req opts]
  (let* [(method    (cowboy_req:method req))
         (has-body? (cowboy_req:has_body req))
         (reply     (maybe-report method has-body? req))]
    `#(ok ,reply ,opts)))

;;; Internal functions

(defun maybe-report
  ([#"POST" 'true req]
   (let [(`#(ok ,payload ,req*) (cowboy_req:read_body req))]
     (process-location payload req*)))
  ([#"POST" 'false req]
   (cowboy_req:reply 400 (resp-opts) #"Missing payload." req))
  ([_method _body? req]
   (cowboy_req:reply 405 req)))

(defun process-location [payload req]
  (try
      (let* [(location (decode-location payload))]
        (insert-location location)
        (cowboy_req:reply 200 req))
    (catch
      (`#(,_type ,_val ,_)
       (cowboy_req:reply 406 req)))))

(defun insert-location [loc]
  (lighthouse-repo:insert loc))

(defun decode-location [loc]
  (lighthouse-location:decode loc))

(defun resp-opts []
  #M(#"content-type" #"text/plain; charset=utf-8"))