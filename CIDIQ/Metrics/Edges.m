
function index =  Edges(img,img2)


    edges_orig = prewitt_edge_detector_color(img);
    edges_blurry = prewitt_edge_detector_color(img2);


    diff = sum(abs(edges_orig-edges_blurry), "all")/(size(img,1)*size(img,2));
    index = 1-diff;
    index = (index-0.3) / (1-0.3);
   


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