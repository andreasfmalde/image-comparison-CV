function index =  Colors(img,img2)

    hsv = rgb2hsv(img);
    hsv2 = rgb2hsv(img2);
   
    a = hsv(:,:,1);
    b = hsv2(:,:,1);

    index = 1-(mean((a-b).^2,"all"));



end