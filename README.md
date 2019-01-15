# facets_snakemake
Pipeline for running the FACETS copy number caller using Snakemake https://snakemake.readthedocs.io/en/stable/

Simple SNAKEMAKE pipeline for running the FACETS copy number https://github.com/mskcc/facets
caller on a list of matched tumor/normal bams


Requires the snp-pileup code from https://github.com/mskcc/facets/tree/master/inst/extcode
be compiled according to instructions and in the same folder as the facets.snakefile

To do so, save the "snp-pileup.cpp" and "snp-pileup.h" files into the same folder as the facets.snakefile. 

Instructions below from the FACETS github:

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

a working version of samtools should have the HTSlib installed, if your machine has samtools, you have HTSlib

Please cite original papers.
