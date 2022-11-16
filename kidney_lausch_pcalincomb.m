function kidney_lausch_pcalincomb(data_mat,Itransformed,num_prin,coeff,i)
    % express registered kidney data i as linear combination of first num_prin principal components
    if num_prin ~= size(coeff,2)
        coeff(:,num_prin+1:end) = zeros(size(coeff(:,num_prin+1:end)));
    end
    coeffi = coeff(i,:);
    iapprox = bsxfun(@times,Itransformed,coeffi); %coeffi1*col1 coeffi2*col2...
    iapprox = sum(iapprox,2); % sum the multiples of the
    % principal components. the approximation is a
    % linear combination of the principal components whose
    % coefficients are given by coeffi
%     close all;
    figure; subplot(1,2,1); imshow(reshape(data_mat(:,i),128,128),[]); title(strcat('Registered Kidney',num2str(i)));
    if num_prin == size(coeff,2)
        subplot(1,2,2); imshow(reshape(iapprox,128,128),[]); title(strcat('Full PCA Reconstruction of Kidney',num2str(i)));
    else
        subplot(1,2,2); imshow(reshape(iapprox,128,128),[]); title(strcat('Reduced PCA Reconstruction of Kidney',num2str(i)));
    end
end