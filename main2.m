% From the directory extract the images files needed
% to construct the background
% Directory name is changed manually
directory = '/Users/demetracharalambous/Desktop/IVR_cwk1/files/';
filePattern = '0*.jpg';
% Read the images and store them in a 4-dimensional array
show = 0;
isbinary = 0;
images = read_images(directory, filePattern, isbinary, show);
% Construct the background using the given set of images
show = 0;
background = construct_bg(images, show);
% Convert background to double and save
bg = double(background) / 255;
imwrite(bg, ['bg' '.jpg']);
% Select the images to be used as training set
filePattern_train = 'p*.jpg';
% Read the images and store them in a 4-dimensional array
show = 0;
isbinary = 0;
train_images = read_images(directory, filePattern_train, isbinary, show);
% Get the number of images in the training set
num = size(train_images, 4);
for n = 1 : num
    norm_tr_images(:,:,:,n) = double(train_images(:,:,:,n))/255;
end
% Substract the background from each image and convert it to binary
thres = 0.06;
show = 0;
save = 0;
tr_binary_images = subtract_bg(norm_tr_images, bg, thres, show, save);
% Here training objects were selected manually
% By using the function get_objects
% Read the objects of the training set
show = 0;
isbinary = 1;
filePattern_obj = 'obj*.jpg';
tr_obj = read_images(directory, filePattern_obj, isbinary, show);
% Get the properties of each image in the training set
for i = 1 : size(tr_obj, 3)
    Vecs(i,:) = getproperties(tr_obj(:,:,i));
end
show = 0;
if (show > 0)
    disp(Vecs);
end
% Given the classes of each image in the training set
% and calculate means, inverse covariance and aprioris
Dim = 3;
N = 40;
Numclass = 10;
Classes = [1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 6, 6, 6, 6, 7, 7, 7, 7, 8, 8, 8, 8, 9, 9, 9, 9, 10, 10, 10, 10];
[Means,Invcors,Aprioris] = buildmodel(Dim,Vecs,N,Numclass,Classes);
show = 1;
if (show > 0)
    display(Means);
    display(Invcors);
    display(Aprioris);
end
% *******************Testing*****************************
% Read the test image
show = 0;
isbinary = 0;
filePattern_test = 'tst1.jpg';
tst_img = read_images(directory, filePattern_test, isbinary, show);
% Convert the test image to double
norm_tst_img = double(tst_img) / 255;
% Substract the background from test image and convert it to binary
thres= 0.06;
show = 0;
save = 0;
tst_binary_image = subtract_bg(norm_tst_img, bg, thres, show, save);
% Extract the objects that they will be used for testing
num_obj = 12;
show = 0;
save = 0;
tst_obj = get_objects(tst_binary_image, num_obj, show, save);
% Get the properties of each object image
classes = zeros(1,size(tst_obj,3));
for i = 1 : size(tst_obj, 3)
    test_vecs(i,:) = getproperties(tst_obj(:,:,i));
    [class, evals] = classify(test_vecs(i,:),Numclass,Means,Invcors,Dim,Aprioris);
    if ((evals < (1.0e-200)))
        classes(1,i) = 0;
        disp(['************Error in recognising object: ' num2str(i)]);
        disp('*************Class zero assigned!');
        disp(' ');
        figure
        imshow(tst_obj(:,:,i));
    else
        classes(1,i) = class;
    end
end
disp(classes);

% Calculate total value of the objects in the test image
result = calc_value(classes);
disp(result);