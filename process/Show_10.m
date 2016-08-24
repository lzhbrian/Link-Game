% Problem 4 Show the right top 10 cor
    % Preprocess:
        % target = extract_gray('/Users/Brian/Desktop/link_game/process/graycapture.jpg');
        % Similarity = match_patterns(target);
    % Input:
        % [ 84x84 Similarity ], { 1x84 target }

% Usage:
    % Show_10(Similarity, target, start_index)
        % Print 10 pairs start from the (start_index)
        % (start_index) can be 1, 11, 21, ...
        
    % Problem 3 ans:
        % Show_10(Similarity, target, 1);
    % Problem 4 ans:
        % Show_10(Similarity, target, 181);
        % Show_10(Similarity, target, 191); % 183~192
        
    % Show Top 100:
        % for i = 1:10
        %   Show_10_(Similarity, target, (i-1)*10+1);
        % end
        
        
function Show_10(Similarity, target, start_index)

    % Turn [ 84x84 Matrix ] to [ 1 x (84*84) row ]
    Similarity = Similarity';
    Similarity_row = ( Similarity(:) )';

    % Length, 7056 (84*84)
    len_similarity = length(Similarity_row);
    % Image number, 84
    img_num = length(target);
    
    % Sort the 7056 Similarity
    [val, index] = sort(Similarity_row, 'descend');
    
    count = 0;
    figure;

    for i = 1:len_similarity 
        
        img_index = index(i);
        p1_index = floor( (img_index-1) / img_num ) + 1;
        p2_index = mod( img_index, img_num );
        if p2_index == 0
            p2_index = img_num; %84
        end
        
        % Don't count both~
        if p1_index < p2_index

            % Count to 10
            count = count + 1;
            
            if count >= start_index
            
                % subplot ID
                id = mod( 2*(count-1) + 1, 20);
                if id == 0
                    id = 20;
                end
                
                % Plot a pair
                subplot(10,2, id);
                imshow( target{p1_index} );
                ylabel( val(i*2) ); % Don't count both~

                subplot(10,2, id + 1);
                imshow( target{p2_index} );
            
            end
            
            % Count to 10
            if count >= start_index + 9
                break;
            end
        end
    end
    ax = axes('position',[0,0,1,1],'visible','off');
    tx = text(0.4,0.95,['index: ', num2str(start_index), ' to ', num2str(start_index+9)] );
    set(tx,'fontweight','bold');
    
end