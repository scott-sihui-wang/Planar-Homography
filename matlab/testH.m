I1=imread('../data/cv_cover.jpg');
I2=imread('../data/cv_desk.png');
[locs1,locs2]=matchPics(I1,I2);
H=computeH(locs1,locs2);%DLT
sample=randperm(size(locs1,1),10);%take 10 pairs to visualize
pts1=[];
pts2=locs2(sample,:);
for i=1:10
    p2=[pts2(i,:),1];
    p1=H*p2';
    p1=(p1/p1(3))';
    pts1=[pts1;p1(1:2)];
end
figure('Name', 'computeH');
showMatchedFeatures(I1,I2,pts1,pts2,'montage');%visualization
H=computeH_norm(locs1,locs2);%normalization+DLT
sample=randperm(size(locs1,1),10);%take 10 pairs to visualize
pts1=[];
pts2=locs2(sample,:);
for i=1:10
    p2=[pts2(i,:),1];
    p1=H*p2';
    p1=(p1/p1(3))';
    pts1=[pts1;p1(1:2)];
end
figure('Name', 'computeH_norm');
showMatchedFeatures(I1,I2,pts1,pts2,'montage');%visualization
[H,inliers]=computeH_ransac(locs1,locs2);%RANSAC
pts1=[];
idx=find(inliers==1);
pts2=locs2(idx,:);%take all inliers to visualize
for i = 1:length(pts2)
    p2=[pts2(i, :),1];
    p1=H*p2';
    p1=(p1/p1(3))';
    pts1=[pts1;p1(1:2)];
end
figure('Name', 'computeH_ransac');
showMatchedFeatures(I1,I2,pts1,pts2,'montage');%visualization