function main
    


   img1 = double(imread('CIDIQ\Images\Original\final01.bmp'));
   img2 = double(imread('CIDIQ\Images\Original\final01.bmp'));

   [xMean,xVar] = meanAndVar(img1);
   [yMean,yVar] = meanAndVar(img2);

   total_pixels = size(img1,1)*size(img1,2);

   
   total = double(zeros(1,3));
   x = double(zeros(1,3));
   y = double(zeros(1,3));

   for i = 1:size(img1,1)
       for j = 1:size(img1,2)
           x(1,:) = img1(i,j,:);
           y(1,:) = img2(i,j,:);
           xx = x(1,:) - xMean;
           yy = y(1,:) - yMean;
  
           total(1,:) = total(1,:) + (xx.*yy);
       end
   end

   cov = total(1,:) / total_pixels;


   c1 = 255 * 0.01;
   c2 = 255 * 0.03;


   cov = sum(cov);
   xMean = sum(xMean);
   yMean = sum(xMean);
   xVar = sum(xVar);
   yVar = sum(yVar);

   above =  (2*xMean*yMean + c1)*(2*cov + c2);

   below = (xMean^2 + yMean^2 + c1)*(xVar + yVar +c2);
   above
   below

   ssim = above / below;

   ssim




   

end
