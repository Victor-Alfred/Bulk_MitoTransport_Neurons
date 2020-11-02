
%% Cross Correlation images

dbstop if error

clear M N c cc_data

if exist([filedir, '/Analysis'],'dir') == 0
    mkdir(filedir,'/Analysis');
end
analysis_folder = [filedir, '/Analysis'];

split_binary = [filedir, ['/Binary/', num2str(ww)]]

M = containers.Map;

for ww = 1: n_subfolders  
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

    keyindex = num2str(ww);
    
    N = containers.Map;
    for mm = 1:numel(files_bin)-1
        

        keyindex2 = num2str(mm);
        cd(split_binary)
        I1 = [num2str(mm),'.tif'];
        I2 = [num2str(mm+1),'.tif'];
        Im1 = imread(I1);
        Im2 = imread(I2);

        c = normxcorr2(Im2, Im1);
        Image1 = figure, surf(c), shading flat

        cc_data = max(c(:))

        N(keyindex2) = cc_data;

        cd(analysis_plots)
        Output_Graph = ['T', num2str(mm+1), '_T', num2str(mm), '_cross_corr_plot.tif'];
        hold off
        print(Image1, '-dtiff', '-r300', Output_Graph)
        close all
        
    end
    values(N)
    M(keyindex) = N
    
end

% keys(M)
% values(M)

% dat = values(M('1'));
% dat = dat(:);
% dat = array2table(dat);

% analysis_sheets1 = [filedir, ['/Analysis/', num2str(1), '/summary']];
% cd(analysis_sheets1)
% writetable(dat1)

%%%%%%%%%%%%

% dat = values(M('7'));
% dat = dat(:);
% dat = array2table(dat);

% analysis_sheets7 = [filedir, ['/Analysis/', num2str(ww), '/summary']];
% cd(analysis_sheets7)
% writetable(dat)






