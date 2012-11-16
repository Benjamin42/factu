def self.options_and_defaults
  [
    # geocoding service timeout (secs)
    [:timeout, 10],

    # name of geocoding service (symbol)
    [:lookup, :google],

    # ISO-639 language code
    [:language, :en],

    # use HTTPS for lookup requests? (if supported)
    [:use_https, false],

    # HTTP proxy server (user:pass@host:port)
    [:http_proxy, "corbara:Nfvsnxdh2@10.198.237.3:8080"],

    # HTTPS proxy server (user:pass@host:port)
    [:https_proxy, "corbara:Nfvsnxdh2@10.198.237.3:8080"],

    # API key for geocoding service
    [:api_key, nil],

    # cache object (must respond to #[], #[]=, and #keys)
    [:cache, nil],

    # prefix (string) to use for all cache keys
    [:cache_prefix, "geocoder:"],

    # exceptions that should not be rescued by default
    # (if you want to implement custom error handling);
    # supports SocketError and TimeoutError
    [:always_raise, []]
  ]
end