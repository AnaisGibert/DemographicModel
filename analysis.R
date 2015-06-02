library(ade4, quietly=TRUE)
library(ggplot2, quietly=TRUE)
library(MASS, quietly=TRUE)
library(gridExtra, quietly=TRUE)
library(sm)
library(grid,quietly=TRUE)
library(MAc,quietly=TRUE)
library(rgl)
library(clusterSim)
library(popbio)
library(reshape)
library(ggplot2)
library(popbio)
library(quadprog)
library(scatterplot3d)

data<-read.csv("data/md.csv", sep=';', dec=",", colClasses = c(rep("factor",7),rep("numeric",14)), na.strings = TRUE)

source("R/data.processing.R")
source("R/plots.R")


## Figure 1: from illustrator


## Figure 2
pdf("output/Fig2.pdf",height=5, width=5)
figure_2(datay1.2)
dev.off()

## Figure 3
pdf("output/Fig3.pdf",height=5, width=5)
figure_3
dev.off()

## Parameters (mean, sd and se)
param

## ALL the Matrix (sd and mean) used in ULM
matrixNSC 
matrixNSCsd 
matrixNSF
matrixNSFsd
matrixSC
matrixSCsd 
matrixSF 
matrixSFsd

## Figure 4

pdf("output/Fig4.pdf",height=5, width=10)
Figure_4(data_simu_TA, data_simu_TS)
dev.off()

## Figure Appendice
pdf("output/FigA1.pdf",height=5, width=10)
Figure_Appendice(data_simu)
dev.off()