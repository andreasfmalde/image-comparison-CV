function index = test(img,img2)




    img = imread("CIDIQ\Images\Original\final14.bmp");
    img2 = imread("CIDIQ\Images\Reproduction\2_JPEG_Compression\final14_d2_l5.bmp");
    %img = imread("CIDIQ\Images\Original\final01.bmp");
    %img2 = imread("CIDIQ\Images\Reproduction\1_JPEG2000_Compression\final01_d1_l1.bmp");


    total = size(img,1)*size(img,2);
    diff_total = (size(img,1)*size(img,2))/75;
 
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
    
    Sr = std(R)/total;
    Sg = std(G)/total;
    Sb = std(B)/total;

    
    a = mean(R)/diff_total;
    b = mean(G)/diff_total;
    c = mean(B)/diff_total;

   
    %aMax = mean(abs(r2-r1))*(max(abs(r2-r1))-mean(abs(r2-r1)));

    
    S = mean([Sr,Sg,Sb]);

    index = 1-((a+b+c+(6*S))/3);

    index
   
    stop


figure, subplot(121),imshow(img)
    subplot(122), imshow(img2);

    stop





    hsv = rgb2hsv(img);
    hsv2 = rgb2hsv(img2);
   
    a = hsv(:,:,1);
    b = hsv2(:,:,1);

    color_diff = 1-(mean((a-b).^2,"all"));

    %% Edges

    edges_orig = prewitt_edge_detector_color(img);
    edges_blurry = prewitt_edge_detector_color(img2);


    diff = sum(abs(edges_orig-edges_blurry), "all")/(size(img,1)*size(img,2));
    edge_comparison = 1-diff;



    index = (histogram + color_diff  + edge_comparison)/3;

    index = index*9;

    %figure, subplot(121),imshow(img)
    %subplot(122), imshow(img2);


end

function [output] = prewitt_edge_detector_color(image)

%convert image to double
image = im2double(image);

%extract the three color channels
r = image(:,:,1);
g = image(:,:,2);
b = image(:,:,3);

%define the kernels
kx = [-1 0 1; -1 0 1; -1 0 1];
ky = [-1 -1 -1; 0 0 0; 1 1 1];

%apply kernels to the channels
rx = conv2(r,kx, 'same');
gx = conv2(g,kx, 'same');
bx = conv2(b,kx, 'same');
ry = conv2(r,ky, 'same');
gy = conv2(g,ky, 'same');
by = conv2(b,ky, 'same');

%apply edge detection on the channels
rx_edges = abs(rx) > 0.2;
gx_edges = abs(gx) > 0.2;
bx_edges = abs(bx) > 0.2;
ry_edges = abs(ry) > 0.2;
gy_edges = abs(gy) > 0.2;
by_edges = abs(by) > 0.2;

%combine the three channels
edges = rx_edges | gx_edges | bx_edges | ry_edges | gy_edges | by_edges;

%return the edges
output = edges;

end