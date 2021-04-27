```
ngx_http_upstream_fair_module - sends an incoming request to the least-busy backend server, rather than distributing requests round-robin.

Example:

upstream backend {
  server server1;
  server server2;
  fair;
}
Note
This module is not distributed with the NGINX source. See the installation instructions.

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
