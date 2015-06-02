Demographic Model of a grass population with symbiotic and non symbiotic plants

This repository contains all the code used in the manuscript:

Title: "Interplay between endophyte prevalence, effects and transmission: insights from a natural grass population"
Authors: Anaïs Gibert, Danièle Magda, Laurent Hazard,
Year of publication:
doi:

Synopsis of the study

Two main mechanisms are thought to affect the prevalence of endophyte-grass symbiosis in host populations: the mode of endophyte transmission, and the fitness differential between symbiotic and non-symbiotic plants. These mechanisms have mostly been studied in synthetic grass populations. If we are to improve our understanding of the ecological and evolutionary dynamics of such symbioses, we now need to determine the combinations of mechanisms actually operate in the wild, in populations shaped by evolutionary history.
We used a demographic population modeling approach to identify the mechanisms operating in a natural stand of an intermediate population (i.e. 50% of plants symbiotic) of the native grass Festuca eskia. We recorded demographic data in the wild over a period of three years, with manipulation of the soil resources for half the population. We developed two stage-structured matrix population models. The first model concerned either symbiotic or non-symbiotic plants. The second model included both symbiotic and non-symbiotic plants and took endophyte transmission rates into account. 
According to our models, symbiotic had a higher population growth rate than non-symbiotic plants, but endophyte prevalence was about 58%. Endophyte transmission rates were about 0.67 or 0.87, depending on the growth stage considered. In the presence of nutrient supplementation, population growth rates were still significantly higher for symbiotic than for non-symbiotic plants, but endophyte prevalence fell to 0%. At vertical transmission rates below 0.10-0.20, no symbiosis was observed. 
Our models showed that a positive benefit of the endophyte and vertical transmission rates of about 0.6 would lead to the coexistence of symbiotic and non-symbiotic F. eskia plants. These two mechanisms can be independent over short time scales following an environmental change.


Running the code

Here we present the data and the code to perform the meta-analyses and all the figures from the paper. Once you have the required packages installed, run this command:

source("analysis.R")
Figures will be output to a directory output.
All the data fused in the analyses and included as supplementary material with the paper.

List of files available and explanation

data/md.csv: raw data, needed to run the analyses
data/md_simu: raw data from ULM simulations
R directory containing functions used in analysis
R/data.processing: main script to clean the dataset, calculate the parameter, and create the matrices used in ULM
R/statistical_test.R: main script to run all the tests used in the ms
R/plots. R: main script to run all the plots
ULM directory containing files used in ULM (Unified Life Model) software (see Ferrière et al 1996, Legendre and Clobert 1995)
analysis.R: main script to run the analyses and generate all the figures.


Contributors
Anais Gibert

Ferrière R, Sarrazin F, Legendre S, Baron JP. Matrix population models applied to viability analysis and conservation : theory and practice using the ULM software. Acta Oecologica. Elsevier; 1996;17(6):629–56.
Legendre S, Clobert J. ULM, a software for conservation and evolutionary biologists. Journal of Applied Statistics. 1995 Nov;22(5-6):817–34.
