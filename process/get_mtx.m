% Problem 5
% Output the game map [mtx], draw patterns of 19 kinds
    % Input [84x84 Similarity], {1x84 target}, (threshold)
    % return [a matrix mtx]

% Usage: mtx = get_mtx(Similarity, target, threshold)

function mtx = get_mtx(Similarity, target, threshold)

    % Turn [ 84x84 Matrix ] to [ 1 x (84*84) row ]
    Similarity = Similarity';
    Similarity_row = ( Similarity(:) )';

    % Length, 7056 (84*84)
    len_similarity = length(Similarity_row);
    % Image number, 84
    img_num = length(target);
    
    % Initialize output
    mtx = zeros(1, img_num);
    % Initialize pattern num
    pattern_num = 1;
    
    % Sort the 7056 Similarity
    [val, index] = sort(Similarity_row, 'descend');
    
    for i = 1:len_similarity 
        
        % Calculating photo index in {target}
        img_index = index(i);
        p1_index = floor( (img_index-1) / img_num ) + 1;
        p2_index = mod( img_index, img_num );
        if p2_index == 0
            p2_index = img_num; %84
        end
        
        % Don't count both~
        if p1_index < p2_index
            if val(i) > threshold
                
                % New pattern
                if ( mtx(p1_index) == 0 ) & ( mtx(p2_index)==0 )
                    mtx(p1_index) = pattern_num;
                    mtx(p2_index) = pattern_num;
                    pattern_num = pattern_num + 1;
                    
                % One new, one old    
                elseif mtx(p1_index) == 0
                    mtx(p1_index) = mtx(p2_index);                    
                elseif mtx(p2_index) == 0
                    mtx(p2_index) = mtx(p1_index); 
                    
                % Conflict
                elseif mtx(p1_index) ~= mtx(p2_index)
                    mtx( find(mtx==mtx(p1_index)) ) = mtx(p2_index);
                end
                
            end
        end
    end
    
    % Make sure the pattern # is the smallest
    for i = 1:length( unique(mtx) )
        max_patternnum = max(mtx);
        if length( find(mtx == i) )==0
            mtx( find(mtx==max_patternnum) )=i;
        end
    end
    
    % Draw patterns
    figure;
    for i = 1:length( unique(mtx) )
        temp = target{ find(mtx==i,1) };
        subplot(4,5,i);
        imshow(temp);
        title(['index: ' num2str(i)])
    end
        
    % Reshape into 7x12
    mtx = reshape(mtx, [12,7]);
    mtx = mtx' ;
    
end