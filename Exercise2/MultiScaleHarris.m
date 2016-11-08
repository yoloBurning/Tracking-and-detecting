function [cim ind] = MultiScaleHarris(im,n,s0,k,alpha,t)
% -------input--------
%im : input image
% n  : scale level
% s0 : initial scale value---sigma_0
% k: scale step
% alpha: constant factor
% t : threshold
% ------Assumption------- 
% sigma_D = 1
% ------output--------
% x, y: localtion of the corner points
%% build scale-space

dx = [-1 0 1;-1 0 1;-1 0 1];
dy =dx';

Ix = conv2(im,dx,'same');
Iy = conv2(im,dy,'same');

sz = size(im);
cim = ones(sz(1),sz(2),n);
ind = ones(sz(1),sz(2),n);

for i = 1:n
    sigma = k^i * s0;
    
    g= fspecial('gaussian',max(1,fix(6*sigma)),sigma);

    %Compute the Lx, Ly, LxLy
    Ix2 = conv2(Ix.^2, g, 'same');
    Iy2 = conv2(Iy.^2, g, 'same');
    Ixy = conv2(Ix.*Iy,g, 'same');
    a = (Ix2.*Iy2 - Ixy .^2) -alpha*(Ix2 +Iy2).^2;

    cim(:,:,i) = a;
    
    %find the element who are bigger than the threshold
    ind(:,:,i) = cim(:,:,i)>t;
%     [x y] = find(out);


end

end