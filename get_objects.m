function objects = get_objects( img, num_obj, show, save )
%Function that extracts objects from an image
% *For the training set: All the objects were saved and chosen manually 
    for i = 1 : num_obj
        large = double(getlargest(img,0));
        img = abs(imsubtract(large, img));
        objects(:,:,i) = large;
    end
    % Loop through the objects if asked to be shown
    if (show > 0)
        for n = 1 : num_obj
            figure
            imshow(objects(:,:,n));
        end
    end
    % Save image objects if asked
    if (save > 0)
        for n = 1 : num_obj
            im = objects(:,:,n);
            filename = sprintf('obj%d.jpg', n);
            imwrite(im, filename, 'jpg');
        end
    end  
end

