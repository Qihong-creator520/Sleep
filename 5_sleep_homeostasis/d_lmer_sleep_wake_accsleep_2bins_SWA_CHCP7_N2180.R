library(lme4)
library(lmerTest)
library(readxl)
library(emmeans)
library(tidyverse)
library(broom.mixed)
library(data.table)

setwd('/nd_disk2/qihong/Sleep_PKU/brain_restoration/Sleep_EEG_fMRI-main_v202410/5_sleep_homeostasis')
dir()
data=fread("Model_sleep_wake_accsleep_2bins_SWA_CHCP7_6validations_N2180.txt",header=TRUE,sep=',')
str(data)


nn=names(data)[8:15]
nn

write.table(t(nn),'out_sleep_wake_accsleep_2bins_SWA_CHCP7_N2180.csv',sep=',',append=TRUE,row.names=FALSE,col.names=FALSE)


re1=NULL
re2=NULL
tmp=NULL
out1=NULL
out2=NULL
out3=NULL
out4=NULL

for(i in seq_along(nn)){
  i
  model<-lmer(formula(paste0(nn[i],"~Var5*as.factor(stage_n)+(1|Var1)+(1|Var7)+Var2+Var3+Var4")),data=data)
  re1[[i]]=anova(model)

  out1[[i]]=re1[[i]]$`F value`[[6]]
  out2[[i]]=re1[[i]]$`Pr(>F)`[[6]]
  
  re2[[i]] = emmeans(model,pairwise~stage_n|Var5,adjust="none")
  
  tmp=re2[[i]]$`contrasts`
  
  out3[[i]]<-tidy(tmp)$estimate
  out4[[i]]<-tidy(tmp)$std.error
  
  
}

write.table(t(out1),'out_sleep_wake_accsleep_2bins_SWA_CHCP7_N2180.csv',sep=',',append=TRUE,row.names=FALSE,col.names=FALSE)
write.table(t(out2),'out_sleep_wake_accsleep_2bins_SWA_CHCP7_N2180.csv',sep=',',append=TRUE,row.names=FALSE,col.names=FALSE)
write.table(out3,'out_sleep_wake_accsleep_2bins_SWA_CHCP7_N2180.csv',sep=',',append=TRUE,row.names=FALSE,col.names=FALSE)
write.table(out4,'out_sleep_wake_accsleep_2bins_SWA_CHCP7_N2180.csv',sep=',',append=TRUE,row.names=FALSE,col.names=FALSE)
