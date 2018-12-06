function out = get_subwindow(im, pos, sz, cos_window)
%GET_SUBWINDOW Obtain sub-window from image, with replication-padding.
%   Returns sub-window of image IM centered at POS ([y, x] coordinates),
%   with size SZ ([height, width]). If any pixels are outside of the image,
%   they will replicate the values at the borders.
%
%   The subwindow is also normalized to range -0.5 .. 0.5, and the given
%   cosine window COS_WINDOW is applied (though this part could be omitted
%   to make the function more general).
%
%   Jo�o F. Henriques, 2012
%   http://www.isr.uc.pt/~henriques/

	if isscalar(sz)  %square sub-window :isscalar判断sz是否是标量,即一行一列的矩阵.
		sz = [sz, sz];
	end
	
	xs = floor(pos(2)) + (1:sz(2)) - floor(sz(2)/2); %得出截取区域相对与整张图片的坐标值
	ys = floor(pos(1)) + (1:sz(1)) - floor(sz(1)/2);
	
	%check for out-of-bounds coordinates, and set them to the values at
	%the borders
	xs(xs < 1) = 1;
	ys(ys < 1) = 1;
	xs(xs > size(im,2)) = size(im,2);
	ys(ys > size(im,1)) = size(im,1);
	
	%extract image
	out = im(ys, xs, :); %out的每一个值都是相应位置的像素值，像素值的范围为0-255
	
	%pre-process window
	out = double(out) / 255 - 0.5;  %normalize to range -0.5 .. 0.5
	out = cos_window .* out;  %apply cosine window

end

