import pandas as pd

def getPurity(wildcard):
	data = pd.read_csv(wildcard, nrows=1)
	return(float(data["Purity"]))

def getPatient(wildcard):
	return(DATA.loc[DATA['sample'] == wildcard,"patient"].values[0])

def getFileType(wildcard):
	return(DATA.loc[DATA['sample'] == wildcard,"cnv_file_type"].values[0])

def getTumorBam(wildcard):
	return(DATA.loc[DATA['sample'] == wildcard,"tumor_bam"].values[0])

def getNormalBAM(wildcard):
	return(DATA.loc[DATA['sample'] == wildcard,"normal_bam"].values[0])

def writePrettyVCFs(wildcard, phyloInput, sample):
    current = pd.read_csv(wildcard, sep = "\t")
    df1 = current[['CHROM','POS',"ID","REF","ALT","REF_TUMOR","ALT_TUMOR"]]
    #t_alt_count=83;t_ref_count=143
    df1['INFO'] = "t_alt_count=" + df1['ALT_TUMOR'].astype(str) + ";t_ref_count=" + df1['REF_TUMOR'].astype(str)
    df1 = df1.drop(['ALT_TUMOR', 'REF_TUMOR'], axis=1)
    df1["QUAL"] = "."
    df1["FILTER"] = "."
    df1 = df1.rename(columns={"CHROM": "#CHROM"})
    filePath = "{phyloInput}/{sample}.passed.somatic.snvs_indels_snpEff_on_exome_combined.vcf".format(sample=sample, phyloInput=phyloInput)
    df1 = df1[['#CHROM', 'POS', 'ID', 'REF', 'ALT',"QUAL","FILTER","INFO"]]

    df1.to_csv(filePath, sep = "\t", index=False)
    return(df1)

