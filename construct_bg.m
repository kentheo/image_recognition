function  background  = construct_bg(images, show)
%Function that extracts the background of a set of images
    % Get the background as the median over all the chosen images
    background = median(images, 4);
    if (show > 0)
        figure
        imshow(background);
    end
end