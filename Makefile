bash_server:
		@docker-compose exec main bash -lc "bash"

start_server:
		@docker-compose exec main bash -lc "rake server"
