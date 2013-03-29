
resolution =1; % square resolution only -- return value

%inputs
accuracyRequired=0.05; % in metres
craterRadius = 65; % in metres
zoom = 1; % times zoom


tanOfCamAngle = 2.155; % 65 degrees clens angle (Konica Minolta Dimage x5)
D = craterRadius/(tanOfCamAngle*zoom); % max distance X,Y recordable

pxResolution=-1;
while (pxResolution<1)
    pxResolution = resolution*accuracyRequired/D;
    resolution = resolution+1; %linear search for value of resolution
end

disp(['min resolution of camera = ',num2str(resolution),' px']);
disp('     for parameters ....');
disp(['Crater Radius = ',num2str(craterRadius),' metres']);
disp(['Camera angle = ',num2str(atan(tanOfCamAngle)),' radians']);
disp(['Required accuracy = ',num2str(accuracyRequired),' metres']);