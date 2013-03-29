%% computes flow for both left and right images and compares them

%Load images start-up
clear all
close all
clc

getd = @(p)path(p,path);
getd('toolbox_signal/');
getd('toolbox_general/');


directory.floss1='.\expt_Feb22_Konica\';
directory.gatta ='.\expt_Feb25_Konica\';

%direc = directory.floss1;
direc = directory.gatta;

ext='.jpg';


    r1=[220 100 100 125];
    r2=[200 75 200 150];
    r3=[220 75 200 150];
    r4=[200 80 250 150];
    r5=[170 80 200 150];
    r6=[170 180 200 220];
    r7=[170 180 200 220];
    r8=[180 180 150 250];
    rect=[r1;r2;r3;r4;r5;r6;r7;r8];
    
complete_alp = [0;30;45;60;90;120;135;150;180]; % angles between camera planes
alp = [0;30;45;60;90;120]; % angles between camera planes
actual = deg2rad(180-alp);

% image planes are tangential to the sphere surrounding the object

%%% process for the right image , changing angles

global showImage;

showImage=0; % dont show

emList=[];
for counter = 1:size(alp)

    %r=rect(counter,:);
    path1 = strcat('set_',num2str(counter),' (1)');
    path2 = strcat('set_',num2str(counter),' (2)');
    %[vR,im1,im2]=readRegFlow(path1,path2,ext,direc,r); 
    [im1,im2]=readImages(path1,path2,ext,direc);
    [im1,im2]=registerImages(im1,im2); 
    flow = siftFlow(im1,im2);
    if(showImage~=0)
        quiverPlot((im1+im2),flow)
    end
    [wu wv eM] = distanceEstimate(flow,im1,im2);
    
    disp('estimated --> ');
    disp(eM);
    
    emList = [emList ; eM];  % add to list
    %{
    sine=sin(deg2rad(actual(counter)));
    cosine=cos(deg2rad(actual(counter)));
    vel=vR(:,:,1);
    yvel=vR(:,:,2);
    dx = ((max(xvel(:))-mean(xvel(:)))/var(xvel(:)))*cosine;
    dz = ((max(xvel(:))-mean(xvel(:)))/var(xvel(:)))*sine;
    dy = (max(yvel(:))-mean(yvel(:)))/var(yvel(:));
    list_DY = [list_DY dy]; % for averaging the y disp since it is 
                          %in a common plane
    list_DZ = [list_DZ dz];
    list_DX = [list_DX dx]; 
    %}
    
end

%%


expectedVals.floss = [17 0 0.5];  %expected x,y,z in pixels
expectedVals.gatta = [6 0 9]; %xdisp and zDisp are different weight due to dist from screen

experimentXYZ = expectedVals.gatta;
%experimentXYZ = expectedVals.floss;

expectedDx=experimentXYZ(1);
expectedDy=experimentXYZ(2);
expectedDz=experimentXYZ(3);

%res=256;
%disp=1.5; % inches measured displacement
%ObjDist = 16; %  inches - 2 tiles away
%camRation=4/1; %CCD length to cam width (pin-hole model)
%expectedDx=(res*disp)/(ObjDist*camRation); % for chair in NS-SS area

xDisp = (emList(:,1)).*cos(actual); %estimation of x displacement
zDisp = (emList(:,1)).*sin(actual); %estimation of y displacement
yDisp = (emList(:,2));



errorX = abs(abs(expectedDx) - abs(xDisp));
errorY = abs(abs(expectedDy) - abs(yDisp));
errorZ = abs(abs(expectedDz) - abs(zDisp));

figure, subplot(3,1,1), plot(alp,errorX); title('error in DX');
subplot(3,1,2), plot(alp,errorY); ylim([0 10]); title('error in DY'); 
subplot(3,1,3), plot(alp,errorZ);title('error in DZ');




%%
cosine=cos(actual);
sine= sin(actual);

figure;
plot(alp,abs(abs(abs(cosine.*xDisp)-expectedDx)));
figure;
plot(alp,abs(abs(xDisp.*sin(actual).*cos(atan2(yDisp,xDisp)))-expectedDz));



%cos(atan2(yDisp,xDisp) is the component direction of the velocity vector
























%%

zDisp = xDisp.*sine;
xDisp = abs(cosine.*xDisp); % projection onto reference frame
yDisp = abs(mean(yDisp)); % all share a common plane


%%

%list analysis

close all


%objD = 60;
%camRatio = 4;
%pxToMetre = camRatio*objD/maxSize;

list_DX
list_DY
list_DZ

expectedDx=11.8; % for chair in NS-SS area
expectedDz=5;

realDX = 0; % 2 metre movt
% not comparing DY movement is along a sphere
realDZ = 2; % 0 m movt

errDX = abs(list_DX)-expectedDx;
errDZ = abs(list_DZ)-expectedDz;

avgErr = errDX;
figure,
plot(alp,abs(errDX)); 

figure,
plot(alp,abs(errDZ)); 


