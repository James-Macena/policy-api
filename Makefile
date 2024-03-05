# runs app on an interactive mode
bash:
	docker compose run -it --rm --service-ports app bash

# runs tests
test:
	docker compose run -it --rm --service-ports app bash -c "bundle exec rspec"

# runs rubocop(ex: make rubocop path=my/path)
rubocop:
	docker compose run -it --rm --service-ports app bash -c "bundle exec rubocop --format=simple ${path}"
