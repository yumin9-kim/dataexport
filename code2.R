library(data.table); library(tidyverse); library(ggplot2)

# Load file
url <- "https://raw.githubusercontent.com/jinseob2kim/lecture-snuhlab/master/data/example_g1e.csv"
g1e <- fread(url,header=T)

# Make plots
## Plot 1 - ht_plot
ht_plot <- g1e[EXMD_BZ_YYYY==2009] %>% ggplot(aes(x=HGHT)) + geom_histogram()
## Plot 2 - smk_plot
smk_plot <- g1e[,':='(Year=as.factor(EXMD_BZ_YYYY), smk=as.factor(Q_SMK_YN))] %>% ggplot(aes(x=Year, fill=smk)) + geom_bar(position='fill')

# install.packages(c("rvg", "officer"))
library(rvg); library(officer)

# method 1
plot1 <- read_pptx()
plot1 <- add_slide(plot1)
plot1 <- ph_with(x = plot1, ht_plot, location=ph_location_type(type="body"))
print(plot1, target = "plot1.pptx")

# method 2
plots <- read_pptx() %>% add_slide() %>% ph_with(ht_plot, location=ph_location_type(type="body"))
plots <- plots %>% add_slide() %>% ph_with(dml(ggobj = smk_plot), location=ph_location_type(type="body"))
plots <- plots %>% add_slide() %>% ph_with(smk, location=ph_location_type(type="body"))
print(plots, target = "plots.pptx")

# method 3
# install.packages("devEMF")
library(devEMF)
emf("smk_plot.emf", width = 7, height = 7, emfPlus = F)
print(smk_plot)
dev.off()

