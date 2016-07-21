STATIC_EXPORT_FOLDER=static

grunt:	
	cp phileas.css style.css
	./node_modules/grunt-cli/bin/grunt
	cp phileas.css style.css
	
static:
	-mkdir $(STATIC_EXPORT_FOLDER)
	-cp *.jpg $(STATIC_EXPORT_FOLDER)
	-cp *.png $(STATIC_EXPORT_FOLDER)
	-cp *.gif $(STATIC_EXPORT_FOLDER)
	-cp *.css $(STATIC_EXPORT_FOLDER)
	for a in *.t2t ; do \
		txt2tags --config-file=static_config.txt --style=phileas.css  --css-sugar -t html -o $(STATIC_EXPORT_FOLDER)/$$a.html $$a ; done
		
	txt2tags --config-file=static_config.txt --no-headers --css-sugar -t html -o $(STATIC_EXPORT_FOLDER)/menu.t2t.html menu.t2t
	txt2tags --config-file=static_config.txt --no-headers --css-sugar -t html -o $(STATIC_EXPORT_FOLDER)/header.t2t.html header.t2t
	txt2tags --config-file=static_config.txt --no-headers --css-sugar -t html -o $(STATIC_EXPORT_FOLDER)/footer.t2t.html footer.t2t

	sed -i -e "s|"header"|"none"|g" $(STATIC_EXPORT_FOLDER)/menu.t2t.html
	sed -i -e "s|"header"|"none"|g" $(STATIC_EXPORT_FOLDER)/footer.t2t.html
	sed -i -e "s|"header"|"none"|g" $(STATIC_EXPORT_FOLDER)/header.t2t.html
	
	txt2tags --config-file=static_config.txt --style=phileas.css --css-sugar -t html -o $(STATIC_EXPORT_FOLDER)/index.t2t.html index.t2t
	
	
	sed -i -e "s|"body"|"menu"|g" $(STATIC_EXPORT_FOLDER)/menu.t2t.html
	sed -i -e "s|"body"|"footer"|g" $(STATIC_EXPORT_FOLDER)/footer.t2t.html
	sed -i -e "s|"body"|"header"|g" $(STATIC_EXPORT_FOLDER)/header.t2t.html
	#sed -i -e "s|"body"|"container"|g" $(STATIC_EXPORT_FOLDER)/index.t2t.html
	#sed -i -e 's|<DIV CLASS="container"|<div id="main"><DIV CLASS="container"|g' $(STATIC_EXPORT_FOLDER)/index.t2t.html
	
	#for b in $(STATIC_EXPORT_FOLDER)/*html ; do \
	#	sed -i -e "s|\[\(.*\) ?page=\(.*\).t2t\]|<a href='\2.t2t.html'>\1</a>|g" $$b ; done
	
	for c in $(STATIC_EXPORT_FOLDER)/*.t2t.html; do \
	if [ "$$c" != $(STATIC_EXPORT_FOLDER)/menu.t2t.html ] ; \
	then \
	sed -i -e "s|"body"|"container"|g" $$c ; \
	sed -i -e 's|<DIV CLASS="container"|<div id="main"><DIV CLASS="container"|g' $$c ; \
	cat $$c $(STATIC_EXPORT_FOLDER)/footer.t2t.html $(STATIC_EXPORT_FOLDER)/header.t2t.html $(STATIC_EXPORT_FOLDER)/menu.t2t.html > $${c%%.*}.html ;\
	rm $$c ; fi ; done 
