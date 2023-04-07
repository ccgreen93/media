all:
	docker compose up -d

plex:
	docker compose -f docker-compose.plex.yml up -docker

