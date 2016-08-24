% Problem 6, Simulate the play

% Preprocess:
    % file = '/Users/Brian/Desktop/link_game/process/graygroundtruth.jpg';
    % target = extract_gray(file);
    % Similarity = match_patterns(target);
    % threshold = 0.8;
    % mtx = get_mtx(Similarity, target, threshold);

% Input:
    % [7x12 mtx], {1x84 target}
    
% Usage: 
    % sim_play(mtx, target)

function sim_play(mtx, target)

    % Turn {1x84 target} into {7x12}
    target = reshape(target,[12,7]);
    target = target';
    % Draw target
%     figure;
    for i = 1:7
        for j = 1:12
            subplot( 8,12, (i-1)*12+j );
            imshow(target{i,j});
        end
    end
    pause(1);

	steps = omg(mtx);
    step_num = steps(1);
    for i = 1:step_num
        x1 = steps( (i-1)*4+2 );
        y1 = steps( (i-1)*4+3 );
        x2 = steps( (i-1)*4+4 );
        y2 = steps( (i-1)*4+5 );
        
        % Show two target
        subplot( 8,12, 85:90 );
        imshow(target{x1,y1});title('target 1');
        subplot( 8,12, 91:96 );
        imshow(target{x2,y2});title('target 2');
        
        % Erase the two targets
        subplot( 8,12, (x1-1)*12+y1 );
        imshow(zeros(66,54));set(gca,'xcolor',[1 0 0],'ycolor',[1 0 0]) 
        subplot( 8,12, (x2-1)*12+y2 );
        imshow(zeros(66,54));set(gca,'xcolor',[1 0 0],'ycolor',[1 0 0]) 
        
        % Pause for 0.5 second
        pause(0.3);
    end
end