function DeleteStoreTempDirectories(BlobPath)
%DELETESTORETEMPDIRECTORIES %Clean up the tmp dir used to extract gzip files

extractDir = getExtractDir(BlobPath);
if exist(extractDir, 'dir') 
    rmdir(extractDir, 's')
end 

end

