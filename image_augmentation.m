rootdir = '/MATLAB Drive/image/';

% I = imread("test_img.jpg");
%rotate
% J =  flip(I,2);
%crop+Rotate
% K = imrotate(I,35,"bilinear","crop");
% figure
% imshowpair(I,K,"montage")

files = dir('*.jpg');  % specigy the extension of your image file
for i = 1:numel(files);
  filename = files(i).name;
  image = imread(filename);
  J =  flip(image, 2);
  K = imrotate(image,35,"bilinear","crop");
  flip_name = sprintf('flipped/bath_f_%d.jpg', i);
  rot_name = sprintf('rotated/bath_r_%d.jpg', i);
  imwrite(J, flip_name);
  imwrite(K, rot_name);
  % apply processing to the loaded image
  % save the image to an array or back to the folder using 
end