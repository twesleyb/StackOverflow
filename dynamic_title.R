#'---
#'  author: "Author test"
date: " `r Sys.setlocale('LC_TIME','C');format(Sys.Date(),'%B %d, %Y')` "
output:
  pdf_document:
  toc: yes
toc_depth: 5
keep_tex: yes
html_document:
  theme: united
toc: yes
classoption: table
header-includes:
  - \usepackage{array}
- \usepackage{float}
- \usepackage{xcolor}
- \usepackage{caption}
- \usepackage{longtable}
#- \usepackage{mulicol}
params: 
  set.title: title
title: " `r params$set.title` "
---

rm(list = ls())
dev.off()
f = "\f"
cat(f) #cat("\014") #alt= > cat("\f")

# Set the working directory
root_dir <- "D:/Documents/R/StackOverflow"
setwd(root_dir)


rmarkdown::render("dynamic_title.R")