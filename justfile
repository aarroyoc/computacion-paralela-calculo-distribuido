build:
	emacs --script org-beam-to-pdf.el
	cd practicas && emacs --script org-latex-to-pdf.el
clean:
	rm *.pdf
	rm *.vrb
	rm *.aux
	rm *.log
	rm *.nav
	rm *.out
	rm *.snm
	rm *.toc
	rm practicas/*.aux
	rm practicas/*.log
	rm practicas/*.out
	rm practicas/*.pdf
	
