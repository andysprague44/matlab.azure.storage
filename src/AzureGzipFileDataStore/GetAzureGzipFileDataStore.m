function [AzureGzipFileDataStore] = GetAzureGzipFileDataStore(Account,Container,BlobPath)
%GETAZUREBLOBSTOREGZIPFILESTORE Get a filestore that can read gzip files from blobstore
%
%   Can access a single gzip file or specify a folder to see all gzip files (and choose one/many to read)
%   If there are multiple files within a single gzip they are read into a single table
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
%       e.g. 'aemo/aemo_fwd_curve_20181125.csv.gz' for single file
%       e.g. 'aemo/' to get access to  multiple files

%Create a custom fileDatastore for gzip files in Azure blob store
Location=['wasbs://', Container, '@', Account, '.blob.core.windows.net/', BlobPath];
AzureGzipFileDataStore = fileDatastore(Location,'ReadFcn',@readgzip,'FileExtensions',{'.gz'});

end

function data = readgzip(gzipfilename)
%READGZIP read a gzip file to a table, used as custom ReadFcn for datastore
%   Must contain tabular data e.g. '.csv.gz'
    extractDir = getExtractDir(gzipfilename);
    gunzip(gzipfilename, extractDir);
    ds = tabularTextDatastore(extractDir,'TreatAsMissing','NA');
    data = readall(ds); 
end
