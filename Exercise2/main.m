%% load image
im = im2double(imread('checkerboard_tunnel.png'));
imshow(im);
tic
[a ind] = MultiScaleHarris(im,5,1.5,1.2,0.06,0);
toc
x = find(ind);