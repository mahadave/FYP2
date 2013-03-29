function [image1,image2]=normalizeImages(image1,image2)

    s1=var(double(image1(:))); %normalize intensities
    s2=var(double(image2(:)));
    m2=mean(double(image2(:)));
    m1=mean(double(image1(:)));
    
    
    
    image2 = 10*round(abs(double((255*(double(image2)-m2)./s2))));
    image2 = uint8(image2);
    image1 = 10*round(abs(double((255*(double(image1)-m1)./s1))));
    image1 = uint8(image1);
    

    figure,
    imshow(image1);
    figure,
    imshow(image2);
    
    
end