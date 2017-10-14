I = imread('img_smoothing/cat.bmp');
%I = rgb2gray(I);
I = im2double(I);

n = 30;

start = tic;
GF = guidedfilter(I, I, n, 0.01);
GFTime = toc(start);

start = tic;
h = ones(n, n) / (n * n);
Avg = imfilter(I, h);
AvgTime = toc(start);

start = tic;
Med = medfilt2(I, [n n]);
MedTime = toc(start);

% figure
% imshow(I)
% figure
% imshow(GF)
% figure
% imshow(Avg)
% figure
% imshow(Med)