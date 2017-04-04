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
  (make-location latitude lat
                 longitude lon
                 geohash geohash))

(defun decode [location]
  (lighthouse-location-pb:decode_msg location 'location))

(defun encode [location]
  (lighthouse-location-pb:encode_msg location))