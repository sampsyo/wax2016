STYLE_SCSS := src/style.scss
TYPOGRAPHIC := bower_components/typographic/scss/typographic.scss

static/style.css: $(STYLE_SCSS) $(TYPOGRAPHIC)
	@mkdir -p static
	sassc $(STYLE_SCSS) > $@

$(TYPOGRAPHIC):
	bower install typographic
	@touch $@
