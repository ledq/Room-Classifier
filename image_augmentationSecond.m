
clc;
clear;
rootdir = '/MATLAB Drive/Rooms/Bathroom';

% I = imread("test_img.jpg");
%rotate
% J =  flip(I,2);
%crop+Rotate
% K = imrotate(I,35,"bilinear","crop");
% figure
% imshowpair(I,K,"montage")
    % flip_horizontal = flip(image, 2);  % horizontal flip
    rotations = [-10, 0, 10];  % rotation angles in degrees
    intensities = [0.9, 1.0, 1.1];  % intensity adjustments (90%, 100%, 110%)

filePattern = fullfile(rootdir, '*.jpg');
files = dir(filePattern);
for i = 1:numel(files)
  basefilename = files(i).name;
  filename = fullfile(files(i).folder, basefilename);
  image = imread(filename);

    
  J =  flip(image, 2);
    flip_name = sprintf('Bathroom/bath_f_%d.jpg', i);
    imwrite(J, flip_name);
  for r = 1:length(rotations)
        rotated_image = imrotate(image, rotations(r), "bilinear", "crop");
        for k = 1:length(intensities)
            % Adjust intensity
            intensity_adjusted_image = rotated_image * intensities(k);
            % Ensure pixel values stay within the valid range
            intensity_adjusted_image = max(min(intensity_adjusted_image, 255), 0);
            
            rot_name = sprintf('Bathroom/bath_r_%d_%d.jpg', i, r);
      
            imwrite(intensity_adjusted_image, rot_name);
        end
  end
  % apply processing to the loaded image
  % save the image to an array or back to the folder using 
end