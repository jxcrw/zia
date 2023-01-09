import os
from glob import glob

from PyPDF2 import PdfMerger

DIRECTORY = r'xyz'
os.chdir(DIRECTORY)


def pdf_merge():
    """Merge all pdf files in DIRECTORY."""
    merger = PdfMerger()
    pdfs = [a for a in glob('*.pdf')]
    [merger.append(pdf) for pdf in pdfs]
    with open('merged.pdf', 'wb') as f:
        merger.write(f)


if __name__ == '__main__':
    pdf_merge()
