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

    % order of the high pass
    order = 10;
    
    % 1 dim high pass
    filter_1 = fir1(order, 0.5, 'high');
    % initialize for 2 dim
    filter_2 = zeros(order + 1);
    center = order/2 + 1;
    
    for row = 1 : order+1
        for col = 1 : order+1
            r = round( sqrt( (row-center)^2 + (col-center)^2 ) );
            if r > center - 1
                filter_2(row,col) = 0;
            else
                filter_2(row,col) = filter_1(center-r);
            end
        end
    end
    
    % filter
    high_passed_image = filter2(filter_2, img);
    
end

% Calculate Max Cor of p1, p2
function max_cor = cal_cor(p1, p2)
    a = normxcorr2(p1,p2);
    max_cor = max(max(a));
end

