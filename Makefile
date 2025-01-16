DOCKER_COMPOSE := docker compose

MAKE := make --no-print-directory

deps:
	mix deps.get

dev_up: deps
	$(DOCKER_COMPOSE) -f docker-compose.dev.yml up -d

dev_down:
	$(DOCKER_COMPOSE) -f docker-compose.dev.yml down

test_up: deps
	$(DOCKER_COMPOSE) -f docker-compose.test.yml up -d

test_down:
	$(DOCKER_COMPOSE) -f docker-compose.test.yml down

run:
	iex -S mix phx.server

run_fc:
	mix compile --force && \
	iex -S mix phx.server

run_test:
	mix test