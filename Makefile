EMACS ?= emacs
LISPM_KIT ?= ../lispm-kit
LISPM_UI ?= ../lispm-ui

LOAD_PATH = -L $(LISPM_KIT) -L $(LISPM_UI) -L . -L test

EL_FILES = lispm-finder-i18n.el lispm-finder.el

.PHONY: test compile i18n clean

test:
	$(EMACS) -Q --batch $(LOAD_PATH) \
		-l lispm-finder \
		-l lispm-finder-test \
		-f ert-run-tests-batch-and-exit

compile:
	$(EMACS) -Q --batch $(LOAD_PATH) \
		--eval "(setq byte-compile-error-on-warn t)" \
		-f batch-byte-compile $(EL_FILES) test/lispm-finder-test.el
	rm -f *.elc test/*.elc

i18n:
	$(EMACS) -Q --batch $(LOAD_PATH) \
		-l lispm-finder \
		-l lispm-finder-test \
		--eval "(ert-run-tests-batch-and-exit \"^lispm-finder-test-i18n\")"

clean:
	rm -f *.elc test/*.elc
