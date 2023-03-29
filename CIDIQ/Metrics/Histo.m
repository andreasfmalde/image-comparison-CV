function index =  Histo(img,img2)


    total = size(img,1)*size(img,2);
    diff_total = (size(img,1)*size(img,2))/100;
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

    R = abs(r2-r1);
    G = abs(g2-g1);
    B = abs(b2-b1);
    
    a = mean(R)/diff_total;
    b = mean(G)/diff_total;
    c = mean(B)/diff_total;


    %aMax = mean(abs(r2-r1))*(max(abs(r2-r1))-mean(abs(r2-r1)));

    %corr = v / aMax;

    index = 1-((a+b+c)/3);

end