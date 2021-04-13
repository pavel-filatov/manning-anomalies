.PHONY: help
help:
	@echo ======================
	@echo 'Project Anomalies'
	@echo ======================
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'
	@echo ======================


##>>> JUPYTER <<<

.PHONY: run-jupyter
run-jupyter: ## Run Jupyter in Docker
	docker run -it \
		-v $(PWD)/jupyter/notebooks:/src/notebooks \
		-v $(PWD)/jupyter/data:/src/data \
		-v $(PWD)/service/model:/src/model \
		-p 9999:9999 filatov_py/jupyter

.PHONY: train
train: ## Train the model
	docker run \
		-v $(PWD)/jupyter:/src \
		-v $(PWD)/service/model:/model \
		filatov_py/jupyter python /src/train.py

.PHONY: build-jupyter
build-jupyter: ## Build Docker image containing jupyter
	docker build -t filatov_py/jupyter jupyter


##>>> WEB-SERVICE <<<

.PHONY: run-webapp
run-webapp:  ## Run web service to detect anomalies
	docker run --name lp-service -t -v $(PWD)/service:/app -p 8000:8000 filatov_py/lp-service

.PHONY: build-webapp
build-webapp:  ## Build Docker image containing web application
	docker build -t filatov_py/lp-service service
