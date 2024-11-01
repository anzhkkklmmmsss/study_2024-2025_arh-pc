FILES = $(patsubst %.md, %.docx, $(wildcard *.md))
FILES += $(patsubst %.md, %.pdf, $(wildcard *.md))

FILTERS =
OPTIONS =
PDF_ENGINE =
PDF_OPTIONS =
FORMAT_OPTIONS =

#FILTERS += --filter pandoc-crossref
#PDF_ENGINE += --pdf-engine=xelatex --pdf-engine-opt=--shell-escape
PDF_ENGINE += --pdf-engine=lualatex --pdf-engine-opt=--shell-escape
OPTIONS += --number-sections --toc
BIB_OPTIONS = --citeproc
PDF_BIB_OPTIONS = --citeproc

lab6.o: lab6.asm
	nasm -o lab6.o -f elf -g -l list.lst lab6.asm

lab5-1-copy: lab6.o
	ld -m elf_i386 lab6.o -o lab6

%.docx: %.md
	-pandoc "$<" $(FILTERS) $(OPTIONS) $(BIB_OPTIONS) -o "$@"

%.pdf: %.md
	-pandoc "$<" $(FILTERS) $(PDF_ENGINE) $(PDF_OPTIONS) $(PDF_BIB_OPTIONS) $(FORMAT_OPTIONS) $(OPTIONS) -o "$@"

all: $(FILES) lab6


clean:
	-rm $(FILES) *~

cleanall: clean
