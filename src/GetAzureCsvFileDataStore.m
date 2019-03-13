function [AzureCsvFileDataStore] = GetAzureCsvFileDataStore(Account,Container,BlobPath)
%GETAZUREBLOBSTOREGZIPFILESTORE Get a filestore that can read csv files from blobstore
%
%   Can access a single file or specify a folder to view files, and load all files into a single table
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
%       e.g. 'aemo/aemo_fwd_curve_20181125.csv' for single file
%       e.g. 'aemo/' to get access to  multiple files

%Create a custom fileDatastore for files in Azure blob store
Location=['wasbs://', Container, '@', Account, '.blob.core.windows.net/', BlobPath];
AzureCsvFileDataStore = fileDatastore(Location,'ReadFcn',@load,'FileExtensions','.csv');

end

function data = load(filename)
%READGZIP read a csv file to a table, used as custom ReadFcn for datastore
    ds = tabularTextDatastore(filename,'TreatAsMissing','NA');
    data = readall(ds); 
end