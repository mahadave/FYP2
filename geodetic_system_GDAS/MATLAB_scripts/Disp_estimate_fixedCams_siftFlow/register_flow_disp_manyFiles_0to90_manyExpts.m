%% computes flow for both left and right images and compares them

%Load images start-up
clear all
close all
clc

getd = @(p)path(p,path);
getd('toolbox_signal/');
getd('toolbox_general/');

direc = '.\expt_Feb22_Konica\';
ext='.jpg';

list_DX =[];
list_DY =[];
list_DZ =[];


    r1=[220 100 100 125];
    r2=[200 75 200 150];
    r3=[220 75 200 150];
    r4=[200 80 250 150];
    r5=[170 80 200 150];
    r6=[170 180 200 220];
    r7=[170 180 200 220];
    r8=[180 180 150 250];
    rect=[r1;r2;r3;r4;r5;r6;r7;r8];
    
alp = [0;30;45;60;90;120;135;150;180]; % angles between camera planes
alp = [0;30;45;60;90]; % angles between camera planes
actual = deg2rad(180-alp);

% image planes are tangential to the sphere surrounding the object

%%% process for the right image , changing angles

emList=[];
for counter = 1:size(alp)

    %r=rect(counter,:);
    path1 = strcat('set',num2str(counter),'.1');
    path2 = strcat('set',num2str(counter),'.2');
    %[vR,im1,im2]=readRegFlow(path1,path2,ext,direc,r); 
    [vR,im1,im2,eM]=readRegFlow(path1,path2,ext,direc); 
    disp('estimated --> ')
    disp(eM)
    
    emList = [emList ; eM]; 
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
res=256;
disp=1.5; % inches measured displacement
ObjDist = 16; %  inches - 2 tiles away
camRation=4/1; %CCD length to cam width (pin-hole model)
expectedDx=(res*disp)/(ObjDist*camRation); % for chair in NS-SS area
expectedDz=5;
expectedDz=0.05;

xDisp = (emList(:,1));
yDisp = (emList(:,2));

cosine=cos(actual);
sine= sin(actual);

plot(alp,abs(abs(abs(cosine.*xDisp)-expectedDx)));
plot(alp,abs(abs(abs(cosine.*xDisp)-expectedDx)));
%plot(alp,abs(abs(xDisp.*sin(actual).*cos(atan2(yDisp,xDisp)))-expectedDz));
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


