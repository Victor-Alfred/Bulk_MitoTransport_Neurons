%% Thresholding Script (Adaptive and Median filtering)
% Victor Alfred, 2020


% *** DEFINE FILE EXTENSION OF IMAGE FILES FOR PROCESSING ***
fileext = '.tif';
% *** DEFINE THRESHOLD VALUE ***
thresh_level = 0.5;
% *** DEFINE MINIMUM OBJECT SIZE ***
min_object_size = 2; % made obsolete by the lines below
% range of object sizes to be removed with bwareaopen
LB = 5; % remove objects smaller than 2 px in area
UB = 250; % remove objects larger than 50 px in area

%% *** ASK WHETHER SHOULD USE DEFAULT PARAMETERS ***
usedefault = questdlg(strcat('Use default settings (thresh_level = ',num2str(thresh_level),...
    ', min_object_size = ', num2str(min_object_size), 'px, fileext = ', fileext,'?)'),'Settings','Yes','No','Yes');

if strcmp(usedefault, 'No')
    parameters = inputdlg({'Enter threshold value:', 'Enter minimum object size (in pixels)',...
     'Enter file extension:'},'Parameters',1,...
        {num2str(thresh_level),num2str(min_object_size),fileext});
    % *** REDEFINE PIXEL AREA ***
   thresh_level = str2double(parameters{1});
    % *** REDEFINE MINIMAL OBJECT SIZE IN PIXELS ***
    min_object_size = str2double(parameters{2});
    % *** REDEFINE FILE EXTENSION OF IMAGE FILES FOR PROCESSING ***
    fileext = parameters{3};
    
    parameters = parameters';
else
    parameters{1} = num2str(thresh_level);
    parameters{2} = num2str(min_object_size);
    parameters{3} = fileext;
end

% specify number of subfolders as input
% n_subfolders = inputdlg('Please enter number of subfolders: ','n_subfolders');
%  while (isnan(str2double(n_subfolders)) || str2double(n_subfolders)<0)
%      n_subfolders = inputdlg('Please enter number of subfolders: ','n_subfolders');
% end

n_subfolders = numel(object_files); % obtained from previous script 'splitter.m'

% Loop through each subfolder
for ww = 1:n_subfolders
    split_tifs_individual = [filedir, ['/split_tifs/', num2str(ww)]];
    cd(split_tifs_individual)
    files_split = dir('*.tif')

    % Create results subdirectory
    if exist([split_tifs_individual, '../../Binary'],'dir') == 0
        mkdir(split_tifs_individual,'../../Binary');
    end
    result_dir = [split_tifs_individual,'../../Binary'];

     % create individual folders for thresholded images
    if exist ([filedir, ['/Binary/', num2str(ww)], 'dir']) == 0
        mkdir (filedir, ['/Binary/', num2str(ww)]);
    end
    split_binary = [filedir, ['/Binary/', num2str(ww)]];

    % Thresholding individual images in the subfolder
    for kk = 1:numel(files_split)
        cd(split_tifs_individual)
        I = [num2str(kk),'.tif'];
        I_im = imread(I);
        BW = imbinarize(I_im, adaptthresh(I_im, thresh_level)); 
        BW2 = xor(bwareaopen(BW, LB), bwareaopen(BW, UB));
        J = medfilt2(BW2); 
        I_holes = imfill(J, 'holes');
        I_holes = im2double(I_holes); figure, imshow(I_holes)
        % write binary data to subfolder
        cd(split_binary)
        imwrite(I_holes, [num2str(kk),'.tif'], 'Compression', 'none');
        dlmwrite('parameters.txt',[thresh_level, LB, UB])
        close all
    end
    
end