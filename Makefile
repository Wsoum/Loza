SHELL = bash
PYTHON = python3
SCRIPTS = $(PYTHON) ./src/loza.py scripts/
INSTALLATION_PATH = /usr/bin/loza

.DEFAULT_GOAL := main
.PHONY := main compile clean update-headers test module all install uninstall pylint speed-test

GIT_IS_INSTALLED = 0
ifneq (,$(shell command -v git))
GIT_IS_INSTALLED = 1
endif

main: compile

compile:
	@$(PYTHON) -m PyInstaller ./src/loza.py --onefile

clean:
	@rm build/ dist/ loza.spec pylint.out -rf
	@echo -e "\033[32mall of build files cleaned successfuly\033[0m"

update-headers:
	@$(SCRIPTS)update-headers.loza

test:
	@$(PYTHON) ./tests/run.py

module:
	@$(SCRIPTS)module-build.loza

all: module update-headers test speed-test
ifeq ($(GIT_IS_INSTALLED),1)
	-@git status
endif

install: ./dist/loza
	@cp ./dist/loza $(INSTALLATION_PATH)
	@echo -e "\033[32mLoza installed successfuly in '$(INSTALLATION_PATH)'. now you can run it in terminal: loza\033[0m"

uninstall: $(INSTALLATION_PATH)
	@rm $(INSTALLATION_PATH)
	@echo -e "\033[32mloza has been removed from your system successfuly\033[0m"

speed-test:
	@$(PYTHON) ./src/loza.py ./scripts/speed-test.loza
	@echo

pylint:
	@$(PYTHON) -m pylint $(shell find src -type f -name '*.py') \
	| grep -v '(no-member)' \
	| grep -v '(relative-beyond-top-level)' \
	| grep -v '(no-name-in-module)' > pylint.out
	@echo -e "\033[32mpylint output was saved in pylint.out\033[0m"
