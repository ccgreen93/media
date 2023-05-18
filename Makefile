allup:
	docker compose \
		-f docker-compose.yml \
		-f docker-compose.dns.yml \
		-f docker-compose.o11y.yml \
		-f docker-compose.plex.yml \
		-f docker-compose.proxy.yml \
		up -d --remove-orphans

alluprecreate:
	docker compose \
		-f docker-compose.yml \
		-f docker-compose.dns.yml \
		-f docker-compose.o11y.yml \
		-f docker-compose.plex.yml \
		-f docker-compose.proxy.yml \
		up -d --remove-orphans --force-recreate

allrestart:
	docker compose \
		-f docker-compose.yml \
		-f docker-compose.dns.yml \
		-f docker-compose.o11y.yml \
		-f docker-compose.plex.yml \
		-f docker-compose.proxy.yml \
		restart

alldown:
	docker compose \
		-f docker-compose.yml \
		-f docker-compose.dns.yml \
		-f docker-compose.o11y.yml \
		-f docker-compose.plex.yml \
		-f docker-compose.proxy.yml \
		down

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

setup:
	./scripts/setup.sh

gitpull:
	git pull

gitpush:
	./scripts/gitpush.sh

install_docker:
	./scripts/install_docker_deb
