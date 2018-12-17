#load the library
library(facets)
library(data.table)

#argument should be the snppileup produced in the previous step and the desired output folder

set.seed(1234)
CVAL = 150
NHET = 2
#inputFilename = cmdArgs[1]
inputFilename = snakemake@input[[1]]
outputFilename = snakemake@output[[1]]
outputDir = snakemake@params[[1]]
dir.create(outputDir)
print(inputFilename)
print(paste0("Reading file: ", inputFilename))
#read the Snp matrix, feed a file path of the snp pileup 
rcmat = readSnpMatrix(inputFilename)
#check that the chrM isn't first
# if(rcmat$Chromosome[1] == "chrM"){
# 	rcmat$Chromosome <- gsub("chr","",rcmat$Chromosome)
# }
#perform the preprocessing
print(paste("preprocessing file",inputFilename))
xx = preProcSample(rcmat)
#process the sample
print(paste("Processing file",inputFilename))
print("cval procsample is ")
print(as.character(CVAL))
oo = procSample(xx,cval=CVAL)
print(oo$flags)
#we're using the emcncf2 function to allow the data to provide subclonal copy number calls as well
print(paste("Running fit",inputFilename))
fit = emcncf(oo, min.nhet = NHET)
#the data is store in cnfc
fit_table = as.data.table(fit$cncf)
fit_table[,"Purity" := fit$purity]
fit_table[,"Ploidy" := fit$ploidy]

fwrite(fit_table, outputFilename)
print(paste(inputFilename, "written"))

print("Drawing diagnostic plots")

png(paste0(outputFilename,CVAL, NHET, "_fitted.png"), width = 3.25, height = 3.25, units = "in", res=1200, pointsize = 4)
par(mar = c(5, 5, 2, 2), xaxs = "i", yaxs = "i",cex.axis = 2,cex.lab  = 2)
print("Plotting Sample")
plotSample(x=oo,emfit=fit)

while(!is.null(dev.list())){dev.off()}
print("Ploting Spider")
png(paste0(outputFilename, CVAL, NHET, "_diagnostic.png"), width = 3.25, height = 3.25, units = "in", res=1200, pointsize = 4)
    par(mar = c(5, 5, 2, 2), xaxs = "i", yaxs = "i",cex.axis = 2,cex.lab  = 2)
logRlogORspider(oo$out,oo$dipLogR)

while(!is.null(dev.list())){dev.off()}


print(paste("All done with sample:",inputFilename))
