library(ggplot2)
library(ggpubr)
setwd('/Users/zh_y/Desktop/毕业设计/q-PCR')
getwd()
q <- read.csv('3300csv.csv')
q
#正态分布检验，p>0.05为正态分布
shapiro.test(q$value)
#方差齐检验，p>0.05为方差齐
bartlett.test(q$value~q$group)

##如果数据符合正态分布且方差齐，则使用t检验
#t检验,P<0.05为差异显著
t.test(exp[which(exp$Group=="control"),"value"],exp[which(exp$Group=="treatment"),"value"],paired=F,var.equal=T)

##如果数据不符合正态分布或者方差不齐，使用非参数检验，例如wilcox.test
wilcox.test(exp[which(exp$Group=="control"),"value"],exp[which(exp$Group=="treatment"),"value"])

#绘图
p1 <- ggbarplot(q, x = "group", y = "value", add = "mean_se",width = 0.5,
                color = "group",fill = "group", palette = "npg", 
                position = position_dodge(0.7))
p1 <- p1 + stat_compare_means(method = "t.test",  label.y = 1.4)
p1

