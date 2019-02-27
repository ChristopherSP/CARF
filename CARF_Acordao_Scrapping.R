library(rvest)

filePath = '~/Downloads/CARF/Acordaos/02-2017_02-2018/contribuição pis cofins/pagina1.html'

htmlPage = filePath %>% 
  read_html(encoding = "UTF-8") %>%
  html_nodes(".\"rich-panel-body") %>% 
  
  html_text()

filePath %>% 
  read_html(encoding = "UTF-8") %>%
  html_nodes("td.rich-table-cell")

filePath %>% 
  read_html(encoding = "UTF-8") %>%
  html_nodes(xpath = '//*[@id="\"tblJurisprudencia\""]')


filePath %>% 
  read_html(encoding = "UTF-8") %>%
  html_nodes("span") %>% 
  html_text()

htmlPage[1]
