function edge
img = imread("CIDIQ\Images\Original\final01.bmp");
img2 = imread("CIDIQ\Images\Reproduction\1_JPEG2000_Compression\final01_d1_l1.bmp");

edges_orig = prewitt_edge_detector_color(img);
edges_blurry = prewitt_edge_detector_color(img2);


diff = sum(abs(edges_orig-edges_blurry), "all")/(size(img,1)*size(img,2));
1-diff


    figure, subplot(121),imshow(img)
    subplot(122), imshow(img2);
end
