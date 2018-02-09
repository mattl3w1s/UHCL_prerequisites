from PyPDF2 import PdfFileWriter, PdfFileReader 
import sys

filename = sys.argv[-1]

infile = PdfFileReader(open(filename,'rb'))
outfile = PdfFileWriter()
for i in range(418,573):
    p = infile.getPage(i)
    outfile.addPage(p)
outfile.write(sys.stdout.buffer)