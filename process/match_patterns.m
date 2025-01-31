% Match Patterns
    % Preprocess:
        % target = extract_gray('/Users/Brian/Desktop/link_game/process/graycapture.jpg');
    % Input: 
        % {target} 1x84 cell
    % Return:
        % [ 84x84 row indicate Similarity]
        
% Usage:
    % Similarity = match_patterns(target);

function Similarity = match_patterns(target)

    len = length(target);

    % High pass
    high_passed_target = {};
    for i = 1:len
        high_passed_target{i} = high_pass(target{i});
    end
    
    % Match Similarity
    Similarity = zeros(len,len);
    for i = 1: len
        for j = i+1 : len
            
            % Load Pic
            p1 = high_passed_target{i};
            p2 = high_passed_target{j};
            
            % Calculate Max Cor
            max_cor = cal_cor(p1,p2);
            
            % Save to [Similarity]
            Similarity(i,j) = max_cor;
            Similarity(j,i) = max_cor;
        end
    end
    
    % Return [ 84x84 Similarity ]
end

% High Pass
function high_passed_image = high_pass(img)

    % 1 dim high pass
    dim_1_filter = fir1(10, 0.5, 'high');
    
    % initialize for 2 dim
    dim_2_filter = zeros(order + 1);
    % Generate 2 dim filter
    middle = order/2 + 1;
    for row = 1 : order+1
        for col = 1 : order+1
            d = round( sqrt( (row-middle)^2 + (col-middle)^2 ) );
            if d > middle - 1
                dim_2_filter(row,col) = 0;
            else
                dim_2_filter(row,col) = dim_1_filter(middle-r);
            end
        end
    end
    
    % filter
    high_passed_image = filter2(dim_2_filter, img);
    
end

% Calculate Max Cor of p1, p2
function cor_max = cal_cor(im1, im2)

    % Preprocess
    im1 = double(im1);
    im2 = double(im2);

    
    % Discard the (side_ratio) part of the img
    side_ratio = 0.1;
    
    % Calculate Margin
    im_size = size(im1);
    height = im_size(1);
    width = im_size(2);
    
    margin = round( side_ratio * im_size );
    left_margin = margin(2);
    right_margin = width - margin(2);
    
    up_margin = margin(1);
    down_margin = height - margin(1);
    
    
    % Calculate Cor using mormxcorr2
    cor_1 = normxcorr2(...
        im1(up_margin:down_margin,...
            left_margin:right_margin), im2);
    cor_2 = normxcorr2(...
        im2(up_margin:down_margin,...
            left_margin:right_margin), im1);
    cor_max = max( max(max(cor_1)), max(max(cor_2)) );

end

