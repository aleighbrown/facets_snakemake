# Facets Snakemake
Pipeline for running the FACETS copy number caller using Snakemake https://snakemake.readthedocs.io/en/stable/

Requires the installation of FACETS R library. 

Simple SNAKEMAKE pipeline for running the FACETS copy number https://github.com/mskcc/facets
caller on a list of matched tumor/normal bams

Before running, please make sure you have downloaded and compiled the snp-pileup code that FACETS requires, it's available on the authors GitHub here:https://github.com/mskcc/facets/tree/master/inst/extcode

Download the "snp-pileup.cpp" and "snp-pileup.h" files into the same folder as the facets.snakefile. 

Instructions below from the FACETS github on compilation:

Installation
------------
First, HTSlib must be installed on your system. To do that, download it from
http://www.htslib.org/download/ and follow the "Building and installing" 
instructions on that page. If installed systemwide (in /usr/local/lib) using
"make install" ensure that the libraries are available with the command 
"sudo ldconfig" (only needs to be run once).

This code can be compiled using 

     g++ -std=c++11 snp-pileup.cpp -lhts -o snp-pileup

when htslib is available systemwide, or

     g++ -std=c++11 -I/path/htslib/include snp-pileup.cpp \\
     -L/path/htslib/lib -lhts -Wl,-rpath=/path/htslib/lib -o snp-pileup 

when it is installed locally and path is the location where it is available.
"

Samtools has HTSlib, so if your machine has a working version of samtools, you have HTSlib. Please make sure samtools is available systemwide before you compile. 


The only files which need to be edited by the end user are the "config.yaml" and the "samples.csv" files. 

The samples file needs a header, please fill in according to the provided sample here. 

Please cite original papers.
