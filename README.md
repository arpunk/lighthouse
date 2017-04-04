lighthouse
==========

An LFE application

## Build
```
$ rebar3 lfe release
```

## Requests
```
curl --http2-prior-knowledge --data-binary @/tmp/loc_encoded.bin http://localhost:8080/api -vvv -H "Content-Type: application/x-protobuf"
```

## Generating payload
```lisp
(application:ensure_all_started 'lighthouse) 
(include-lib "include/location.lfe")
(set loc (make-location latitude 1.0 longitude 2.0 geohash #"abc"))
(set encoded (lighthouse-location-pb:encode_msg loc))
(file:write_file "/tmp/loc_encoded.bin" encoded `(binary))
```

## Test
```
$ rebar3 lfe test
```
