function [ composite_img ] = compositeH( H2to1, template, img )
%COMPOSITE Create a composite image after warping the template image on top
%of the image using the homography

% Note that the homography we compute is from the image to the template;
% x_template = H2to1*x_photo
% For warping the template to the image, we need to invert it.
H_template_to_img = inv(H2to1);
%% Create mask of same size as template
mask=ones(size(template));
%% Warp mask by appropriate homography
% warp the all-one-mask so that only the book cover area is filled with 1
% and all other regions are by default filled with 0
mask=warpH(mask,H_template_to_img,size(img));
%% Warp template by appropriate homography
% fill the book cover area with Harry Potter's cover
% other regions are by default filled with 0
template=warpH(template,H_template_to_img,size(img));
%% Use mask to combine the warped template and the image
% copy the background image
composite_img=img;
% replace the masked region with Harry Potter's cover
composite_img(mask~=0)=template(mask~=0);
end