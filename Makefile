.PHONY: help
help:
	@echo ======================
	@echo 'Project Anomalies'
	@echo ======================
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'
	@echo ======================

.PHONY: run
run: ## Run Jupyter in Docker
	docker run -it -v $(PWD)/jupyter/notebooks:/src/notebooks -v $(PWD)/jupyter/data:/src/data -p 9999:9999 filatov_py/jupyter

.PHONY: build
build: ## Build Docker image
	docker build -t filatov_py/jupyter jupyter
