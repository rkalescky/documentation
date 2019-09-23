#!/bin/bash

sed -i -e 's/example-code docutils container/example-code docutils/g' _build/html/applications.html
sed -i -e 's/<div class="highlight-MATLAB"><div class="highlight">/<div class="highlight-MATLAB"><br><div class="highlight">/g' _build/html/applications.html
sed -i -e 's/<div class="highlight-Python"><div class="highlight">/<div class="highlight-Python"><br><div class="highlight">/g' _build/html/applications.html
sed -i -e 's/<div class="highlight-R"><div class="highlight">/<div class="highlight-R"><br><div class="highlight">/g' _build/html/applications.html
sed -i -e 's/<div class="highlight-SAS"><div class="highlight">/<div class="highlight-SAS"><br><div class="highlight">/g' _build/html/applications.html
sed -i -e 's/<div class="highlight-STATA"><div class="highlight">/<div class="highlight-STATA"><br><div class="highlight">/g' _build/html/applications.html
sed -i -e 's+<p><strong>Additional Usage for MATLAB</strong></p>+<h2><strong>Additional Usage for MATLAB</strong></h2>+g' _build/html/applications.html
