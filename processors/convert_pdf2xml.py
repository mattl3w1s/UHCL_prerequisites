import sys
import pdfquery
from pdfquery.cache import FileCache
from lxml import etree

filename = sys.argv[-1]
pdf = pdfquery.PDFQuery(filename)
pdf.load()
root = pdf.tree.getroot()
sys.stdout.write(etree.tostring(root).decode('utf-8')) 