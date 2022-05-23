library(trend)
library(Kendall)

arquivos <- dir(pattern=".txt$")

df<-read.csv(arquivos[5], h=T, sep="\t")

m<-matrix(ncol=6)
m[1,] <- c("DADO", "TAU-MK", "SENS SLOPE", "P VALUE", "PETTIT TEST", "P VALUE")

for (i in 1:ncol(df)) {
  m<- rbind(m,
      c(names(df[i]), MannKendall(df[,i][complete.cases(df[,i])])$tau[1], as.vector(sens.slope(df[,i][complete.cases(df[,i])])$estimates), sens.slope(df[,i][complete.cases(df[,i])])$p.value, as.vector(pettitt.test(df[,i][complete.cases(df[,i])])$estimate),
        pettitt.test(df[,i][complete.cases(df[,i])])$p.value)
  )
}


write.csv(m, paste0("resultados_",arquivos[5]), row.names = F)
