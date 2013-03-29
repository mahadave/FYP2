function [ sifted_im1,sifted_im2 ] = getSift( im1,im2 )
%GETSIFT Summary of this function goes here
%   Detailed explanation goes here

    %im1=imresize(imfilter(im1,fspecial('gaussian',7,1.),'same','replicate'),0.5,'bicubic');
    %im2=imresize(imfilter(im2,fspecial('gaussian',7,1.),'same','replicate'),0.5,'bicubic');

    im1=im2double(im1);
    im2=im2double(im2);


    % Step 2. Compute the dense SIFT image

    % patchsize is half of the window size for computing SIFT
    % gridspacing is the sampling precision

    patchsize=8;
    gridspacing=1;

    Sift1=dense_sift(im1,patchsize,gridspacing);
    Sift2=dense_sift(im2,patchsize,gridspacing);

    % visualize the SIFT image
    %figure;imshow(showColorSIFT(Sift1));title('SIFT image 1');
    %figure;imshow(showColorSIFT(Sift2));title('SIFT image 2');

    sifted_im1= showColorSIFT(Sift1);
    sifted_im2= showColorSIFT(Sift2);

end

