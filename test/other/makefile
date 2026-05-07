LUALATEX_TARGETS = test-base_jp
XELATEX_TARGETS  = test-base_nm
PDFLATEX_TARGETS = test-base_de test-base_es test-base_fr test-base_hu test-base_it test-base_nl test-base_pt
TEMP_EXT         = synctex.gz

CMD              = latexmk
MODE             = -interaction=nonstopmode -synctex=1 -auxdir=build
lualatex : TEX  := -lualatex
xelatex  : TEX  := -xelatex
pdflatex : TEX  := -pdflatex
all      : TEX  := -xelatex

TARGETS          = $(LUALATEX_TARGETS) $(XELATEX_TARGETS) $(PDFLATEX_TARGETS)
TEMP             = $(foreach ext, $(TEMP_EXT), $(addsuffix .$(ext), $(TARGETS)))
LUALATEX_OBJECTS = $(addsuffix .pdf, $(LUALATEX_TARGETS))
XELATEX_OBJECTS  = $(addsuffix .pdf, $(XELATEX_TARGETS))
PDFLATEX_OBJECTS = $(addsuffix .pdf, $(PDFLATEX_TARGETS))
OBJECTS          =  $(LUALATEX_OBJECTS) $(XELATEX_OBJECTS) $(PDFLATEX_OBJECTS)

ifeq ($(OS), Windows_NT)
	RM    = del
	RMDIR = rmdir /s /q
else
	RM    = rm
	RMDIR = rm -r
endif

targets    : lualatex xelatex pdflatex

lualatex   : $(LUALATEX_OBJECTS)
xelatex    : $(XELATEX_OBJECTS)
pdflatex   : $(PDFLATEX_OBJECTS)

$(OBJECTS) : %.pdf : %.tex
	$(CMD) $(TEX) $(MODE) $<

all :
	$(CMD) $(TEX) $(MODE)

install    : targets
	-$(CMD) -c
	-$(RMDIR) build
	-$(RM) $(TEMP)

clean :
	-$(CMD) -C
	-$(RMDIR) build
	-$(RM) $(TEMP)

.PHONY : targets lualatex xelatex pdflatex all install clean
