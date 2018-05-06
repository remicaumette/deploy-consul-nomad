defaultEntryPoints = ["http", "https"]

[entryPoints]
	[entryPoints.http]
	    address = ":80"
        [entryPoints.http.redirect]
            entryPoint = "https"
    [entryPoints.https]
        address = ":443"
        [entryPoints.https.tls]

[acme]
    email = "contact@${domain}"
    storage = "traefik/acme/account"
    entryPoint = "https"
    onHostRule = true

[api]
    dashboard = false

[consul]
    endpoint = "127.0.0.1:8500"
    watch = true
    prefix = "traefik"

[consulCatalog]
	endpoint = "127.0.0.1:8500"
	watch = true
	domain = "${domain}"
	prefix = "traefik"
	exposedByDefault = false
