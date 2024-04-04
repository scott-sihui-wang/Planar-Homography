% Your solution to Q2.1.5 goes here!

%% Read the image and convert to grayscale, if necessary
I1=imread('../data/cv_cover.jpg');
%% Compute the features and descriptors
pts1_fast=detectFASTFeatures(I1);
pts1_surf=detectSURFFeatures(I1);
[desc1_brief,locs1_brief]=computeBrief(I1,pts1_fast.Location);
[desc1_surf,locs1_surf]=extractFeatures(I1,pts1_surf.Location,'Method','SURF');
hist_brief=[];
hist_surf=[];
for i = 0:36
    %% Rotate image
    I2=imrotate(I1,i*10);
    %% Compute features and descriptors
    pts2_fast=detectFASTFeatures(I2);
    [desc2_brief,locs2_brief]=computeBrief(I2,pts2_fast.Location);
    pts2_surf=detectSURFFeatures(I2);
    [desc2_surf,locs2_surf]=extractFeatures(I2,pts2_surf.Location,'Method','SURF');
    %% Match features
    feat_pairs_brief=matchFeatures(desc1_brief,desc2_brief,'MatchThreshold',10.0,'MaxRatio',0.68);
    feat_pairs_surf=matchFeatures(desc1_surf,desc2_surf,'MatchThreshold',1.0,'MaxRatio',0.68);
    %% Update histogram
    hist_brief=[hist_brief size(feat_pairs_brief,1)];
    hist_surf=[hist_surf size(feat_pairs_surf,1)];
    if i==6 || i==12 || i==18
        figure('Name',sprintf('BRIEF: %d degree',i*10));
        showMatchedFeatures(I1,I2,locs1_brief(feat_pairs_brief(:,1),:),locs2_brief(feat_pairs_brief(:,2),:),'montage');
        figure('Name',sprintf('SURF: %d degree',i*10));
        showMatchedFeatures(I1,I2,locs1_surf(feat_pairs_surf(:,1),:),locs2_surf(feat_pairs_surf(:,2),:),'montage');
    end
end

%% Display histogram
figure('Name','BRIEF: Histogram');
bar(0:10:360, hist_brief);
title('BRIEF: Histogram of the Count of Matches');
xlabel('Rotation Angle (degree)');
ylabel('Number of Matched Features');
figure('Name','SURF: Histogram');
bar(0:10:360, hist_surf);
title('SURF: Histogram of the Count of Matches');
xlabel('Rotation Angle (degree)');
ylabel('Number of Matched Features');