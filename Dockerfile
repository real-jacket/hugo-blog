FROM caddy:2

COPY Caddyfile /etc/caddy/Caddyfile

COPY /public /srv