OPTS = -z -Ppdf -Pcmz -Pamz -Poutline -G0 -j0 -f -D 600 -Z -Pdownload35

DEPS = 

all: winter-day-2016-lecture.pdf winter-day-2016-handout.pdf

force:
	rm -f *.dvi *.pdf *.ps
	make

%-handout.tex: %-lecture.tex
	sed 's/,presentation/,handout/' < $< > $@


#######################
#  Classic latex
#######################

#%.pdf: %.ps
#	ps2pdfwr $<

#%.ps: %.dvi
#	dvips $(OPTS) -o $@ $<

#%.dvi: %.tex $(DEPS)
#	echo "Running latex... "
#	latex $<
#	latex_count=5 ; \
#        while egrep -s 'Rerun (LaTeX|to get cross-references right)' $(subst tex,log,$<) && \
#            [ $$latex_count -gt 0 ] ;\
#            do \
#              echo "Rerunning latex...." ;\
#              latex $< ;\
#              latex_count=`expr $$latex_count - 1` ;\
#            done

#######################
#  pdflatex
#######################

%.pdf: %.tex 
	echo "Running pdflatex... "
	pdflatex $<
	latex_count=5 ; \
        while egrep -s 'Rerun (LaTeX|to get cross-references right|to get citations correct)' $(subst tex,log,$<) && \
            [ $$latex_count -gt 0 ] ;\
            do \
              echo "Rerunning latex...." ;\
              pdflatex $< ;\
              latex_count=`expr $$latex_count - 1` ;\
            done

clean-all: clean
	rm -f *.dvi *.pdf *.ps

clean:
	rm -f *.log *.aux *.tmp *.out *.snm *.toc *.nav *~


