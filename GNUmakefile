SHELL := /usr/bin/env fish

all: fmt lint install test

fmt:
	@fish_indent --write **.fish

lint:
	@for file in **.fish; fish --no-execute $$file; end

install: fisher
	@fisher install . >/dev/null

littlecheck.py:
	@curl -sL https://raw.githubusercontent.com/ridiculousfish/littlecheck/HEAD/littlecheck/littlecheck.py \
		-o littlecheck.py

fisher:
	@type -q fisher || begin; curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher; end

clownfish:
	@type -q mock || fisher install IlanCosman/clownfish

fishtape:
	@type -q fishtape ||fisher install jorgebucaran/fishtape

test: install littlecheck.py
	@type -q mock || fisher install IlanCosman/clownfish
	@fish tests/test_setup.fish
	@_tide_remove_unusable_items
	@_tide_cache_variables; python3 littlecheck.py --progress tests/**.test.fish

.PHONY: \
	all \
	clownfish \
	fisher \
	fishtape \
	fmt \
	install \
	lint \
	test
