library(data.table); library(tidyverse); library(tableone)

# Load file
url <- "https://raw.githubusercontent.com/jinseob2kim/lecture-snuhlab/master/data/example_g1e.csv"
g1e <- fread(url,header=T)

# Make tables
## Table 1 - htwt
htwt <- g1e[EXMD_BZ_YYYY==2009] %>% summarize(meanHGHT = mean(HGHT), meanWGHT = mean(WGHT))
## Table 2 - smk
smk <- g1e[EXMD_BZ_YYYY==2009] %>% CreateTableOne(vars=c("BP_SYS", "BP_DIA"), strata="Q_SMK_YN") %>% print(quote=F, noSpaces=T) %>% as.data.frame()

# install.packages("openxlsx") 
library(openxlsx)

# method 1
write.xlsx(htwt, file = "htwt.xlsx", overwrite=T)
write.xlsx(smk, file = "smk.xlsx", rowNames=T, overwrite=T)

# method 2
tablelist <- list(htwt, smk)
write.xlsx(tablelist, file = "tables.xlsx", rowNames=T)

# method 3
## create workbook
wb <- createWorkbook()
addWorksheet(wb = wb, sheetName = "htwt")
writeData(wb = wb, sheet = "htwt", x = htwt)

addWorksheet(wb = wb, sheetName = "smk")
writeData(wb = wb, sheet = "smk", x = smk, rowNames=T)

## view without saving
openXL(wb)
## save
saveWorkbook(wb, "tables.xlsx", overwrite = TRUE) 