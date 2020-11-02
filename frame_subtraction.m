
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

    if exist ([filedir, ['/Analysis/', num2str(ww), '/diff_px'], 'dir']) == 0
        mkdir (filedir, ['/Analysis/', num2str(ww), '/diff_px']);
    end
    analysis_plots = [filedir, ['/Analysis/', num2str(ww), '/diff_px']];

    if exist ([filedir, ['/Analysis/', num2str(ww), '/summary'], 'dir']) == 0
        mkdir (filedir, ['/Analysis/', num2str(ww), '/summary']);
    end
    analysis_sheets = [filedir, ['/Analysis/', num2str(ww), '/summary']];
    

    for mm = 1:numel(files_bin)-1
        cd(split_binary)
        I1 = [num2str(mm),'.tif'];
        I2 = [num2str(mm+1),'.tif'];
        Im1 = imread(I1);
        Im2 = imread(I2);


        Im3 = imsubtract(Im2, Im1); % subtract successive frames

        c = nnz(Im3) / nnz(Im1)

        rel_px_count(mm) = c;

        cd(analysis_plots)
        imwrite(Im3, ['T', num2str(mm+1), '_T', num2str(mm), '_diff_px.tif'], 'Compression', 'none');
        
    end
 

   % save object distances to csv file
    cd(analysis_sheets)
    csvwrite(['mov' num2str(ww), '_rel_px.csv'], rel_px_count(:))
    
end


% dat = values(M('1'));
% dat = dat(:);
% dat = array2table(dat);

% analysis_sheets1 = [filedir, ['/Analysis/', num2str(1), '/summary']];
% cd(analysis_sheets1)
% writetable(dat1)






