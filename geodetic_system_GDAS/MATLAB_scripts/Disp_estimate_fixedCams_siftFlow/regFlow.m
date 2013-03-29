function [ uv, a, b ,estimatedMotion] = regFlow( image1,image2)
%READREGFLOW Summary of this function goes here
%   Inputs: path1 (filename for image at t=0) , path2 (filename for image
%   at t=tk) , ext (e.g. '.jpg') , direc (folder path to image files)
%
%   Outputs: a (image 1) , b(image 2) , v (vector filed from optical flow)

    
scale_down=256;
    
    
    
    
    [I1 I2]=Register_fm(image1,image2);
    [I3 I4]=register_corr(I1,I2);
    
    %Let it FLOW---------------------------------------------->
    
    n=scale_down;
    a = double(imresize(I3,[n n]));
    b = double(imresize(I4,[n n]));
    
     
    uv = estimate_flow_interface(a,b,'classic+nl-fast');
    
    
tolerance=0.05; %threshold to be decided based on the minimum noticable change
[worthyU worthyV] = quiverPlot(uv,(a+b)./2,256,tolerance);

% store the values of worthy points in list

%
listU=[];
listV=[];

mListU=0;
mListV=0;

for i=1:size(worthyU,1)
    listU = [listU; [uv(worthyU(i,1),worthyU(i,2),1) uv(worthyU(i,1),worthyU(i,2),2)]];
end
%

if(size(worthyU,1)~=0)
    kia=listU(:,1);
    mListU = max(kia(:));%mean(listU(:,1)); % we are interested in the rows of this
end

for i=1:size(worthyV,1)
    listV = [listV; [uv(worthyV(i,1),worthyV(i,2),1) uv(worthyV(i,1),worthyV(i,2),2)]]; 
end

if(size(worthyV,1)~=0)
    kia=listV(:,2);
    mListV = max(kia(:));%mean(listV(:,2)); % we are interested in the cols of this
end
  


estimatedMotion = [mListU mListV];
disp(['estimated motion ' ,num2str(estimatedMotion)]);

%    quiverPlot(uv,a,n);

    

    
end

