configfile: "config.yaml"
include: "helpers.py"
import pandas as pd

DATA = pd.read_csv(config["sampleCSVpath"])
SAMPLES = DATA["sample"].tolist()

rule run_facets_cnv:
	input: 
		expand(config["outputdir"] + "fitted/{sample}.snppile.csv.gz_fitted.csv", sample=SAMPLES)

rule run_snp_pile:
	input:
		tumorbam=lambda wildcards: getTumorBam(wildcards.sample)
	params:
		snp_flags=config["snppileup_parms"],
		vcffile=config["snpVCF"],
		normalbam=lambda wildcards: getNormalBAM(wildcards.sample),
		snppilepath=config["snppilepath"]
	threads: 10
	output:
		gzfile = config["outputdir"] + "{sample}.snppile.csv.gz"
	shell:
		"{params.snppilepath} {params.snp_flags} {params.vcffile} {output.gzfile} {params.normalbam} {input.tumorbam}"

rule run_facets_r:
	input:
		gzfile = config["outputdir"] + "{sample}.snppile.csv.gz"
	params:
		config["outputdir"] + "fitted/"
	output:
		outname=config["outputdir"] + "fitted/{sample}.snppile.csv.gz_fitted.csv"
		
	script:
		"/data/browna6/facets_snakemake/run_facets.R"


