all: chapel
chapel:
	doctoc chapel.md   # insert table of contents
#	grip chapel.md --export chapel.html --title="chapel"   # generate html
	@/bin/cp -f chapel.md ~/Movies/publish
	@ls -lh ~/Movies/publish/chapel.md
