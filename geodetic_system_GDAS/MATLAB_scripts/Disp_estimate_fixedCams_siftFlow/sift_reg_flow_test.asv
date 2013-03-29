%% computes flow for both left and right images and compares them

%Load images start-up
clear all
close all
clc

getd = @(p)path(p,path);
getd('toolbox_signal/');
getd('toolbox_general/');

direc = '.\expt_Feb27_Konica\';
% params
ext='.jpg';

l=1;

estList =[];
thList =[];
for k=1:6

for lp=0:2
    if lp==0
L = ['set_',num2str(k)];
R = ['set_',num2str(k),' (',num2str(1),')'];
    else

L = ['set_',num2str(k),' (',num2str(lp),')'];
R = ['set_',num2str(k),' (',num2str(lp+1),')'];        
    end
    

%

%read
maxSize=256;

i1_L=strcat(L,ext); 
i2_L=strcat(R,ext);

aL = (rgb2gray(imread(fullfile(direc,i1_L)))); 
aL = imresize(aL,[maxSize maxSize]);

bL = (rgb2gray(imread(fullfile(direc,i2_L))));
bL = imresize(bL,[maxSize maxSize]);

f=max(aL(:))/max(bL(:));
bL=bL*f;


%register



    image1 = aL;
    image2 = bL;
    
   
    [I1 I2]=Register_fm(image1,image2);
    [I3 I4]=register_corr(I1,I2);
    [im1 im2]=getSift(I3,I4);

    %figure, imshow(I3) ;
    %figure, imshow(I4) ;

    %figure, imshow(I3-I4) , title('before')

    %figure, imshow(im1-im2) , title('after sift')
    %
    
    flow = estimate_flow_interface(im1,im2,'classic+nl-fast'); %use for long dist    
    
    
    n=maxSize;
    if(isrgb(im1))
        im1 = rgb2gray(im1);
    end
    if(isrgb(im2))
        im2 = rgb2gray(im2);
    end
    
    im1 = imresize(im1,[n n]);
    im2 = imresize(im2,[n n]);
    flow = imresize(flow,[n n]);
    [Y,X] = meshgrid(1:n,1:n);
    X = clamp(X+flow(:,:,1),1,n);
    Y = clamp(Y+flow(:,:,2),1,n);
    % compute the first fame, translated along the flow
    im2_ = interp2( 1:n,1:n, im1, Y,X );
    
    %figure,imshow(im1);
    %figure,imshow(im2);
    %figure,imshow(im2_)
    
    quiverPlot(im1,flow);
    diffReal = abs(im2 - im1);
    diff = abs(im2_ - im2);
    rEst = (diff(:));
    r = (diffReal(:));
    rr = abs(rEst - r);
    est= mean(rr(:));
    threshold=0.08*max(rEst(:));
    
    estList = [estList est];
    thList = [thList threshold];
end


end

%%


origValsList = thList/0.08;
meanVal = mean(origValsList);
qualify = 0.05*meanVal;

%find those that qualify threshold;
D = (estList-qualify);
find(D<0);

figure,stem(estList);
line(1:size(estList,2),qualify*ones(size(estList,2),1)');
