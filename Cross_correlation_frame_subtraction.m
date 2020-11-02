
%% Cross Correlation images

if exist([filedir, '/Analysis'],'dir') == 0
    mkdir(filedir,'/Analysis');
end
analysis_folder = [filedir, '/Analysis'];                   

for ww = 1:n_subfolders
    split_binary = [filedir, ['/Binary/', num2str(ww)]];
    cd(split_binary)
    files_bin = dir('*.tif')

    % create individual folder per image for results
    if exist ([filedir, ['/Analysis/', num2str(ww)], 'dir']) == 0
        mkdir (filedir, ['/Analysis/', num2str(ww)]);
    end
    analysis_folder_by_image = [filedir, ['/Analysis/', num2str(ww)]];

    if exist ([filedir, ['/Analysis/', num2str(ww), '/cc_plots'], 'dir']) == 0
        mkdir (filedir, ['/Analysis/', num2str(ww), '/cc_plots']);
    end
    analysis_plots = [filedir, ['/Analysis/', num2str(ww), '/cc_plots']];

    if exist ([filedir, ['/Analysis/', num2str(ww), '/summary'], 'dir']) == 0
        mkdir (filedir, ['/Analysis/', num2str(ww), '/summary']);
    end
    analysis_sheets = [filedir, ['/Analysis/', num2str(ww), '/summary']];

    if exist ([filedir, ['/Analysis/', num2str(ww), '/diff_px'], 'dir']) == 0
        mkdir (filedir, ['/Analysis/', num2str(ww), '/diff_px']);
    end
    analysis_px_plots = [filedir, ['/Analysis/', num2str(ww), '/diff_px']];

     if exist ([filedir, ['/Analysis/', num2str(ww), '/properties_size'], 'dir']) == 0
        mkdir (filedir, ['/Analysis/', num2str(ww), '/properties_size']);
    end
    analysis_properties_size = [filedir, ['/Analysis/', num2str(ww), '/properties_size']];

    if exist ([filedir, ['/Analysis/', num2str(ww), '/properties_ecc'], 'dir']) == 0
        mkdir (filedir, ['/Analysis/', num2str(ww), '/properties_ecc']);
    end
    analysis_properties_shape1 = [filedir, ['/Analysis/', num2str(ww), '/properties_ecc']];

        if exist ([filedir, ['/Analysis/', num2str(ww), '/properties_circ'], 'dir']) == 0
        mkdir (filedir, ['/Analysis/', num2str(ww), '/properties_circ']);
    end
    analysis_properties_shape2 = [filedir, ['/Analysis/', num2str(ww), '/properties_circ']];
    
    for mm = 1:numel(files_bin)-1
        cd(split_binary)
        I1 = [num2str(mm),'.tif'];
        I2 = [num2str(mm+1),'.tif'];
        Im1 = imread(I1);
        Im2 = imread(I2);
        Im1_ = logical(Im1);

        % cross correlation calculations
        c = normxcorr2(Im2, Im1);
        % Image1 = figure, surf(c), shading flat
        cc_data = max(c(:))
        ccor_data(mm) = cc_data;

        % calculate properties of frames
        stat = regionprops(Im1_, 'Area', 'Eccentricity', 'Circularity');
        obj_num(mm) = length(stat);

        for ii=1:length(stat)
            obj_area(ii) = stat(ii).Area;
        end
        obj_area = obj_area(:);

        for ii=1:length(stat)
            obj_ecc(ii) = stat(ii).Eccentricity;
        end
        obj_ecc = obj_ecc(:);

        for ii=1:length(stat)
            obj_circ(ii) = stat(ii).Circularity;
        end
        obj_circ = obj_circ(:);
       

        % frame to frame subtraction
        % proportion of moving pixels
        Im3 = imsubtract(Im2, Im1); % subtract successive frames
        c_px = nnz(Im3) / nnz(Im1);
        rel_px_count(mm) = c_px;

       
        % cd(analysis_px_plots)
        % imwrite(Im3, ['T', num2str(mm+1), '_T', num2str(mm), '_diff_px.tif'], 'Compression', 'none');
        % cd(analysis_plots)
        % Output_Graph = ['T', num2str(mm+1), '_T', num2str(mm), '_cross_corr_plot.tif'];
        % hold off
        % print(Image1, '-dtiff', '-r300', Output_Graph)
        % close all
        cd(analysis_properties_size)
        csvwrite(['frame' num2str(mm), '_obj_area.csv'], obj_area(:))

        cd(analysis_properties_shape1)
        csvwrite(['frame' num2str(mm), '_obj_ecc.csv'], obj_ecc(:))

        cd(analysis_properties_shape2)
        csvwrite(['frame' num2str(mm), '_obj_circ.csv'], obj_circ(:))
        
    end
 

   % save object distances to csv file
    cd(analysis_sheets)
    csvwrite(['mov' num2str(ww), '_cor_coeff.csv'], ccor_data(:))
    csvwrite(['mov' num2str(ww), '_obj_area_mean.csv'], mean(obj_area))
    csvwrite(['mov' num2str(ww), '_rel_px.csv'], rel_px_count(:))
    csvwrite(['mov' num2str(ww), '_obj_num.csv'], obj_num(:))   
    
end


% dat = values(M('1'));
% dat = dat(:);
% dat = array2table(dat);

% analysis_sheets1 = [filedir, ['/Analysis/', num2str(1), '/summary']];
% cd(analysis_sheets1)
% writetable(dat1)