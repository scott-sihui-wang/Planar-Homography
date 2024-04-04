% Q3.3.1
v_bg=loadVid('../data/book.mov');
v_fg=loadVid('../data/ar_source.mov');
im_ref=imread('../data/cv_cover.jpg');
result=VideoWriter('../result/ar.avi','Uncompressed AVI');
%result=VideoWriter('../result/ar.avi');
open(result);

for i=1:length(v_fg)
    im_bg=v_bg(i).cdata;
    [locs1,locs2]=matchPics(im_ref,im_bg);
    pairs=size(locs1,1);
    err_flag=false;
    if pairs>=4
        try
            [H_cur,~]=computeH_ransac(locs1, locs2);
        catch exception % there is an error in homography computation (for example, NaN or INF eigenvalues for SVD)
            if i>1 % use previous result if possible
                H_cur=H_prev;
                err_flag=true;
            else
                throw(exception)
            end
        end
        if err_flag==false && i>1
            dist=0; % check if there is drastic change of homography estimation between two consecutive frames
            for j=1:pairs
                p1=H_cur*[locs2(j,:),1]';
                p2=H_prev*[locs2(j,:),1]';
                dist=dist+norm(p1-p2);
            end
            dist=dist/pairs;
            if dist>30.0 % if the average motion of the matched features is too large, then current estimation is probably erroneous
                H_cur=H_prev; % in this case, use previous result
            end
        end
    else %not enough pairs of matching features for homography computation
        if i>1 % if this is not the first iteration, use previous result
            H_cur=H_prev;
        else % if this is the first iteration, report the error and quit
            fprintf('Unable to initialize. Cannot get enough matching pairs of points. Please reconfigure the parameters and restart the program.');
            break
        end
    end
    H_prev=H_cur; % store current estimation
    im_fg=v_fg(i).cdata;
    im_fg=im_fg(40:320, 200:440, :); % crop the movie frame
    im_fg=imresize(im_fg, size(im_ref));
    frame=compositeH(H_cur,im_fg,im_bg); % wrap the movie frame into the background frame
    %figure(1); % uncomment these two lines if you want visualzation 
    %imshow(frame);
    writeVideo(result,frame);
end

close(result);