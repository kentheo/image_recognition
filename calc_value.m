function result = calc_value( classes )
% Function that calculates the value of the objects of the image
% by finding the value of each object according to its class
    % Initialise variables
    num = size(classes, 2);
    result = 0;
    for i = 1 : num
        if (classes(1,i) == 2)
        % class angle bracket(2p)
            result = result + 0.02;
        elseif (classes(1,i) == 3)
        % class two pounds
            result = result + 2;
        elseif (classes(1,i) == 4)
        % class one pound
            result = result + 1;
        elseif (classes(1,i) == 5)
        % class 50p   
            result = result + 0.50;
        elseif (classes(1,i) == 6)
        % class 20p  
            result = result + 0.20;
        elseif (classes(1,i) == 7)
        % class 5p  
            result = result + 0.05;
        elseif (classes(1,i) == 8)
        % class washer with a small hole(75p)  
            result = result + 0.75;
        elseif (classes(1,i) == 9)
        % class washer with a large hole(25p)  
            result = result + 0.25;
        % classes battery, nut and 'error'(Class 0) are omitted
        % as their value is zero
        end
    end

end

