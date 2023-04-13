function index = Test(img,img2)

    %img = imread("..\Images\Original\final01.bmp");
    %img2 = imread("..\Images\Reproduction\1_JPEG2000_Compression\final01_d1_l5.bmp");
    

    edge = Edges(img,img2);
    histo = Histo(img,img2);
    color = Colors(img,img2);

    index = ((6/15)*edge + (5/15)*histo + (4/15)*color);
    index = (index - 0.42)/(1-0.42);


end

