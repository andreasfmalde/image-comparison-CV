function main()
original_image = imread("CIDIQ\Images\Original\final01.bmp");
blurry_image = imread("CIDIQ\Images\Reproduction\1_JPEG2000_Compression\final01_d1_l1.bmp");

figure, imshowpair(original_image,blurry_image,'montage'), title("Sander take image" + ...
    "           Fedda take image");

meanSquaredError(original_image, blurry_image)
end

function score = meanSquaredError(orig_img, other_img)
[x,y] = size(orig_img);
orig_img = double(orig_img);
other_img = double(other_img);
sum = 0;

for i = 1:x
    for j = 1:y
        sum = sum + (orig_img(i,j)-other_img(i,j))^2/(orig_img(i,1)^2);
    end
end
score = sum / x*y;
end