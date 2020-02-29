%: %.chpl
	chpl $^ -o $@
n1 = 01-base
n2 = 02-task-parallelism
n3 = 03-domain-parallelism
upload:
	doctoc $(n1).md          # insert table of contents
	doctoc $(n2).md
	doctoc $(n3).md
	@/bin/cp -f {01-base,02-task-parallelism,03-domain-parallelism}.md ~/Movies/publish
	@/bin/cp -f slides.pdf ~/Movies/publish/chapel.pdf
	#grip $(n1).md --export $(n1).html --title="$(n1)"   # convert md to html
	#grip $(n2).md --export $(n2).html --title="$(n2)"
	#grip $(n3).md --export $(n3).html --title="$(n3)"
	# pandoc $(n1).html -o $(n1).epub   # convert html to epub
	# pandoc $(n2).html -o $(n2).epub
	# pandoc $(n3).html -o $(n3).epub
	#@/bin/rm {$(n1),$(n2),$(n3)}.html
	@ls -lh ~/Movies/publish/{01-base,02-task-parallelism,03-domain-parallelism}.md
	# @ls -l {$(n1),$(n2),$(n3)}.epub
	# @echo use Calibre to transfer this *.epub to Kindle
html:
	doctoc $(n1).md          # insert table of contents
	doctoc $(n2).md          # insert table of contents
	doctoc $(n3).md          # insert table of contents
	grip $(n1).md --export $(n1).html --title="$(n1)"
	grip $(n2).md --export $(n2).html --title="$(n2)"
	grip $(n3).md --export $(n3).html --title="$(n3)"
	@echo
	@echo consider mailing these as attachments to rkenjius_e32e34@kindle.com
clean:
	echo $(uname)
	@/bin/rm -rf *~ *.aux *.nav *.synctex* *.log *.out *.snm
