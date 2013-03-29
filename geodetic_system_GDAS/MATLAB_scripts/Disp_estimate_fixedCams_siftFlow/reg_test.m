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

list=[];
for k=1:6


L = ['set_',num2str(k)];
R = ['set_',num2str(k),' (',num2str(1),')'];
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

    %figure, imshow(aL) ;
    %figure, imshow(bL) ;

    %figure, imshow(aL-bL) , title('before')

    %figure, imshow(I3-I4) , title('both')
    %
    energy0 = (abs(aL-bL));
    energy0 = sum(energy0(:));
    
    energy = abs(I3-I4);
    energy = sum(energy(:));
    
    
    
    
    eRatio = energy/energy0;
    list = [list ; [eRatio]];
    
end


    