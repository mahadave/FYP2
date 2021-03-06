function [] = quiverPlot( a, uv )
%QUIVERPLOT Plots quivers on the reference image
%   imputs : vector v , ref image a , scale_down n

    %{
    [Y X]=meshgrid(1:n,1:n);
    D = interp2(double((a)), Y-uv(:,:,2), X-uv(:,:,1));
    figure,imshow(D);
   %}
    n=size(a,1);
    uv=imresize(uv,[n n]);
    
    w = 10; % resolution of quivers
    m = ceil(n/w); % number of quivers along X and Y
    t = w/2 + ((0:m-1)*w);
    
    figure,
    imresize(a,[n n]);
    imshow(a);colormap(gray);
    hold on
      
    quiver(t,t,uv(1:w:n,1:w:n,1), uv(1:w:n,1:w:n,2));
    
    % x- component of strain : v(:,:,2)
    % y- component of strain : v(:,:,1)
    
    axis('ij');

    
end

