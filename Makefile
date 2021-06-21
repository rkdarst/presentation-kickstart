# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line, and also
# from the environment for the first two.
SPHINXOPTS    ?=
SPHINXBUILD   ?= sphinx-build
SOURCEDIR     = .
BUILDDIR      = _build

_default: html
	true

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

auto:
	sphinx-autobuild . _build/html/

gh-pages-push:
	git fetch
	git checkout gh-pages
	git commit --allow-empty -m 'empty commit'
	git push origin gh-pages

gh-pages: clean dirhtml
	git worktree add _build/gh-pages/ -b gh-pages-new
	rsync -ai _build/dirhtml/ _build/gh-pages/
	git -C _build/gh-pages/ commit -a -m "autocommit of gh-pages"
	git -C _build/gh-pages/ push origin HEAD:origin/gh-pages
