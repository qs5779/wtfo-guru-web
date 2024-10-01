<!-- markdownlint-configure-file { "MD024": false } -->
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.3-dev2] - 2024-08-01

### Changed

- Updated uvicorn (0.30.1 -> 0.30.4)
- Updated fastapi (0.111.0 -> 0.111.1)

## [1.0.3-dev1] - 2024-07-04

### Changed

- Updated aiofiles (23.2.1 -> 24.1.0)
- Updated typing-extensions (4.12.1 -> 4.12.2)
- Updated certifi (2024.6.2 -> 2024.7.4)
- Updated pydantic-core (2.18.4 -> 2.20.1)
- Updated email-validator (2.1.1 -> 2.2.0)
- Updated orjson (3.10.3 -> 3.10.6)
- Updated pydantic (2.7.3 -> 2.9.2)
- Updated urllib3 (2.2.1 -> 2.2.2)
- Updating fastapi (0.112.4 -> 0.115.0)
- Updating python-multipart (0.0.9 -> 0.0.12)
- Updating uvicorn (0.30.6 -> 0.31.0)

### Fixed

- starlette TemplateResponse => DeprecationWarning: The `name` is not the first parameter anymore.

## [1.0.3-dev0] - 2024-06-24

### Changed

- Only compare archive when not testing in gitlab pipeline.
- Remove publish targets from Makefile

### Fixed

- Corrected build project name

## [1.0.2] - 2024-04-26

- _First release._
