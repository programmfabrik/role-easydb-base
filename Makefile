SHELL=/bin/bash

.PHONY: help install test molecule all clean

help:
	@echo "Available targets are:"
	@echo "- install  - install all dependencies"
	@echo "- molecule - run molecule tests"
	@echo "- test     - run all tests"
	@echo "- clean    - clean up the workspace"
	@echo "- update   - update all deps to latest stable"
	@echo "- gi       - update .gitignore file"

install:
	pip install -r requirements.txt

molecule:
	molecule test --all

test: molecule

all: install test

clean:
	molecule destroy --all
	rm -rf molecule/*/.molecule
	rm -rf molecule/*/tests/__pycache__
	find . -name \*.pyc -delete

update:
	pip install -U pip
	pur -r requirements.txt
	$(MAKE) install

gi:
	curl -L -s https://www.gitignore.io/api/linux,ansible,vim,intellij,visualstudio > .gitignore
