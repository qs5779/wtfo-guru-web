SHELL:=/usr/bin/env bash

PROJECT_NAME ?= $(shell basename $$(git rev-parse --show-toplevel) | sed -e "s/^python-//")
PACKAGE_DIR = app
PROJECT_VERSION ?= $(shell grep ^current_version .bumpversion.cfg | awk '{print $$NF'} | tr '-' '.')
TEST_DIR = tests
TEST_MASK = $(TEST_DIR)/*.py

.PHONY: vars
vars:
	@echo "PROJECT_NAME: $(PROJECT_NAME)"
	@echo "PACKAGE_DIR: $(PACKAGE_DIR)"
	@echo "PROJECT_VERSION: $(PROJECT_VERSION)"

.PHONY: update
update:
	poetry update --with test --with docs
#	poetry export -f requirements.txt --without=test --without=docs -o requirements.txt --without-hashes
#	poetry export -f requirements.txt --only=test --only=docs -o requirements_dev.txt --without-hashes
	pre-commit-update-repo.sh
#	pre-commit run --files requirements.txt requirements_dev.txt


.PHONY: black
black:
	poetry run isort main.py $(PACKAGE_DIR) $(TEST_MASK)
	poetry run black main.py $(PACKAGE_DIR) $(TEST_MASK)

.PHONY: mypy
mypy: black
	poetry run mypy main.py $(PACKAGE_DIR) $(TEST_MASK)

.PHONY: lint
lint: mypy
	poetry run flake8 main.py $(PACKAGE_DIR) $(TEST_MASK)
	# poetry run doc8 -q docs

.PHONY: package
package:
	poetry check
	poetry run pip check

.PHONY: safety
safety:
	poetry run safety scan --full-report

.PHONY: sunit
sunit:
	poetry run pytest -s $(TEST_DIR)

.PHONY: unit
unit:
	poetry run pytest $(TEST_DIR)

.PHONY: test
test: lint package unit

.PHONY: ghtest
ghtest: lint package unit

.PHONY: deploy-cloud
deploy-cloud:
	git push cloud main:main

.PHONY: deploy
deploy:
	manage-tag.sh -u v$(PROJECT_VERSION)
	git push dokku main:main

.PHONY: clean clean-build clean-pyc clean-test
clean: clean-build clean-pyc clean-test ## remove all build, test, coverage and Python artifacts

clean-build: ## remove build artifacts
	rm -fr build/
	rm -fr docs/_build
	rm -fr dist/
	rm -fr .eggs/
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '*.egg' -exec rm -f {} +

clean-pyc: ## remove Python file artifacts
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

clean-test: ## remove test and coverage artifacts
	rm -fr .tox/
	rm -f .coverage
	rm -fr htmlcov/
	rm -fr .pytest_cache
	rm -fr .mypy_cache

.DEFAULT:
	@cd docs && $(MAKE) $@

# vim: ft=Makefile
