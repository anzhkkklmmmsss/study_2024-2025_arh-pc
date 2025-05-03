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

lab5-1-copy.o: lab5-1-copy.asm
	nasm -o lab5-1-copy.o -f elf -g -l list.lst lab5-1-copy.asm

lab5-2-copy.o: lab5-2-copy.asm
	nasm -o lab5-2-copy.o -f elf -g -l list.lst lab5-2-copy.asm

lab5-1-copy: lab5-1-copy.o
	ld -m elf_i386 lab5-1-copy.o -o lab5-1-copy

lab5-2-copy: lab5-2-copy.o
	ld -m elf_i386 lab5-2-copy.o -o lab5-2-copy

%.docx: %.md
	-pandoc "$<" $(FILTERS) $(OPTIONS) $(BIB_OPTIONS) -o "$@"

%.pdf: %.md
	-pandoc "$<" $(FILTERS) $(PDF_ENGINE) $(PDF_OPTIONS) $(PDF_BIB_OPTIONS) $(FORMAT_OPTIONS) $(OPTIONS) -o "$@"

all: $(FILES) lab5-1-copy lab5-2-copy 


clean:
	-rm $(FILES) *~

cleanall: clean
