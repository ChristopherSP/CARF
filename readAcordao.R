library(pdftools)
library(stringi)
library(stringr)

file = '~/Downloads/CARF/pdf/Decisao_13702000879200547 (1).PDF'
doc = pdf_text(file)
doc = paste(doc,collapse = '\n\n')

cat(doc)

voto = stri_extract_all_regex(str = doc, pattern = "Desta\\sforma.*")[[1]]

if(grepl("negar", voto)){
  cat("########################\n\nFoi negado segmento ao Acordão\n\n########################")
} else {
  cat("########################\n\nO Acordão foi julgado procedente\n\n########################")
}


