.EXPORT_ALL_VARIABLES:

APP_ENV:=testing

.PHONY: it
it: refactoring coding-standards security-analysis static-code-analysis tests ## Runs the refactoring, coding-standards, security-analysis, static-code-analysis, and tests targets

.PHONY: code-coverage
code-coverage: vendor ## Collects code coverage from running unit tests with phpunit/phpunit
	vendor/bin/phpunit --configuration=phpunit.xml --coverage-text --testsuite=Unit

.PHONY: coding-standards
coding-standards: vendor ## Lints YAML files with yamllint, normalizes composer.json with ergebnis/composer-normalize, and fixes code style issues with friendsofphp/php-cs-fixer
	yamllint -c .yamllint.yaml --strict .
	composer normalize
	vendor/bin/pint --config=pint.json -v

.PHONY: database
database: vendor laravel ## Runs database migrations
	./artisan migrate:fresh --env=${APP_ENV}

.PHONY: dependency-analysis
dependency-analysis: phive vendor ## Runs a dependency analysis with maglnet/composer-require-checker
	.phive/composer-require-checker check --config-file=$(shell pwd)/composer-require-checker.json --verbose

.PHONY: help
help: ## Displays this list of targets with descriptions
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: laravel
laravel: vendor ## Copies the distributable environment variable configuration file and shows application information
	cp -n .env.example .env || true
	./artisan about --env=${APP_ENV}

.PHONY: mutation-tests
mutation-tests: database laravel vendor ## Runs mutation tests with infection/infection
	vendor/bin/infection --configuration=infection.json

.PHONY: phive
phive: .phive ## Installs dependencies with phive
	PHIVE_HOME=.build/phive phive install --trust-gpg-keys 0x033E5F8D801A2F8D

.PHONY: refactoring
refactoring: vendor ## Runs automated refactoring with rector/rector
	vendor/bin/rector process --config=rector.php

.PHONY: security-analysis
security-analysis: vendor ## Runs a security analysis with composer
	composer audit

.PHONY: static-code-analysis
static-code-analysis: laravel vendor ## Runs a static code analysis with vimeo/psalm
	vendor/bin/psalm --config=psalm.xml --clear-cache
	vendor/bin/psalm --config=psalm.xml --show-info=false --stats --threads=4

.PHONY: static-code-analysis-baseline
static-code-analysis-baseline: laravel vendor ## Generates a baseline for static code analysis with vimeo/psalm
	vendor/bin/psalm --config=psalm.xml --clear-cache
	vendor/bin/psalm --config=psalm.xml --set-baseline=psalm-baseline.xml

.PHONY: tests
tests: database laravel vendor ## Runs unit and feature tests with phpunit/phpunit
	vendor/bin/phpunit --configuration=phpunit.xml --testsuite=Unit
	vendor/bin/phpunit --configuration=phpunit.xml --testsuite=Feature

vendor: composer.json composer.lock
	composer validate --strict
	composer install --no-interaction --no-progress
