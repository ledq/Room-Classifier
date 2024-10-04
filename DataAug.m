% Define the original image datastores
rootdir_ = '/MATLAB Drive/image/';
roomsDir_ = [rootdir_ 'rooms'];
augmentedDir_ = [rootdir_ 'rooms_augmented'];
roomsImages_ = imageDatastore(roomsDir_, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');

% Loop through all images in the datastore
for i = 1:numel(roomsImages_.Files)
    filename = roomsImages_.Files{i};
    image = imread(filename);

    [filepath, name, ext] = fileparts(filename);

    % Create the corresponding directory structure in the augmented folder
    relativePath = strrep(filepath, roomsDir_, ''); % Get the relative path within Rooms
    augmentedFilepath = fullfile(augmentedDir_, relativePath);

    if ~exist(augmentedFilepath, 'dir')
        mkdir(augmentedFilepath);
    end

    % Save the original image in the new directory
    original_name = fullfile(augmentedFilepath, [name ext]);
    imwrite(image, original_name);

    % Define augmentation parameters
    flip_horizontal = flip(image, 2);  % horizontal flip
    rotations = [-10, 0, 10];  % rotation angles in degrees
    intensities = [0.9, 1.0, 1.1];  % intensity adjustments (90%, 100%, 110%)

    % Apply augmentations
    for r = 1:length(rotations)
        rotated_image = imrotate(image, rotations(r), "bilinear", "crop");
        for k = 1:length(intensities)
            % Adjust intensity
            intensity_adjusted_image = rotated_image * intensities(k);
            % Ensure pixel values stay within the valid range
            intensity_adjusted_image = max(min(intensity_adjusted_image, 255), 0);

            % Generate filenames and save augmented images in the new directory
            flip_name = sprintf('%s/%s_f_%d_%d%s', augmentedFilepath, name, rotations(r), k, ext);
            rot_name = sprintf('%s/%s_r_%d_%d%s', augmentedFilepath, name, rotations(r), k, ext);
            imwrite(flip_horizontal, flip_name);
            imwrite(intensity_adjusted_image, rot_name);
        end
    end
end
