function data = LoadMonostaticSignatureFile(filename)

fid = fopen(filename, 'r');
tag = fread(fid, 1, 'uchar');

data.observation_type = fread(fid, 1, 'uchar');
data.polarization = fread(fid, 1, 'uchar');
data.coordinate_type = fread(fid, 1, 'uchar');

data.numIncEl = fread(fid, 1, 'int32');
data.numIncAz = fread(fid, 1, 'int32');

data.numObsEl = fread(fid, 1, 'int32');
data.numObsAz = fread(fid, 1, 'int32');

data.numFreq = fread(fid, 1, 'int32');
data.incElStart = fread(fid, 1, 'double');
data.incElStop = fread(fid, 1, 'double');
data.incAzStart = fread(fid, 1, 'double');
data.incAzStop = fread(fid, 1, 'double');

obsElStart = fread(fid, 1, 'double');
obsElStop = fread(fid, 1, 'double');
obsAzStart = fread(fid, 1, 'double');
obsAzStop = fread(fid, 1, 'double');

data.freqStart = 1.0e9*fread(fid, 1, 'double');
data.freqStop = 1.0e9*fread(fid, 1, 'double');

fread(fid, 1, 'double');
fread(fid, 1, 'double');
fread(fid, 1, 'uchar');
 
temp = fread(fid, inf, 'double');

fclose(fid);

if(data.coordinate_type == 0)
    data.theta = linspace(data.incElStart, data.incElStop, data.numIncEl);
    data.phi = linspace(data.incAzStart, data.incAzStop, data.numIncAz);
else
    data.el = linspace(data.incElStart, data.incElStop, data.numIncEl);
    data.az = linspace(data.incAzStart, data.incAzStop, data.numIncAz);
end 

data.freq = linspace(data.freqStart, data.freqStop, data.numFreq);

vv = temp(1:8:end) + 1i*temp(2:8:end);
hv = temp(3:8:end) + 1i*temp(4:8:end);
vh = temp(5:8:end) + 1i*temp(6:8:end);
hh = temp(7:8:end) + 1i*temp(8:8:end);
 
clear temp
    
data.vv = squeeze(reshape(vv, data.numFreq, data.numIncAz, data.numIncEl));
data.hv = squeeze(reshape(hv, data.numFreq, data.numIncAz, data.numIncEl));
data.vh = squeeze(reshape(vh, data.numFreq, data.numIncAz, data.numIncEl));
data.hh = squeeze(reshape(hh, data.numFreq, data.numIncAz, data.numIncEl));

return