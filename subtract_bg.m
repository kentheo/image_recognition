function binary_images = subtract_bg( images, background, thres_value, show, write )
% Function that removes the background image from each given image
% Returns the binary image
%   Store the length of the images
    num = size(images, 4);
%   Initialise and normalise the 4-dimensional array that will be returned
    binary_images = zeros(480, 640, num);
    for n = 1 : num
        % Subtract background from the original image
        no_background = abs(imsubtract(background, images(:,:,:,n)));
        % Get the binary image for each channel
        % Given a specific thresshold value after tests and observations
        thresholded_image = no_background > thres_value;
        % Or the images per channel to get the binary image
        binary_image = thresholded_image(:,:,1) | thresholded_image(:,:,2) | thresholded_image(:,:,3);    
        % Show the binary images if asked
        if (show > 0)
            figure
            imshow(binary_image);
        end
        % Save the binary images if asked
        if (write > 0)
            imwrite(binary_image, ['binary_image' int2str(n) '.jpg']);   
        end
        % Store the binary image into a new 4-dimensional array
        binary_images(:,:,n) = binary_image;
    end
end

