%% 
function [ bestH2to1, inliers] = computeH_ransac( locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.
%Q2.2.3
sz=size(locs1,1);
threshold=2.0;
max_cnt=0;
bestH2to1=[];
inliers=[];
maxIter=3000;
for i=1:maxIter
    sample=randperm(sz,4);%sample 4 pairs
    pts1=locs1(sample,:);
    pts2=locs2(sample,:);
    H_cur=computeH_norm(pts1,pts2);%compute homography by DLT+normalization
    cnt=0;
    inlier_cur=zeros(sz,1);
    for j=1:sz
        p1=[locs1(j,:),1];
        p2=[locs2(j,:),1];
        p1_pred=(H_cur*p2')';
        p1_pred=p1_pred/p1_pred(3);
        err=norm(p1-p1_pred);
        if err<threshold%find inliers to the current hypothesis
            cnt=cnt+1;
            inlier_cur(j)=1;
        end
    end
    if cnt>max_cnt%if current hypothesis the better than the previous one
        max_cnt=cnt;
        bestH2to1=H_cur;%update homography hypothesis
        inliers=inlier_cur;
    end
end
end

