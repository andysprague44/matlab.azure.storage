function [extractDir] = getExtractDir(gzipfilename)
%GETEXTRACTDIR get path to temp directory to use for gzip extracting
    [~,name,~] = fileparts(gzipfilename);
    extractDir = fullfile(tempdir, 'azureextract', name);
end