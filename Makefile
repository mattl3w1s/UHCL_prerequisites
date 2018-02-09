UHCL_CATALOG_URL = https://catalog.uhcl.edu/current/undergraduate/catalog.pdf
GENERATED_FILES = finished/UHCL_prerequisites.xml
PROCESSORS = ./processors
MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -eu -o pipefail
.DEFAULT_GOAL := all
.DELETE_ON_ERROR:
.SUFFIXES:

.PHONY: all clean

all: $(GENERATED_FILES)

clean:
	rm -Rf finished/*

finished/UHCL_prerequisites.xml: UHCL_catalog_excerpt_419-573_parsed_xml.xml
	sed '/<course\/>/d' ./$< > $@

.INTERMEDIATE: UHCL_catalog_excerpt_419-573_parsed_xml.xml
UHCL_catalog_excerpt_419-573_parsed_xml.xml: UHCL_catalog_excerpt_419-573_xml.xml
	cat $< | python $(PROCESSORS)/parse_xml.py > $@

.INTERMEDIATE: UHCL_catalog_excerpt_419-573_xml.xml
UHCL_catalog_excerpt_419-573_xml.xml: UHCL_catalog_excerpt_419-573.pdf
	python $(PROCESSORS)/convert_pdf2xml.py $< > $@

.INTERMEDIATE: UHCL_catalog_excerpt_419-573.pdf
UHCL_catalog_excerpt_419-573.pdf: UHCL_catalog.pdf
	python $(PROCESSORS)/excerpt_PDF.py $< > $@

.INTERMEDIATE: UHCL_catalog.pdf
UHCL_catalog.pdf:
	wget -O UHCL_catalog.pdf $(UHCL_CATALOG_URL)