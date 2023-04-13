function[mean,var] = meanAndVar(img)

   total_size = size(img,1)*size(img,2);

   arr = double(zeros(total_size,3));
   index = 1;

   for i = 1:size(img,1)
       for j = 1:size(img,2)
           arr(index,:) = img(i,j,:);
           index = index + 1;
       end
   end

   mean = sum(arr,1) / total_size;

   arr(:) = 0;
   index = 1;
   for i = 1:size(img,1)
       for j = 1:size(img,2)
           arr(index,:) = img(i,j,:);
          
           arr(index,:) = (arr(index,:) - mean).^2;
           index = index + 1;
       end
   end

   var = sum(arr,1) / total_size;



end