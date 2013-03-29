function [image1,image2]=readImages(path1,path2,ext,direc,maxSize)


% params    

    a=imread(fullfile(direc,strcat(path1,ext)));
    if(isrgb(a))
        a = (rgb2gray(a)); 
    end
    a = imresize(a,[maxSize maxSize]);
    b = (rgb2gray(imread(fullfile(direc,strcat(path2,ext)))));
    if(isrgb(b))
        b = (rgb2gray(b)); 
    end    
    b = imresize(b,[maxSize maxSize]);

    %a = imcrop(a,r);
    %b = imcrop(b,r);
    
    %figure, imshow(a-b); 
    image1 = a;
    image2 = b;
    
    s=max(image1(:))/max(image2(:));
    image2 = round(s*image2);
    
    image1= uint8(abs(image1));
    image2= uint8(abs(image2));
    
end