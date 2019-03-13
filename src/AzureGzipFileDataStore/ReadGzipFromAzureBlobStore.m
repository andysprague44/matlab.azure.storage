function [data] = ReadGzipFromAzureBlobStore(Account,Container,BlobPath)
%READGZIPFROMAZUREBLOBSTORE Read a gzip file from Azure blob store.
%   This is a helper methoid that wraps the datastore call and does the required cleanup after
%   It reads a single gzip file and returns as a table. 
%   If the gzip contains multiple files all files within the zip are read as a single table
%
%   You must have run the following ahead of calling this function, to authenticate with Azure:
%       setenv MW_WASB_SECRET_KEY 'N21TNaN...=='
%   Replace the key with the value obtained from the Azure Portal (Storage Account -> Access Keys)
%
% INPUTS
%   Account: Azure storage account name 
%       e.g. 'ncxdatabricksdev01' 
%   Container: Blob store container, 
%       e.g. 'scada'
%   BlobPath: Full path to gzip file relative to container root (must be forwards slashes)
%       e.g. 'aemo/aemo_fwd_curve_20181125.csv.gz' 
%
% OUTPUTS
%   data: Table

%Get datastore
fds = GetAzureGzipFileDataStore(Account, Container, BlobPath);

%Read contetnts to a table
data = read(fds);

%Clean up the tmp dir used to extract gzip files
DeleteStoreTempDirectories(BlobPath);

end