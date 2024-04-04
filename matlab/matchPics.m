function [ locs1, locs2] = matchPics( I1, I2)
%MATCHPICS Extract features, obtain their descriptors, and match them!
%% Convert images to grayscale, if necessary
if(ndims(I1)==3)
    I1=rgb2gray(I1);
end
if(ndims(I2)==3)
    I2=rgb2gray(I2);
end
%% Detect features in both images
pts1=detectFASTFeatures(I1);
pts2=detectFASTFeatures(I2);
%% Obtain descriptors for the computed feature locations
[desc1,l1]=computeBrief(I1,pts1.Location);
[desc2,l2]=computeBrief(I2,pts2.Location);
%% Match features using the descriptors
feat_pairs=matchFeatures(desc1,desc2,'MatchThreshold',10.0,'MaxRatio',0.70);
locs1=l1(feat_pairs(:,1),:);
locs2=l2(feat_pairs(:,2),:);
end

