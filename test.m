function test

    img = imread("CIDIQ\Images\Original\final01.bmp");
    img2 = imread("CIDIQ\Images\Original\final02.bmp");

    total = (size(img,1)*size(img,2))/256;
    r1 = zeros(256,1);
    r2 = zeros(256,1);

    g1 = zeros(256,1);
    g2 = zeros(256,1);

    b1 = zeros(256,1);
    b2 = zeros(256,1);

    for i = 1:size(img,1)
        for j = 1:size(img,2)

            red1 = img(i,j,1);
            red2 = img2(i,j,1);

            green1 = img(i,j,2);
            green2 = img2(i,j,2);

            blue1 = img(i,j,3);
            blue2 = img2(i,j,3);


            r1(red1+1) = r1(red1+1) + 1;
            r2(red2+1) = r2(red2+1) + 1;
            g1(green1+1) = g1(green1+1) + 1;
            g2(green2+1) = g2(green2+1) + 1;
            b1(blue1+1) = b1(blue1+1) + 1;
            b2(blue2+1) = b2(blue2+1) + 1;

        end
    end

    
    
    a = mean(abs(r2-r1))/total;
    b = mean(abs(g2-g1))/total;
    c = mean(abs(b2-b1))/total;

    histogram = 1-((a+b+c)/3);





    hsv = rgb2hsv(img);
    hsv2 = rgb2hsv(img2);
   
    a = hsv(:,:,1);
    b = hsv2(:,:,1);

    ans = 1-(mean((a-b).^2,"all"));
    color_diff = ans;



    index = (histogram + color_diff )/2;

    index

    figure, subplot(121),imshow(img)
    subplot(122), imshow(img2);


end