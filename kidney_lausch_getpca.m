% get pca of a data matrix data_mat of n images
% each row in data_mat should correspond to
% one image in the dataset that is concatenated
% horizontally


% data_mat should be known prior to executing this
coeff = pca(data_mat);
disp('Size of data matrix = '); disp(size(data_mat));
disp('Number of principal components = ');disp(size(coeff,2))
% each column in coeff contains coefficients for 
% one principal component


% get the principal components
Itransformed = data_mat*coeff; % the columns are the
% principal components 

% display the first 10 principal components
for i = 1:10
    princompi = reshape(Itransformed(:,i),128,128);
    figure; imshow(princompi,[]);
end

% display the first 10 principal components
figure;
for i = 1:5
    princompi = reshape(Itransformed(:,i),128,128);
    subplot(1,5,i);imshow(princompi,[]);
end

% check whether the reconstruction from pca is
% a good estimate of the original registered data i
num_prin = 200; % no. of principal components to consider (num_prin<=200)
i = 1; % visualize registered kidney i and its pca reconstruction
kidney_lausch_pcalincomb(data_mat,Itransformed,num_prin,coeff,i);