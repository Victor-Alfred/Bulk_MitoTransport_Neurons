

% Radius 10
clear all; clc; close all
% Y-disp: labelled as 1
counter = 0;
for ii = 5:5:1000
    A=zeros(1024,1024);
    r = 10; %radius
    m = {ii,100}; %midpoint
    A(m{:})=2;
    B = imdilate(A,strel('disk', r,0) );
    imshow(B)
    counter = counter + 1
    imwrite(B, [num2str(counter), '.tif'], 'Compression', 'none');
end


clear all; clc; close all
% X-disp: labelled as 2
counter = 0;
for ii = 5:5:1000
    A=zeros(1024,1024);
    r = 10; %radius
    m = {100,ii}; %midpoint
    A(m{:})=2;
    B = imdilate(A,strel('disk', r,0) );
    imshow(B)
    counter = counter + 1
    imwrite(B, [num2str(counter), '.tif'], 'Compression', 'none');
end



% Radius 5
clear all; clc; close all
% Y-disp: labelled as 1
counter = 0;
for ii = 5:5:1000
    A=zeros(1024,1024);
    r = 5; %radius
    m = {ii,100}; %midpoint
    A(m{:})=2;
    B = imdilate(A,strel('disk', r,0) );
    imshow(B)
    counter = counter + 1
    imwrite(B, [num2str(counter), '.tif'], 'Compression', 'none');
end




clear all; clc; close all
% X-disp: labelled as 2
counter = 0;
for ii = 5:5:1000
    A=zeros(1024,1024);
    r = 5; %radius
    m = {100,ii}; %midpoint
    A(m{:})=2;
    B = imdilate(A,strel('disk', r,0) );
    imshow(B)
    counter = counter + 1
    imwrite(B, [num2str(counter), '.tif'], 'Compression', 'none');
end








x=rand(1,100)*1024
y=rand(1,100)*1024
scatter(x,y)





clear all; clc; close all
% X-disp: labelled as 2
counter = 0;
for ii = 9:5:1000
    A=zeros(1024,1024);
    r = [10:2:20]; %radius
    m = {100,ii}; %midpoint
    A(m{:})=2;
    B = imdilate(A,strel('disk', r,0) );
    imshow(B)
    counter = counter + 1
    imwrite(B, [num2str(counter), '.tif'], 'Compression', 'none');
end


