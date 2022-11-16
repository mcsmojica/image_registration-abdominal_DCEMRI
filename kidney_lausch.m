clear; close all; clc;
% get kidney_image(:,:,1-200) and ave intensity values of each subject
load('kidney_images.mat');

% determine which data has the highest average intensity value
[max_val,index_max] = max(ave_int);

% separate into two parts
kidney_firsthalf = kidney_image(:,:,1:index_max-1);
kidney_secondhalf = kidney_image(:,:,index_max+1:end);

length_first = index_max-1; % num of regis from data_p-1 to data_1
length_second = 200-index_max; % num of regis from data_p+1 to data_end


% for easy indexing
index_regbackward = length_first:-1:1;
index_regforward = index_max+1:1:200;

%transformations to adjacent data
trans_first = ndSparse(zeros(128,128,2,length_first)); registered_first = ndSparse(zeros(128,128,length_first));;
trans_second = ndSparse(zeros(128,128,2,length_second));; registered_second = ndSparse(zeros(128,128,length_second));


omega=[0,25,0,25];
m=[128,128];
xc = getCellCenteredGrid(omega,m);
inter('reset','inter','linearInter','regularizer','moments','theta',1e-2);

for i = 1:max(length_first,length_second)
    if i==1
        dataR_first = kidney_image(:,:,index_max);
        dataR_first = reshape(inter(dataR_first,omega,center(xc,m)),m);
        dataR_second = dataR_first;
    end
    
    % register the (index_max-i)th data from the first half to the transformed version
    % of the data after it
    if i<=length_first
        index = index_regbackward(i);
        dataT = kidney_image(:,:,index);
        dataT = reshape(inter(dataT,omega,center(xc,m)),m);
        dataR = dataR_first;
        kidney_MLIR_lausch;
        registered_first(:,:,i) = FinalTc; % store the registered; will be
        % the reference image in the next iteration
        dataR_first = FinalTc;
        trans_first(:,:,:,index) = Finalyc;
        close all
    end
    
    
    % register the (index_max+i)th data from the second half to the transformed version
    % of the data before it
    if i<=length_second
        index = index_regforward(i);
        dataT = kidney_image(:,:,index);
        dataT = reshape(inter(dataT,omega,center(xc,m)),m);
        dataR = dataR_second;
        kidney_MLIR_lausch;
        registered_second(:,:,i) = FinalTc; % store the registered; will be
        % the reference image in the next iteration
        dataR_second = FinalTc;
        trans_second(:,:,:,index) = Finalyc;
        close all
    end
        
end
