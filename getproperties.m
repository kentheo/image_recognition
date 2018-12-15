
function vec = getproperties(Image)
% gets property vector for a binary shape in an image
     Image = getlargest(Image,0);
     stats=  regionprops(Image, 'FilledArea', 'MajorAxisLength', 'MinorAxisLength');
     FilledA = cat(1,stats.FilledArea);
     diameters = mean([stats.MajorAxisLength stats.MinorAxisLength],2);
     radii = diameters / 2;
     c = complexmoment(Image,1,1)/1000;
     %only use 3 as only have 4 samples
     vec = [radii, c, FilledA];        
end
