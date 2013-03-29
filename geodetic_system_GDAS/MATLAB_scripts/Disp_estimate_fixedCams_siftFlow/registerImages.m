function [ a,b ] = registerImages( image1,image2,n)
%READREGFLOW Summary of this function goes here
%   Inputs: path1 (filename for image at t=0) , path2 (filename for image
%   at t=tk) , ext (e.g. '.jpg') , direc (folder path to image files)
%
%   Outputs: a (image 1) , b(image 2) , v (vector filed from optical flow)

    
    [I1 I2]=Register_fm(image1,image2);
    [I3 I4]=register_corr(I1,I2);
    
    %Let it FLOW---------------------------------------------->
    
    n=size(image1,1);
    a = double(imresize(I3,[n n]));
    b = double(imresize(I4,[n n]));
    
end

