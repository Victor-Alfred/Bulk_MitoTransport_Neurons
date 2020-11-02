
% To create indexed text interval labels for crosscorr analysis

txtarray = strseq('Interval-',[1:299]);
dat = txtarray(:);
interval_label = array2table(dat);
% cd(...)
writetable(interval_label)
