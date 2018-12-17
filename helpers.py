import pandas as pd

def getPatient(wildcard):
	return(DATA.loc[DATA['sample'] == wildcard,"patient"].values[0])

def getFileType(wildcard):
	return(DATA.loc[DATA['sample'] == wildcard,"cnv_file_type"].values[0])

def getTumorBam(wildcard):
	return(DATA.loc[DATA['sample'] == wildcard,"tumor_bam"].values[0])

def getNormalBAM(wildcard):
	return(DATA.loc[DATA['sample'] == wildcard,"normal_bam"].values[0])
