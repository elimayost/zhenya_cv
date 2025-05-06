
pdf: deactivate_menu generate_pdf activate_menu

generate_pdf:
	@-curl -s localhost:8000/employment | wkhtmltopdf - pdf/employment.pdf
	@-curl -s localhost:8000/skills     | wkhtmltopdf - pdf/skills.pdf
	@-curl -s localhost:8000/education  | wkhtmltopdf - pdf/education.pdf
	@-curl -s localhost:8000/interests  | wkhtmltopdf - pdf/interests.pdf
	@-rm -f pdf/evgeniiabaianova-cv.pdf
	@-gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=pdf/evgeniiabaianova-cv.pdf pdf/employment.pdf pdf/skills.pdf pdf/education.pdf pdf/interests.pdf

deactivate_menu:
	@-sed -i '' 's/.*partials\/menu.*/<!--&-->/' src/zhenya_cv/templates/employment.html
	@-sed -i '' 's/.*partials\/menu.*/<!--&-->/' src/zhenya_cv/templates/skills.html
	@-sed -i '' 's/.*partials\/menu.*/<!--&-->/' src/zhenya_cv/templates/education.html
	@-sed -i '' 's/.*partials\/menu.*/<!--&-->/' src/zhenya_cv/templates/interests.html

activate_menu:
	@-sed -i '' 's/.*partials\/menu.*/\t{% include "partials\/menu.html" %}/' src/zhenya_cv/templates/employment.html
	@-sed -i '' 's/.*partials\/menu.*/\t{% include "partials\/menu.html" %}/' src/zhenya_cv/templates/skills.html
	@-sed -i '' 's/.*partials\/menu.*/\t{% include "partials\/menu.html" %}/' src/zhenya_cv/templates/education.html
	@-sed -i '' 's/.*partials\/menu.*/\t{% include "partials\/menu.html" %}/' src/zhenya_cv/templates/interests.html

deploy:
	@-curl -s localhost:8000/employment > docs/index.html
	@-curl -s localhost:8000/skills     > docs/skills.html
	@-curl -s localhost:8000/education  > docs/education.html
	@-curl -s localhost:8000/interests  > docs/interests.html
	@-cp pdf/evgeniiabaianova-cv.pdf docs/evgeniiabaianova-cv.pdf
	@-sed -i '' "s/href='\/pdf'/href='evgeniiabaianova-cv.pdf'/" docs/*.html
	@-echo "evgeniiabaianova.com" > docs/CNAME
	@-echo "www.evgeniiabaianova.com" >> docs/CNAME
	@-git add .
	@-git commit -m 'backup'
	@-git push
