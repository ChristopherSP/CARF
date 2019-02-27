library(rvest)
library(data.table)
library(stringi)

baseURL = "http://idg.carf.fazenda.gov.br/jurisprudencia/sumulas-carf/sumulas-por-materia/"

materias = baseURL %>% 
  read_html() %>% 
  html_nodes("div.cover-richtext-tile.tile-content") %>% 
  html_nodes("span") %>% 
  html_text()

materias = stri_replace_all_fixed(materias,"/","-")
materias = stri_replace_all_regex(materias," ","-")
materias = stri_replace_all_regex(materias,"-+","-")
materias = unique(tolower(stri_trans_general(materias,'latin-ascii')))

idx = 1
url = paste0(baseURL,materias[idx])

sumulaContribPrev = url %>% 
  read_html() %>% 
  html_nodes("div#parent-fieldname-text") %>% 
  html_text() %>% 
  strsplit("\\n") %>% 
  unlist() %>% 
  as.data.table()

names(sumulaContribPrev) = 'texto'

sumulaContribPrev[, c("id","sumula") := tstrsplit(texto, ":", fixed=TRUE)]
sumulaContribPrev[,texto := NULL]

write.table(sumulaContribPrev,paste0('~/Downloads/CARF/sumulas_',materias[idx],'.csv'),quote=F,sep='\t',row.names = F)
