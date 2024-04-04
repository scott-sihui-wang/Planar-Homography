function [H2to1] = computeH_norm(x1, x2)

%% Compute centroids of the points
centroid1 = mean(x1);
centroid2 = mean(x2);

%% Shift the origin of the points to the centroid
x1=x1-centroid1;
x2=x2-centroid2;

%% Normalize the points so that the average distance from the origin is equal to sqrt(2).
norm1=zeros(size(x1,1),1);
norm2=zeros(size(x2,1),1);
for i=1:size(x1,1)
    norm1(i)=norm(x1(i,:));
end
for i=1:size(x2,1)
    norm2(i)=norm(x2(i,:));
end
m1=sqrt(2)/mean(norm1);
m2=sqrt(2)/mean(norm2);

x1=m1*x1;
x2=m2*x2;

%% similarity transform 1
T1 = [m1,0,-centroid1(1)*m1;0,m1,-centroid1(2)*m1;0,0,1];

%% similarity transform 2
T2 = [m2,0,-centroid2(1)*m2;0,m2,-centroid2(2)*m2;0,0,1];

%% Compute Homography
H=computeH(x1,x2);
%% Denormalization
H2to1=T1\H*T2;
