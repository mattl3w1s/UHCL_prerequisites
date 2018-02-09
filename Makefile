


UHCL_prerequisites.xml: UHCL_catalog_excerpt_419-573_parsed_xml.xml
	sed '/<course\/>/d' ./$< > $@

.INTERMEDIATE: UHCL_catalog_excerpt_419-573_parsed_xml.xml
UHCL_catalog_excerpt_419-573_parsed_xml.xml: UHCL_catalog_excerpt_419-573_xml.xml
	cat $< | python script2.py > $@

.INTERMEDIATE: UHCL_catalog_excerpt_419-573_xml.xml
UHCL_catalog_excerpt_419-573_xml.xml: UHCL_catalog_excerpt_419-573.pdf
	python script.py $< > $@

.INTERMEDIATE: UHCL_catalog_excerpt_419-573.pdf
UHCL_catalog_excerpt_419-573.pdf: UHCL_catalog.pdf
	python excerpt_PDF.py $< > $@

.INTERMEDIATE: UHCL_catalog.pdf
UHCL_catalog.pdf:
	wget -O UHCL_catalog.pdf https://catalog.uhcl.edu/current/undergraduate/catalog.pdf