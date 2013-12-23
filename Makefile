###
# Customization options
###

# host and port to bind with for 'make develop' local server
RA_DEVELOP_HOST  = localhost
RA_DEVELOP_PORT  = 3001
# You can add --render to $(RA_EXTRA_FLAGS) to turn on server side UI pre-rendering
RA_EXTRA_FLAGS   = --debug --render
RA_FLAGS         =  $(RA_EXTRA_FLAGS) --host $(RA_DEVELOP_HOST) --port $(RA_DEVELOP_PORT)
RA_ENTRY         = ./ui/index.jsx
RA_STYLES        = ./ui/index.css
RA_ASSETS        = ./ui/assets
RA_TRANSFORM     = reactify
RA_CSS_TRANSFORM =

###
# DO NOT EDIT
###

.DELETE_ON_ERROR:
.DEFAULT_GOAL = help
.SHELL = /bin/sh
.SHELLFLAGS = -c -e -o pipefail
BIN = ./node_modules/.bin
RA_BUNDLE = $(RA_ASSETS)/bundle.js
RA_CSS_BUNDLE = $(RA_ASSETS)/bundle.css
RA_ENTRY_DIR = $(shell dirname $(RA_ENTRY))
RA_OPTS = \
	$(RA_FLAGS) \
	$(RA_TRANSFORM:%=--transform %) \
	$(RA_CSS_TRANSFORM:%=--css-transform %) \
	$(RA_STYLES:%=--styles %) \
	$(RA_ASSETS:%=--assets %)

define REPORT_SIZE
	@echo Size for $(1):
	@echo "  "raw:     `cat $(1) | wc -c` bytes
	@echo "  "gzipped: `cat $(1) | gzip | wc -c` bytes
endef

###
# Targets
###

install link:
	@npm $@

develop:
	@$(BIN)/react-app $(RA_OPTS) $(RA_ENTRY)

test:
	@$(BIN)/mocha specs/*.js

lint:
	@$(BIN)/jsxhint `find $(RA_ENTRY_DIR) -name '*.js' -or -name '*.jsx' -type f`

build:: $(RA_BUNDLE) $(RA_CSS_BUNDLE)

build-report: build
	$(call REPORT_SIZE,$(RA_BUNDLE))
	$(call REPORT_SIZE,$(RA_CSS_BUNDLE))

clean:
	@rm -f $(RA_BUNDLE) $(RA_CSS_BUNDLE)

help:
	@echo 'Usage: make <action name>'
	@echo ''
	@echo 'Available actions:'
	@echo '  install     	install all dependencies'
	@echo '  develop     	start development server'
	@echo '  lint        	lint front-end code'
	@echo '  test        	run test suite'
	@echo '  build       	build all js and css bundles'
	@echo '  build-report	report build artifacts size'
	@echo '  clean       	remove build artifacts'
	@echo '  help        	show help'
	@echo ''

###
# Assets building
###

$(RA_BUNDLE)::
	@echo building $@
	@mkdir -p $(@D)
	@NODE_ENV=production \
		$(BIN)/browserify $(RA_TRANSFORM:%=-t %) -r $(RA_ENTRY):./app \
		| $(BIN)/uglifyjs -c -m 2>/dev/null > $@

$(RA_CSS_BUNDLE)::
	@echo building $@
	@mkdir -p $(@D)
	@$(BIN)/xcss --compress $(RA_CSS_TRANSFORM:%=-t %) $(RA_STYLES) > $@

