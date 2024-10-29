FILES = $(patsubst %.md, %.docx, $(wildcard *.md))
FILES += $(patsubst %.md, %.pdf, $(wildcard *.md))

FILTERS =
OPTIONS =
PDF_ENGINE =
PDF_OPTIONS =
FORMAT_OPTIONS =

FILTERS += --filter pandoc-crossref
#PDF_ENGINE += --pdf-engine=xelatex --pdf-engine-opt=--shell-escape
PDF_ENGINE += --pdf-engine=lualatex --pdf-engine-opt=--shell-escape
OPTIONS += --number-sections --toc
BIB_OPTIONS = --citeproc
PDF_BIB_OPTIONS = --citeproc

lab4.o: lab4.asm
	nasm -o lab4.o -f elf -g -l list.lst lab4.asm

lab4: lab4.o
	ld -m elf_i386 lab4.o -o lab4

%.docx: %.md
	-pandoc "$<" $(FILTERS) $(OPTIONS) $(BIB_OPTIONS) -o "$@"

%.pdf: %.md
	-pandoc "$<" $(FILTERS) $(PDF_ENGINE) $(PDF_OPTIONS) $(PDF_BIB_OPTIONS) $(FORMAT_OPTIONS) $(OPTIONS) -o "$@"

all: $(FILES) lab4


clean:
	-rm $(FILES) *~

cleanall: clean
