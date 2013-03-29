%% computes flow for both left and right images and compares them

%Load images start-up
clear all
close all
clc

getd = @(p)path(p,path);
getd('toolbox_signal/');
getd('toolbox_general/');

global showImage;
showImage=1; % dont show

directory = {'.\expt_Feb22_Konica\','.\expt_Feb25_Konica\','.\expt_Feb27_Konica\'};
%indices
floss1=1; %short
gatta=2; % short
rachit=3; % long


for dirIndex=3:3

    direc = directory(dirIndex);
    direc=direc{1};

    ext='.jpg';
    
    accuracyRequired=0.1; % 5cm
    craterRadius=65; % metres
    zoom=1; % 1x zoom
    res = findResolution(accuracyRequired,craterRadius,zoom); %resolution


    alp = [0;30;45;60;90;120]; % angles between camera planes
    
    actual = deg2rad(180-alp);

    % image planes are tangential to the sphere surrounding the object

    %%% process for the right image , changing angles


    emList=[];
    for counter = 1:size(alp,1)

        disp(counter);
        %r=rect(counter,:);
        
        if(dirIndex==1 || dirIndex==3)
            post1=' (2)';
            post2=' (3)'; % max limit -- for each pair the expectedDel 
                          % changes --- loop for this
            
            post1=' (2)';
            post2=' (3)'; % max limit 
        elseif(dirIndex==2)
            post1=' (1)';
            post2=' (2)';
        end
        
        path1 = strcat('set_',num2str(counter),post1);
        path2 = strcat('set_',num2str(counter),post2);
        %[vR,im1,im2]=readRegFlow(path1,path2,ext,direc,r); 
        [im1,im2]=readImages(path1,path2,ext,direc,res);
      
        
        [im1,im2]=registerImages(im1,im2); 
        
        %im1 = imcrop(im1,[100 100 100 50] );
        %im2 = imcrop(im2,[100 100 100 50] );
        
        if dirIndex==3
            flow = estimate_flow_interface(im1,im2,'classic+nl-fast'); %use for long dist
        else
            flow = siftFlow(im1,im2);
        end
        
        if(showImage~=0)
            quiverPlot((im1+im2),flow)
        end
        
        
        [wu wv eM] = distanceEstimate(flow,im1,im2);
        
        if(counter>0)
           %correlate (wu,wv)  find offset
           %estimate  [estimate dz,dx] -------
        end

        disp('estimated --> ');
        disp(eM);
        emList = [emList ; eM];  % add to list
        
        
    end

        

    expectedVals=[];
    expectedValIndex=dirIndex;
    expectedVals(:,:,1) = [17 0 0.5];  %expected x,y,z in pixels - each pair has a different one
    expectedVals(:,:,2) = [6 0 9]; %xdisp and zDisp are different weight due to dist from screen
    expectedVals(:,:,3) = [0.7 0.45 0.013]; %xdisp and zDisp are different weight due to dist from screen

    experimentXYZ = expectedVals(:,:,expectedValIndex);
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
    zDisp = (emList(:,1)).*sin(actual).*cos(atan2(emList(:,2),emList(:,1))); %estimation of y displacement
    yDisp = (emList(:,2));

    errorX = abs(abs(expectedDx) - abs(xDisp));
    errorY = abs(abs(expectedDy) - abs(yDisp));
    errorZ = abs(abs(expectedDz) - abs(zDisp));

    figure, subplot(3,1,1), plot(alp,errorX); title('error in DX');
    subplot(3,1,2), plot(alp,errorY); ylim([0 10]); title('error in DY'); 
    subplot(3,1,3), plot(alp,errorZ);title('error in DZ');

    
end

