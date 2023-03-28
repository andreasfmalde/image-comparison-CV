function img = HistogramEQ(image,histo)
    % Using my histogram function to make a histogram of the inputted
    % image
    histo = MyHistogram(image);
    
    % Calculation the size of the histogram
    hist_size = size(histo);
    
    % Make a new array of the same size as the histogram
    cdf = zeros(hist_size);
    
    % Looping through the histogram and summing each value of the histogram
    % up to the point i, making a cumulativ distribution function
    for i=1:hist_size
        cdf(i) = sum(histo(1:i));
    end

    % Normalizing the cumulative distribution function values to be between
    % 0 and 255
    cdfnorm = round(((cdf -min(cdf))/(size(image, 1)*size(image, 2) - min(cdf)))*255);

   
    % Copy the original image
    new_img = image;

    % Update each pixel value in the new image based on the value in the
    % normalized cdf array
    for i=1:size(image,1)
        for j=1:size(image,2)
            new_img(i,j) = cdfnorm(new_img(i,j)+1); 
        end
    end

    % Returning the new image
    img = new_img;
end
