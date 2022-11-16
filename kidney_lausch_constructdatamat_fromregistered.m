% % run this after obtaining all the registered templates
% % and transformations from kidney_lausch
inter('reset','inter','linearInter','regularizer','moments','theta',1e-2);
data_mat = sparse(zeros(128^2,nimg));
for i = 1:length_first
    index = index_regbackward(i);
    vectorize_this = registered_first(:,:,i);
    B = vectorize_this(:);
    data_mat(:,index) = B;
end

vectorize_this = kidney_image(:,:,index_max);
% % % % % vectorize_this =
% reshape(inter(vectorize_this,omega,center(xc,m)),m); ----------- what is this for???
B = vectorize_this(:);
data_mat(:,index_max) = B;

for i = 1:length_second
    index = index_regforward(i);
    vectorize_this = registered_second(:,:,i);
    B = vectorize_this(:);
    data_mat(:,index) = B;
end

data_mat = full(data_mat);
%%%%%%%%%%%%%% construct data matrix by %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% concatenating horizontally %%%%%%%%%%%%%%%
% data_mat = sparse(zeros(200,128^2));
% for i = 1:length_first
%     index = index_regbackward(i);
%     vectorize_this = registered_first(:,:,i);
%     B = vectorize_this.'; B = B(:)';
%     data_mat(index,:) = B;
% end
% vectorize_this = kidney_image(:,:,index_max);
% vectorize_this = reshape(inter(vectorize_this,omega,center(xc,m)),m);
% B = vectorize_this.'; B = B(:)';
% data_mat(index_max,:) = B;
% 
% for i = 1:length_second
%     index = index_regforward(i);
%     vectorize_this = registered_second(:,:,i);
%     B = vectorize_this.'; B = B(:)';
%     data_mat(index,:) = B;
% end
% 
% clear B vectorize_this