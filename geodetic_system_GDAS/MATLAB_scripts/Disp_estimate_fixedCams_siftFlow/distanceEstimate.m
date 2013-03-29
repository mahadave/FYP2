function [ worthyU  worthyV  estimatedMotion ] = distanceEstimate(flow,im1,im2)

% need to do this properly --- KDEetc

a=im1;
b=im2;
estimatedMotion=0;

n=256;

tol=0.05; %threshold to be decided based on the minimum noticable change



    v=flow(:,:,1);
    thresholdX = max(abs(v(:)))-tol*max(abs(v(:)));
    [r1 c1]=find(abs(flow(:,:,1))>=thresholdX);
    
    
    v=flow(:,:,2);
    thresholdY = max(abs(v(:)))-tol*max(abs(v(:)));
    [r2 c2]=find(abs(flow(:,:,2))>=thresholdY); % show only those points greater than threshold (which move)
    
    
    %{ 
    % this is to display the points selected, which meet the threshold    
    for i=1:size(r1)
        disp(uv(r1(i),c1(i),:))
    end
    for i=1:size(r2)
        disp(uv(r2(i),c2(i),:))
    end
    %}
    
    worthyU = [r1 c1]; % points of interest X direction
    worthyV = [r2 c2]; % points of interest Y direction

% store the values of worthy points in list

    listU=[];
    listV=[];

    mListU=0;
    mListV=0;

    for i=1:size(worthyU,1)
        listU = [listU; [flow(worthyU(i,1),worthyU(i,2),1) flow(worthyU(i,1),worthyU(i,2),2)]];
    end

    if(size(worthyU,1)~=0)
        kia=listU(:,1);
        mListU = max(kia(:));%mean(listU(:,1)); % we are interested in the rows of this
    end

    for i=1:size(worthyV,1)
        listV = [listV; [flow(worthyV(i,1),worthyV(i,2),1) flow(worthyV(i,1),worthyV(i,2),2)]]; 
    end

    if(size(worthyV,1)~=0)
        kia=listV(:,2);
        mListV = max(kia(:));%mean(listV(:,2)); % we are interested in the cols of this
    end

    estimatedMotion = [mListU mListV];
    disp(['estimated motion ' ,num2str(estimatedMotion)]);
 
end