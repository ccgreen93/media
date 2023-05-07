up:
	docker compose up -d

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
