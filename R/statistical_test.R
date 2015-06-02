## Test change in RA according to plant endophyte:
#variance are homogene but residuals of aov are non normal
glm.out<-glm(RA~nb.Vtiller*endo,family=gaussian, data= datay1)
bartlett.test(RA~endo, data=datay1)
aov.out <- aov(glm.out)
shapiro.test(residuals(aov.out))

## non parametric ANCOVA
sm.ancova(datay1$RA, datay1$nb.Vtiller, datay1$endo, model = "equal")


## ANOVA on parameters:
a <- glm(formula = s1 ~ endo * treatment , family = quasibinomial(link = logit), data = datay2, na.action = na.exclude, control = list(epsilon = 0.0001, maxit = 50, trace = F))
anova(a,test="Chisq")

b <- glm(formula = s2 ~ endo * treatment , family = quasibinomial(link = logit), data = datay2, na.action = na.exclude, control = list(epsilon = 0.0001, maxit = 50, trace = F))
anova(b,test="Chisq")

c <- glm(formula = e1 ~ endo * treatment , family = quasibinomial(link = logit), data = datay2, na.action = na.exclude, control = list(epsilon = 0.0001, maxit = 50, trace = F))
anova(c,test="Chisq")


d <- glm(formula = p ~ endo * treatment , family = poisson, data = datay2, na.action = na.exclude, control = list(epsilon = 0.0001, maxit = 50, trace = F))
anova(d,test="Chisq")

glmf <- glm(f1~endo*treatment, data=datay2, family=gaussian)
anova(glmf, test = "Chisq")

e <- glm(formula = e0 ~ endo * treatment , family = quasibinomial(link = logit), data = datay2, na.action = na.exclude, control = list(epsilon = 0.0001, maxit = 50, trace = F))
anova(e,test="Chisq")

f <- glm(formula = TA ~ treatment , family = quasibinomial(link = logit), data = datay2, na.action = na.exclude, control = list(epsilon = 0.0001, maxit = 50, trace = F))
anova(f,test="Chisq")

g <- glm(formula = TS ~ treatment , family = quasibinomial(link = logit), data = datay2, na.action = na.exclude, control = list(epsilon = 0.0001, maxit = 50, trace = F))
anova(g,test="Chisq")


## test of Lamnda difference with summary data (mean and SE)
library(BSDA)

#comparison NScontorl and Scontrol

# value from ULM (mean growth rate and SE)
n1 <- 100

mean_NSC <- 1.18 
se_NSC <- 0.0247
sd_NSC <- se_NSC/sqrt(n1)

mean_NSF <- 1.44
se_NSF <- 0.0506
sd_NSF <- se_NSF/sqrt(n1)

mean_SC <- 1.93
se_SC <- 0.0899
sd_SC <- se_SC/sqrt(n1)

mean_SF <- 1.65
se_SF <- 0.073
sd_SF <- se_SF/sqrt(n1)

S_NS_control_comparison <- tsum.test(mean.x = mean_NSC ,s.x =sd_NSC ,n.x =100, mean.y=mean_SC,s.y=sd_SC,n.y= 100,alternative = "two.sided", mu = 0, var.equal = FALSE,
          conf.level = 0.95)

S_NS_fertilized_comparison <- tsum.test(mean.x = mean_NSF ,s.x =sd_NSF ,n.x =100, mean.y=mean_SF,s.y=sd_SF,n.y= 100,alternative = "two.sided", mu = 0, var.equal = FALSE,
                                     conf.level = 0.95)

S_Fertilized_control_comparison <- tsum.test(mean.x = mean_SC ,s.x =sd_SC ,n.x =100, mean.y=mean_SF,s.y=sd_SF,n.y= 100,alternative = "two.sided", mu = 0, var.equal = FALSE,
                                     conf.level = 0.95)

NS_Fertilized_control_comparison <- tsum.test(mean.x = mean_NSC ,s.x =sd_NSC ,n.x =100, mean.y=mean_NSF,s.y=sd_NSF,n.y= 100,alternative = "two.sided", mu = 0, var.equal = FALSE,
                                             conf.level = 0.95)
