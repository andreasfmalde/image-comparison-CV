function index =  Colors(img,img2)
    %img = imread("..\Images\Original\final14.bmp");
    %img2 = imread("..\Images\Reproduction\2_JPEG_Compression\final14_d2_l5.bmp");
    %img = imread("..\Images\Original\final01.bmp");
    %img2 = imread("..\Images\Reproduction\1_JPEG2000_Compression\final01_d1_l1.bmp");


    hsv = rgb2hsv(img); %-
    hsv2 = rgb2hsv(img2); %-
   
    a = hsv(:,:,1); %-
    b = hsv2(:,:,1); %-

    %arr = (a - b).^2;

    count = zeros((size(img,1)*size(img,2)),1);
    counter_index = 1;
    [height,width,~] = size(img);

    step = 5;

    for row = 1:step:height
        for col = 1:step:width
            r = step-1;
            c = step-1;
            if (height - row) <= step-1
                r = height - row;
            end
      
            if(width-col) <= step-1
                c = width - col;
            end
            some1 = a(row:row+r,col:col+c);
            some2 = b(row:row+r,col:col+c);
     
            MEAN1 = mean(some1,"all");
            MEAN2 = mean(some2,"all");

            val = abs(MEAN1 - MEAN2);
            count(counter_index) = val;
            counter_index = counter_index + 1;

        end
    end

    index = 1-(sum(count)/(counter_index-1));
    index = (index - 0.65) / (1 - 0.65);



    %index = (mean(arr,"all")); %-
  



end