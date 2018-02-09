import sys
import pdfquery
from lxml import etree

filename = sys.argv[-1]
pdf = pdfquery.PDFQuery(filename)
pdf.load()
root = pdf.tree.getroot()
sys.stdout.buffer.write(etree.tostring(root)) 