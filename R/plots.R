#####################################################
######### Functions for the figures #################
####################################################

# Figure 1: drawn with illustrator (no available)

# Figure 2:
figure_2 <- function(dataset){
  p <- sm.density.compare(dataset$nb.Vtiller, dataset$endo, xlab="Nbr of tillers", model="equal")
  p
  text(paste("test of equal densities, p value=", p$p), x = 1500, y = 0.0025, cex = 0.8)
} 


# Figure 3:
mytheme <- theme_bw() + theme(text = element_text(size = 9, colour = "black"),
                              title = element_text(size = 9, hjust = 0), axis.title = element_text(size = 9,
                                                                                                   hjust = 0.5), axis.text = element_text(size = 8), axis.line = element_line(colour = "black"),
                              panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.border = element_blank(),
                              panel.background = element_blank(), legend.justification = c(1, 0), legend.position = c(1,0.5))


figure_3 <- ggplot(md, aes(x=X2, y=value, fill=factor(X1))) +
  geom_bar(stat="identity", position="dodge") + 
  mytheme + scale_fill_manual(values = c(SC = "grey",NSF = "blue", SF = "turquoise"),
                              labels = c("Symbiotic-Control", "Non Symbiotic-Fertilized", "Symbiotic-Fertilized")) + 
  geom_hline(yintercept = 0, color = "black", lty=5)+
  xlab("Contribution to lambda") + ylab("Transition matrix elements")+
  theme (legend.title=element_blank(),
         legend.justification=c(0,0),
         legend.position=c(0.6,0.5),
         legend.key = element_blank()) 

## Figure 4:

Figure_4 <- function(data_simu_TA, data_simu_TS) {

pTA <- ggplot(data_simu_TA,aes(x=ta,y=S, color=factor(treatment))) +
  geom_point() +
  xlab("") +
  scale_colour_manual(values = c("control"="black","fertilized"="green"),
                      labels = c("natural condition", "fertilized condition")) + 
  ylab("Endophyte prevalence in the population (%)") +
  xlab("Transmission rate from adult to seedling (TA)") +
  ylim(0,100)+
  xlim(0,1)+
  labs(title = "a)") +
  mytheme  + theme(legend.position = "none")

pTS <- ggplot(data_simu_TS,aes(x=ts,y=S, color=factor(treatment))) +
  geom_point() +
  xlab("") +
  scale_colour_manual(values = c("control"="black","fertilized"="green"),
                      labels = c("natural condition", "fertilized condition")) + 
  ylab("") +
  xlab("Transmission rate from seedling to juvenile (TS)") +
  ylim(0,100)+
  xlim(0,1)+
  labs(title = "b)") +
  mytheme +
  theme (legend.title=element_blank(),
         legend.justification=c(0,0),
         legend.position=c(0.7,0.8),
         legend.key = element_blank()) 

grid.arrange(pTA,pTS,ncol=2, nrow=1,widths=c(1,1))
}

 

## Figure Appendice: Simulation TA and TS variation

Figure_Appendice <- function(data_simu) {
  
x1r <- range(data_simu$ts)
x1seq <- seq(x1r[1], x1r[2], length.out = 11)

x2r <- range(data_simu$ta)
x2seq <- seq(x2r[1], x2r[2], length.out = 11)

S_mat<-matrix(data_simu$S,length(x1seq), length(x2seq), dimnames=list(x1seq,x2seq))  # ta ncol, ts nrow
Lambda_mat<-matrix(data_simu$lambda,length(x1seq), length(x2seq), dimnames=list(x1seq,x2seq))  

nrz <- nrow(S_mat)
ncz <- ncol(S_mat)
# Create a function interpolating colors in the range of specified colors
jet.colors <- colorRampPalette( c("white", "blue") )
# Generate the desired number of colors from this palette
nbcol <- 120
color <- jet.colors(nbcol)

zfacet <- S_mat[-1, -1] + S_mat[-1, -ncz] + S_mat[-nrz, -1] + S_mat[-nrz, -ncz]
# Recode facet z-values into color indices
facetcol <- cut(zfacet, nbcol)

par(mfrow=c(1,2))

persp(x = x1seq, y = x2seq, z= S_mat, theta=310, phi=0, xlab="TA", ylab="TS", zlab="Endophyte prevalence",
      xlim=c(0,1), ylim=c(0,1), zlim=c(0,100), shade=0, nticks=5, col=color[facetcol], ticktype='simple',border="blue", axes=TRUE)
mtext("a)",3,0)

persp(x = x1seq, y = x2seq, z= Lambda_mat, theta=310, phi=0, xlab="TA", ylab="TS", zlab="Lambda",
      xlim=c(0,1), ylim=c(0,1), zlim=c(0.9,3.5), shade=0.75, nticks=5, col=color[facetcol], ticktype='simple',border="blue", axes=TRUE)
mtext("b)",3,0)

}