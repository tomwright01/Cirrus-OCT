function [ results ] = processResolutions( data, type, resolutions, debug )
%processResolutions Calculates summary statistics for groups of pixels
%defined by resolutions
%   INPUTS 
%       data - an oct dataset such as that generated by Cirrus_OCT_IRL()
%       type - statistic to return (mean or var)
%       resolutions - vector of resolutions
%       debug - boolean, prints progress if true
%   OUTPUTS
%       results - cell array of length(resolutions)
%           each cell is a vector of summary statistic

% check for valid inputs
type=lower(type);
if ~any(type(1) == ['m' 'v'])
    error('processResolutions.m','Invalid type specified');
end
if ~isa(data,'double')
    error('processResolutions.m','Invalid data passed');
end
if ~debug
    debug=false;
end

results = cell(length(resolutions),1);
for iRes = 1:length(resolutions)
    resolution = resolutions(iRes);
    if debug
        sprintf('Processing resolution: %i - %i of %i', ...
            resolution, iRes, length(resolutions))
    end
    sampleArray = reshapeArray(data,resolution);
    if type(1) == 'm'
        results{iRes} = nanvar(sampleArray);
    else
        results{iRes} = nanmean(sampleArray);
    end
end


end

