#|
@doc
  lighthouse location API
@end
|#

(defmodule lighthouse-location
  (export all))

(include-lib "include/location.lfe")

;;; API

(defun new [lat lon geohash]
  (make-location id (new-nounce)
                 latitude lat
                 longitude lon
                 geohash geohash
                 timestamp (erlang:system_time)))

(defun decode [location]
  (lighthouse-location-pb:decode_msg location 'location))

(defun encode [location]
  (lighthouse-location-pb:encode_msg location))

;;; Internal functions

(defun new-nounce []
  (let [((binary (n (size 64))) (crypto:strong_rand_bytes 8))]
    n))
