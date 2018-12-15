function images = read_images( directory, filePattern, binary, show )
    % Function to read the images for further processing   
    % Retrieve the directory and file pattern of the images
    filePattern2 = fullfile(directory, filePattern);
    jpgFiles = dir(filePattern2);
    % Initialize variables
    dim = length(jpgFiles);
    if (binary == 0)
    % If the picture is not binary
    % Create 4-dimensional array
        images = zeros(480, 640, 3, dim, 'uint8');
        % Read the images and show them if asked
        for d = 1 : dim
            image = imread(jpgFiles(d).name);
            images(:,:,:,d) = image;
            if (show > 0)
                figure(d)
                imshow(images(:,:,:,d));
            end
        end
    else
    % If the picture is binary
    % Create 3-dimensional array
        images = zeros(480, 640, dim, 'uint8');
        for d = 1 : dim
            image = imread(jpgFiles(d).name);
            images(:,:,d) = image;
            if (show > 0)
                figure(d)
                imshow(images(:,:,d));
            end
        end
    end
end

