[ngx_http_upstream_check_module](https://github.com/yaoweibin/nginx_upstream_check_module)
Add proactive health check for the upstream servers.
it should be enabled with the --with-http_upstream_check_module configuration parameter.
## Examples
```
http {
    upstream cluster1 {
        # simple round-robin
        server 192.168.0.1:80;
        server 192.168.0.2:80;

        check interval=3000 rise=2 fall=5 timeout=1000 type=http;
        check_http_send "HEAD / HTTP/1.0\r\n\r\n";
        check_http_expect_alive http_2xx http_3xx;
    }

    upstream cluster2 {
        # simple round-robin
        server 192.168.0.3:80;
        server 192.168.0.4:80;

        check interval=3000 rise=2 fall=5 timeout=1000 type=http;
        check_keepalive_requests 100;
        check_http_send "HEAD / HTTP/1.1\r\nConnection: keep-alive\r\n\r\n";
        check_http_expect_alive http_2xx http_3xx;
    }

    server {
        listen 80;

        location /1 {
            proxy_pass http://cluster1;
        }

        location /2 {
            proxy_pass http://cluster2;
        }

        location /status {
            check_status;

            access_log   off;
            allow SOME.IP.ADD.RESS;
            deny all;
        }
    }
}
```
```
Add health check for the upstream servers.

The parameters' meanings are:

interval: the check request's interval time.
fall(fall_count): After fall_count failure checks, the server is marked down.
rise(rise_count): After rise_count successful checks, the server is marked up.
timeout: the check request's timeout.
default_down: specify initial state of backend server, default is down.
type: the check protocol type:

tcp: a simple TCP socket connect and peek one byte.

ssl_hello: send a client SSL hello packet and receive the server SSL hello packet.
http: send a http request packet, receive and parse the http response to diagnose if the upstream server is alive.
mysql: connect to the mysql server, receive the greeting response to diagnose if the upstream server is alive.
ajp: send an AJP Cping packet, receive and parse the AJP Cpong response to diagnose if the upstream server is alive.
port: specify the check port in the backend servers. It can be different with the original servers port. Default the port is 0 and it means the same as the original backend server. 
```

# [ngx_http_upstream_fair_module](https://www.nginx.com/resources/wiki/modules/fair_balancer/)
```
Description
ngx_http_upstream_fair_module - sends an incoming request to the least-busy backend server, rather than distributing requests round-robin.

Example:

upstream backend {
  server server1;
  server server2;
  fair;
}

Directives
fair
Syntax:	fair
Default:	none
Context:	upstream
Enables fairness.

upstream_fair_shm_size
Syntax:	upstream_fair_shm_size size
Default:	32k
Context:	main
Size of the shared memory for storing information about the busy-ness of backends. Defaults to 8 pages (so 32k on most systems).

Installation
This module is not distributed with the NGINX source. You can browse its git repository or download the tar ball

After extracting, add the following option to your NGINX ./configure command:

--add-module=path/to/upstream_fair/directory
Then make and make install as usual.
```
