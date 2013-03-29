%% computes flow for both left and right images and compares them

%Load images start-up
clear all
close all
clc

getd = @(p)path(p,path);
getd('toolbox_signal/');
getd('toolbox_general/');

direc = '.\expt_Feb18_Konica3\';
% params
ext='.jpg';

for l=1:1
k=1;
img1_L=strcat('set',num2str(l),'.',num2str(k));
img2_L=strcat('set',num2str(l),'.',num2str(k+1)); % compute L-L flow , 
% then R-R flow


img1_R = 'set3.1';
img2_R = 'set3.2';
img1_L = 'set3.1';
img2_L = 'set3.2';

%

%read
maxSize=500;

i1_L=strcat(img1_L,ext); 
i2_L=strcat(img2_L,ext);

i1_R=strcat(img1_R,ext);
i2_R=strcat(img2_R,ext);

aL = (rgb2gray(imread(fullfile(direc,i1_L)))); 
aL = imresize(aL,[maxSize maxSize]);

bL = (rgb2gray(imread(fullfile(direc,i2_L))));
bL = imresize(bL,[maxSize maxSize]);

aR = (rgb2gray(imread(fullfile(direc,i1_R))));
aR = imresize(aR,[maxSize maxSize]);

bR = (rgb2gray(imread(fullfile(direc,i2_R))));
bR = imresize(bR,[maxSize maxSize]);

f=max(aL(:))/max(bL(:));
bL=bL*f;


%aL=imcrop(aL,[150 200 100 100]);
%bL=imcrop(bL,[150 200 100 100]);

%register



    image1 = aL;
    image2 = bL;
    
   
    [I1 I2]=Register_fm(image1,image2);
    [I3 I4]=register_corr(I1,I2);
    
%
    %figure, imshow(I3-I4) , title('both')

%
%Let it FLOW---------------------------------------------->
%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%

    n = 200;
    a = double(imresize(I3,[n n]));
    b = double(imresize(I4,[n n]));
    
    uv = estimate_flow_interface(b,a,'classic+nl-fast');
    
    quiverPlot(uv,a,n);
    
end
%%
 
[Y,X] = meshgrid(1:n,1:n);
X = clamp(X+v(:,:,1),1,n);
Y = clamp(Y+v(:,:,2),1,n);
% compute the first fame, translated along the flow
Ms = interp2( 1:n,1:n, a, Y,X );
imageplot(Ms)
%imageplot(b)
%%

close all


objD = 80;
camRatio = 4;
pxToMetre = camRatio*objD/maxSize;

vLm = vL*pxToMetre;
vRm = vR*pxToMetre;



f= 5;
t = 1;
theta = deg2rad(30);

DX = abs(vLm(:,:,2)-vRm(:,:,2)*cos(theta)); 
DY = abs(vLm(:,:,1)-vRm(:,:,1));
DZ = abs(vRm(:,:,2)*sin(theta));


%Z = (f*t)./d; %http://homepages.inf.ed.ac.uk/rbf/CVonline/LOCAL_COPIES/OWENS/LECT11/node4.html

%convert to metres





%% convert to black and white to keep peaks
close all;

avgL = ((vL(:,:,1)+vL(:,:,2))/2);
avgR = ((vR(:,:,1)+vR(:,:,2))/2);

L = ((abs(avgL)*20));
R = ((abs(avgR)*20));
L_bw = im2bw(((avgL)),0.6);
R_bw = im2bw(((avgR)),0.6);

figure
imageplot(L,'',1,2,1);
imageplot(R,'',1,2,2);

figure
imageplot(L_bw,'',1,2,1);
imageplot(R_bw,'',1,2,2);


cut = 0.1*(size(L_bw,1)+size(R_bw,1) + size(L_bw,2) + size(R_bw,2))/4;
L_bw_cr=imcrop(L_bw,[cut cut (size(L_bw,2)) (size(L_bw,1)-2*cut)]);
R_bw_cr=imcrop(R_bw,[cut cut (size(R_bw,2)) (size(R_bw,1)-2*cut)]);
%L_bw_cr=imcrop(L_bw,[10 1 200 160]); %xmin,ymin,w,h
%%R_bw=imcrop(R_bw,[cut cut (size(R_bw,1)-cut) (size(R_bw,2)-cut)]);

figure

imageplot(L_bw_cr,'',1,2,1);
imageplot(R_bw_cr,'',1,2,2);

%change in Left and right images (intra change) image
% split about average point
L_avg=[];
R_avg=[];
for times = 1:2
    
    im=[];
    if times==1
        im = L_bw_cr;
    else
        im = R_bw_cr;
    end
    
    [r c] = find(im==1); % locate peak indices
        
    if times==1
        L_dx  = max(r)-min(r); % do for all epipolar lines -- to code later
    else
        R_dx  = max(r)-min(r);
    end
end

%D = normxcorr2(L_bw,R_bw);


%% find disparity between peaks along 

%segmentation
L_avg=[];
R_avg=[];
for times = 1:2
    
    im=[];
    if times==1
        im = L_bw_cr;
    else
        im = R_bw_cr;
    end
    
[r c] = find(im==1); % locate peak indices
r_avg = mean(r);
c_avg = mean(c);

    if times==1
        L_avg = [r_avg c_avg];
    else
        R_avg = [r_avg c_avg];
    end
end

DY = L_avg(1)-R_avg(1); % disparity in X direction
DX = L_avg(2)-R_avg(2); % disparity in Y direction

f= 5;
t = 1;
d = DX;
Z = f*t/d; %http://homepages.inf.ed.ac.uk/rbf/CVonline/LOCAL_COPIES/OWENS/LECT11/node4.html

%% Transform to real world change




