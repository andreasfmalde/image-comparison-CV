%% IQCI - Image Quality Comparison Index
function index = IQCI(img,img2)

    % Making sure the images are of same size
    if size(img,1) ~= size(img2,1) || size(img,2) ~= size(img2,2)
        error('Images must be of same size!');
    end
    
    % Retrieve metrics from each component
    edge = Edges(im2gray(img),im2gray(img2));
    histo = Histo(img,img2);
    color = Colors(img,img2);

    % Wheigh the components based of which component provides the best
    % result
    index = ((6/15)*edge + (5/15)*histo + (4/15)*color);
    % Normalize the index to be between 0 and 1
    index = (index - 0.4)/(1-0.4);

end


%% Edge comparison method
function index =  Edges(img,img2)
    % Using matlab's inbuilt canny edge detection method on both images
    edges_orig = edge(img,"canny");
    edges_blurry = edge(img2,"canny");
    % Subtracting the edge detected images and calculating the average
    % difference
    diff = sum(abs(edges_orig-edges_blurry), "all")/(size(img,1)*size(img,2));
    % 1 equals 100% match of images. Going further down from 1 corresponds to
    % higher difference between the images
    index = 1-diff;
    % Normalizing the index to be between 0  and 1
    index = (index-0.75) / (1-0.75); 
   
end

%% Histogram comparison method
function index =  Histo(img,img2)

    % Tweaked value to be used further down in the method.
    diff_total = (size(img,1)*size(img,2))/100;
    % Vectors to store red channel histogram info for both images
    r1 = zeros(256,1);
    r2 = zeros(256,1);
    % Vectors to store green channel histogram info for both images
    g1 = zeros(256,1);
    g2 = zeros(256,1);
    % Vectors to store blue channel histogram info for both images
    b1 = zeros(256,1);
    b2 = zeros(256,1);
    
    % Looping trough each pixel of the images
    for i = 1:size(img,1)
        for j = 1:size(img,2)
            
            % Extract the red value of the pixel
            red1 = img(i,j,1);
            red2 = img2(i,j,1);
            % Extract the green value of the pixel
            green1 = img(i,j,2);
            green2 = img2(i,j,2);
            % Extract the blue value of the pixel
            blue1 = img(i,j,3);
            blue2 = img2(i,j,3);

            % Update each histogram with the value extracted above
            r1(red1+1) = r1(red1+1) + 1;
            r2(red2+1) = r2(red2+1) + 1;
            g1(green1+1) = g1(green1+1) + 1;
            g2(green2+1) = g2(green2+1) + 1;
            b1(blue1+1) = b1(blue1+1) + 1;
            b2(blue2+1) = b2(blue2+1) + 1;

        end
    end
    % Make a "difference vector" for the histograms of each color channel
    R = abs(r2-r1);
    G = abs(g2-g1);
    B = abs(b2-b1);
    
    % Compute the mean difference value and divide by the tweaked value
    % above
    Rmean = mean(R)/diff_total;
    Gmean = mean(G)/diff_total;
    Bmean = mean(B)/diff_total;

    % Combine each value and calculate an average based on the R, G and B
    % channel scores.
    index = 1-((Rmean+Gmean+Bmean)/3);
    % Normalize the result to be between 0 and 1
    index = (index-0.25)/(1-0.25);

end

%% Color/Hue comparison
function index =  Colors(img,img2)

    % Convert images into the HSV color space
    hsv = rgb2hsv(img);
    hsv2 = rgb2hsv(img2); 
    % Extract the hue (H) channel from both images
    H1 = hsv(:,:,1); 
    H2 = hsv2(:,:,1); 

    % Make an array to temporarily store hue difference values. Will be
    % used to calculating the average hue difference
    count = zeros((size(img,1)*size(img,2)),1);
    counter_index = 1;
    % Get the size of the image
    [height,width,~] = size(img);
    % Neighborhood size with the best result
    step = 5;
    % Go through the image, stepping each neighbourhood size
    for row = 1:step:height
        for col = 1:step:width
            r = step-1;
            c = step-1;
            % Change the size of the neigbhourhood when there are less
            % number of pixels in a direction than the number of pixels in
            % each side of the neighbourhood.
            if (height - row) <= step-1
                r = height - row;
            end
            if(width-col) <= step-1
                c = width - col;
            end
    
            % Temporarily store the pixel coordinates of each neighbourhood
            nh1 = H1(row:row+r,col:col+c);
            nh2 = H2(row:row+r,col:col+c);
            % Calculate the average color value for the neighbourhoods
            MEAN1 = mean(nh1,"all");
            MEAN2 = mean(nh2,"all");
            % Compute the difference in color value between the
            % neighborhoods
            val = abs(MEAN1 - MEAN2);
            % Add the differnce value to the temporary array
            count(counter_index) = val;
            counter_index = counter_index + 1;

        end
    end
    % Calculate the average difference value 
    index = 1-(sum(count)/(counter_index-1));
    % Normalize the result to be between 0 and 1
    index = (index - 0.65) / (1 - 0.65);


end