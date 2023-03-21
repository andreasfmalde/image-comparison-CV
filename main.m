function main()
original_img = imread("CIDIQ\Images\Original\final01.bmp");
blurry_img = imread("CIDIQ\Images\Reproduction\1_JPEG2000_Compression\final01_d1_l1.bmp");


%figure, imshowpair(original_img,blurry_img,'montage'), title("Orginal vs. Blurry");

[u1 u2] = mean(original_img, blurry_img);

[covar_r,covar_g,covar_b] = covariance(original_img, blurry_img, u1, u2);

end

function [u1,u2] = mean(img1, img2)
u1 = zeros(3,1);
u1(1,:) = sum(reshape(img1(:,:,1),1,[]))/(size(img1,1)*size(img1,2));
u1(2,:) = sum(reshape(img1(:,:,2),1,[]))/(size(img1,1)*size(img1,2));
u1(3,:) = sum(reshape(img1(:,:,3),1,[]))/(size(img1,1)*size(img1,2));


u2 = zeros(3,1);
u2(1,:) = sum(reshape(img2(:,:,1),1,[]))/(size(img1,1)*size(img1,2));
u2(2,:) = sum(reshape(img2(:,:,2),1,[]))/(size(img1,1)*size(img1,2));
u2(3,:) = sum(reshape(img2(:,:,3),1,[]))/(size(img1,1)*size(img1,2));

end


function [covar_r,covar_g,covar_b] = covariance(img1, img2, u1, u2)

r1 = img1(:,:,1);
g1 = img1(:,:,2);
b1 = img1(:,:,3);

r2 = img2(:,:,1);
g2 = img2(:,:,2);
b2 = img2(:,:,3);

covar_r = sum((r1 - u1(1)).*(r2-u2(1)))/(sum(r1) - 1);
covar_g = sum((g1 - u1(2)).*(g2-u2(2)))/(sum(g1) - 1);
covar_b = sum((b1 - u1(3)).*(b2-u2(3)))/(sum(b1) - 1);

end