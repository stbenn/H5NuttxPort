R := $(CURDIR)
NUTTXDIR := $(R)/nuttx
LOGDIR := $(R)/ci_logs
PYEXE := $(R)/.venv/bin/python

.PHONY: pyenv

pyenv:
	$(PYEXE) -m pip install -r py_requirements.txt

sim: 
	@echo "Making sim target"
#	$(MAKE) -C nuttx distclean -j
	./nuttx/tools/configure.sh sim:citest
	$(MAKE) -C nuttx -j

ci: sim
	@echo "Running CI tests."
	cd ./nuttx/tools/ci/testrun/script

	@echo $(PYEXE) -m pytest -m 'common or sim' ./ -B sim -P $(NUTTXDIR) -L $(LOGDIR) -R sim -C --json=$(LOGDIR)/pytest.json
	python -m pytest -m 'common or sim' ./ -B sim -P $(NUTTXDIR) \
	-L $(LOGDIR) -R sim -C --json=$(LOGDIR)/pytest.json

	cd $(R)

	@echo "Finished make ci tests."

