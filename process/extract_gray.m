% Example: If X = [1 2 3; 3 3 6; 4 6 8; 4 7 7];
% then mean(X,1) is [3 4.5 6] and mean(X,2) is [2; 4; 6; 6]

close all;clc;clear;

% Read picture
filepath = 'graygroundtruth.jpg';
% filepath = 'graycapture.jpg';

pic = imread(filepath, 'jpg');
pic  = double(pic);
    % imshow(pic);

% Caluculate mean in vertical
vertical_mean_vec = mean( pic - mean(mean(pic)) ) ;
    figure;
    plot(vertical_mean_vec);

% FFT
freq_domain = fft(vertical_mean_vec);
    
% % Half
% freq_domain = freq_domain(1:ceil(length(freq_domain) / 2));
    figure;
    plot(abs(freq_domain));
    
base = find_base(freq_domain);
period = 1/base

a = cos(2 * pi / period * ([0:length(freq_domain)-1])) 


