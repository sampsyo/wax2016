STYLE_SCSS := src/style.scss


# Main site.

.PHONY: site
site:
	make static/style.css
	hugo

.PHONY: clean
clean:
	rm -rf public static/style.css bower_components


# CSS.

TYPOGRAPHIC := bower_components/typographic/scss/typographic.scss

static/style.css: $(STYLE_SCSS) $(TYPOGRAPHIC)
	@mkdir -p static
	sassc $(STYLE_SCSS) > $@

$(TYPOGRAPHIC):
	bower install typographic
	@touch $@


# Deployment.

DEST := dh:domains/approximate.computer/wax2016
RSYNCARGS := --compress --recursive --checksum --itemize-changes \
	--delete -e ssh

.PHONY: deploy
deploy: site
	rsync $(RSYNCARGS) public/ $(DEST)
