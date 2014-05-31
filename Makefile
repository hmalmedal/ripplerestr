DOC = DOCUMENTATION.md
Rd := $(wildcard man/*.Rd)
md := $(Rd:.Rd=.md)

$(DOC) : $(md)
	cat $(md) > $(DOC)

%.html : %.Rd
	R CMD Rdconv -t html $< -o $@

%.md : %.html
	pandoc -t markdown_github $< -o $@

.PHONY : clean distclean
clean :
	rm -f $(md)

distclean : clean
	rm -f $(DOC)
