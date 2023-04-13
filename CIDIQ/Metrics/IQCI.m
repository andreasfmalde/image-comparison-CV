%% IQCI - Image Quality Comparison Index
function index = IQCI(img,img2)

    if size(img,1) ~= size(img2,1) || size(img,2) ~= size(img2,2)
        error('Images must be of same size!');
    end

    edge = Edges(im2gray(img),im2gray(img2));
    histo = Histo(img,img2);
    color = Colors(img,img2);

    %index = (edge + histo + color)/3;
    index = ((6/15)*edge + (5/15)*histo + (4/15)*color);
    index = (index - 0.4)/(1-0.4);

end


function index =  Edges(img,img2)
    %edges_orig = prewitt_edge_detector_color(img);
    %edges_blurry = prewitt_edge_detector_color(img2);
    edges_orig = edge(img,"canny");
    edges_blurry = edge(img2,"canny");
    diff = sum(abs(edges_orig-edges_blurry), "all")/(size(img,1)*size(img,2));
    index = 1-diff;
    index = (index-0.75) / (1-0.75); 
end


function index =  Histo(img,img2)


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


    index = 1-((a+b+c)/3);
    index = (index-0.25)/(1-0.25);

end


function index =  Colors(img,img2)


    hsv = rgb2hsv(img);
    hsv2 = rgb2hsv(img2); 
  
    a = hsv(:,:,1); 
    b = hsv2(:,:,1); 


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
end