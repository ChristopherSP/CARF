library(RSelenium)
library(stringi)

driver = rsDriver()
remDr = driver$client
remDr$open()

url = "http://carf.fazenda.gov.br/sincon/public/pages/ConsultarJurisprudencia/consultarJurisprudenciaCarf.jsf"

remDr$navigate(url)

dateFrom = '02/2017'
dateTo = '02/2018'
ementa = "contribuição pis cofins"

fieldDateFrom = remDr$findElement(using = 'id', value = "dataInicialInputDate")
fieldDateTo = remDr$findElement(using = 'id', value = "dataFinalInputDate")
fieldEmenta = remDr$findElement(using = 'id', value = "valor_pesquisa3")
buttonSearch = remDr$findElement(using = 'id', value = "botaoPesquisarCarf")

fieldDateFrom$clearElement()
fieldDateFrom$sendKeysToElement(list(dateFrom))
fieldDateTo$clearElement()
fieldDateTo$sendKeysToElement(list(dateTo))

fieldEmenta$clearElement()
fieldEmenta$sendKeysToElement(list(ementa))

buttonSearch$sendKeysToElement(list(key = "enter"))

Sys.sleep(20)
pageNumber = remDr$findElement(using = 'class name', value = "label_texto")
pageNumber$highlightElement()


if(length(pageNumber$errorDetails()) == 0){
  countPages = pageNumber$getElementText()[[1]]
  countPages = as.numeric(stri_extract_last_regex(countPages,"\\d+"))
} else {
  countPages = 1
}

folder = paste0("/home/christopher/Downloads/CARF/Acordaos/",stri_replace_all_fixed(dateFrom,"/","-"),"_",stri_replace_all_fixed(dateTo,"/","-"),"/",ementa,"/") 

dir.create(folder,recursive = T, showWarnings = F)

for (page in 1:3) {
  pageHTML = remDr$getPageSource()
  
  write.table(pageHTML,paste0(folder,"pagina",page,".html"))
  
  # nextPage = remDr$findElement(using = 'class name', value = "paginatorProximo")
  # nextPage$sendKeysToElement(list(key = "enter"))
  remDr$executeScript("document.getElementsByClassName('paginatorProximo')[0].click()", args = list(0))
  Sys.sleep(70)
}  


