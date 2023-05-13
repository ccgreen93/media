all:
	docker compose \
		-f docker-compose.yml \
		-f docker-compose.dns.yml \
		-f docker-compose.o11y.yml \
		-f docker-compose.plex.yml \
		-f docker-compose.proxy.yml \
		up -d

core:
	docker compose up -d

dns:
	docker compose -f docker-compose.dns.yml up -d

o11y:
	docker compose -f docker-compose.o11y.yml up -d

plex:
	docker compose -f docker-compose.plex.yml up -d

proxy:
	docker compose -f docker-compose.proxy.yml up -d

jellyfin:
	docker compose -f docker-compose.jellyfin.yml up -d

restart:
	docker compose restart

setup:
	./scripts/setup.sh

gitpull:
	git pull

gitpush:
	./scripts/gitpush.sh

install_docker:
	./scripts/install_docker_deb
