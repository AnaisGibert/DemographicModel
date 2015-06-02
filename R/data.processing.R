
## Clean up the dataset

clean_raw_data <- function(data){
  
  data["area"] <- NA
  fun_area <- function(x, long, width) ((pi*long*width)/4)
  for (i in 1:length(data$size.long)) {
    data$area[i] <- fun_area(x = data$data[i], long= data$size.long[i], width=data$size.larg[i])
  }
  
  data["RA"] <- NA
  for (i in 1:length(na.omit(data$nb.Vtiller))){
    data$RA[i] <- data$nb.Rtiller[i]/ (data$nb.Vtiller[i] + data$nb.Rtiller[i])
  }
  
  data
}

data <- clean_raw_data(data)
datay1 <- subset(data, data$year=="1")
datay2 <- subset(data, data$year=="2")
datay1.2 <- na.omit(datay1[1:200 , c(2,10,12)])

data_simu_raw <-read.csv("data/md_simu.csv", sep=';', dec=",", colClasses = c(rep("factor",2),rep("numeric",4)), na.strings = TRUE)
data_simu <- subset(data_simu_raw, data_simu_raw$simu=="a")
data_simu_TS <- subset(data_simu_raw, data_simu_raw$simu=="b")
data_simu_TA <- subset(data_simu_raw, data_simu_raw$simu=="c")


### Functions for parameters calculation
st.err <- function(x, na.rm=FALSE) {
  if(na.rm==TRUE) x <- na.omit(x)
  sd(x)/sqrt(length(x))
}

param<- list("mean"= aggregate(datay2[, c(11,14, 16:21)], list(datay2$mod), mean, na.rm = TRUE),
             "sd"=aggregate(datay2[, c(11,14, 16:21)], list(datay2$mod), sd, na.rm = TRUE), 
             "se"=aggregate(datay2[, c(11,14, 16:21)], list(datay2$mod), st.err, na.rm = TRUE))

### Functions for matrix calculation
F_mean <- function(f1, p, e0) {round((f1 * p *e0), digits=3) }
F_sd <- function(f1, f1_sd, p, p_sd, e0, e0_sd) { sqrt((f1*p_sd)^2 + (p*f1_sd)^2 +(e0*f1_sd)^2 +(e0*p_sd)^2 + (f1*e0_sd)^2 +(p*e0_sd)^2)}

Gj2_mean <- function(e1, s2) { round(((1- e1)*s2), digits=3) }
Gj2_sd <- function(e1, e1_sd, s2, s2_sd) {
  e <- 1-e1
  e_sd <- 1-e1_sd  
  round(sqrt((e*s2_sd)^2 + (s2*e_sd)^2), digits=3) }

GA1_mean <- function(e1, s2) {round((e1 * s2), digits=3) }
GA1_sd <- function(e1, e1_sd, s2, s2_sd) { sqrt((e1*s2_sd)^2 + (s2*e1_sd)^2 )}

stages<-c("seedling", "juvenile1", "juvenile2","adult")
mat_mean <- list()
mat_sd <- list()

for (i in 1:4) {
  mat_mean[[i]] <- matrix(c(
    0, 0, 0, F_mean(param$mean$f1[[i]],param$mean$p[[i]], param$mean$e0[[i]]),
    param$mean$s1[[i]] , 0,  0, 0,
    0, Gj2_mean(param$mean$e1[[i]],param$mean$s2[[i]]) , 0, 0,
    0, GA1_mean(param$mean$e1[[i]],param$mean$s2[[i]]),  param$mean$s2[[i]], 0.95),
    nrow=4, byrow=TRUE, dimnames=list(stages,stages))
} 

for (i in 1:4) {
  mat_sd[[i]] <- matrix(c(
    0, 0, 0, F_sd(param$mean$f1[[i]],param$sd$f1[[i]],param$mean$p[[i]],param$sd$p[[i]],param$mean$e0[[i]], param$sd$e0[[i]]),
    param$sd$s1[[i]] , 0,  0, 0,
    0, Gj2_sd(param$mean$e1[[i]],param$sd$e1[[i]],param$mean$s2[[i]],param$sd$s2[[i]]) , 0, 0,
    0, GA1_sd(param$mean$e1[[i]],param$sd$e1[[i]],param$mean$s2[[i]],param$sd$s2[[i]]),  param$sd$s2[[i]], 0.95),
    nrow=4, byrow=TRUE, dimnames=list(stages,stages))
} 

matrixNSC <- mat_mean[[1]]
matrixNSCsd <- mat_sd[[1]]
matrixNSF <- mat_mean[[2]]
matrixNSFsd <- mat_sd[[2]]
matrixSC <- mat_mean[[3]]
matrixSCsd <- mat_sd[[3]]
matrixSF <- mat_mean[[4]]
matrixSFsd <- mat_sd[[4]]


## LTRE analysis
Ater <- list(SC=mat_mean[[2]],NSF=mat_mean[[3]],SF=mat_mean[[4]])
Cm <- LTRE(Ater,matrixNSC)
a <- sapply(Cm,sum)
a

b <- matrix(unlist(Cm),nrow=3,byrow=TRUE)
colnames(b) <- c("a11","GJ1","a13","a14","a21","a22","GJ2","GA1","a31","a32","a33","GA2","F","a42","a43","SA")
rownames(b) <- c("SC","NSF","SF")
b

b <- b[,c("GJ1", "GJ2","GA1","GA2", "F", "SA")]

md <- melt(b)
