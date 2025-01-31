% Split the image
    % Input 
        % filepath = 'graygroundtruth.jpg';
        % filepath = 'graycapture.jpg';
        % filepath = '/Users/Brian/Desktop/link_game/process/graygroundtruth.jpg';
        % filepath = '/Users/Brian/Desktop/link_game/process/graycapture.jpg';
    % Output
        % {target: 1x84 cell} 
        % Show: 12*7 target pictures
        
% Usage:
    % extract_gray('/Users/Brian/Desktop/link_game/process/graygroundtruth.jpg');
    % extract_gray('/Users/Brian/Desktop/link_game/process/graycapture.jpg');
    
function target = extract_gray(filepath)

    close all;

    target = {};
    original_pic = imread(filepath, 'jpg');
    pic  = double(original_pic);
        % imshow(pic);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Vertical
    % Caluculate mean in vertical
    vertical_mean_vec = mean( pic - mean(mean(pic)) ) ;
        figure;
        plot(vertical_mean_vec);
    %     xlim([-5 1020]);ylim([-160 120]);

    % FFT
    freq_domain = fft(vertical_mean_vec);

    % Half
    freq_domain = freq_domain(1:ceil(length(freq_domain) / 2));
    %     figure;
    %     plot(abs(freq_domain));

    v_len = length(vertical_mean_vec);
    f = [0:v_len-1] / v_len;

    base_position = find_base(freq_domain);
    v_period = round(1 / f(base_position));

    base = freq_domain(base_position);

    v_s = angle(base) * 180/pi / 360 * v_period;

    % Draw segment on cos
    a = 80 * cos(2 * pi / v_period * ( [0:v_len-1] + v_s ));
    hold on;plot(a)


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Horizontal
    % Caluculate mean in horizontal
    horizontal_mean_vec = mean( pic - mean(mean(pic)) , 2) ;
        figure;
        plot(horizontal_mean_vec);
    %     xlim([-5 800]);ylim([-160 120]);

    % FFT
    freq_domain = fft(horizontal_mean_vec);

    % Half
    freq_domain = freq_domain(1:ceil(length(freq_domain) / 2));
    %     figure;
    %     plot(abs(freq_domain));

    h_len = length(horizontal_mean_vec);
    f = [0:h_len-1] / h_len;

    base_position = find_base(freq_domain);
    h_period = round(1 / f(base_position));

    base = freq_domain(base_position);

    h_s = angle(base) * 180/pi / 360 * h_period;

    % Draw segment on cos
    a = 80 * cos(2 * pi / h_period * ( [0:h_len-1] + h_s ));
    hold on;plot(a)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Draw output final split images

    row_len = round(v_len/v_period); % 13
    col_len = floor(h_len/h_period); % 8

    v_period; % 78
    h_period; % 96

    figure;
    row = abs(round(v_s)); % 31
    row_initial = row;
    col = abs(round(h_s)); % 43
    for i = 1 : col_len-1
        for j = 1 : row_len-1
            subplot(col_len-1, row_len-1, (i-1)*(row_len-1) + j );
            imshow( original_pic( col:col+h_period, row:row+v_period ) );
            target{(i-1)*(row_len-1) + j} = ...
                original_pic( col:col+h_period, row:row+v_period );
            row = row + v_period;
        end
        row = row_initial;
        col = col + h_period;    
    end
    
end


function base = find_base(freq_domain)

    % filter top
    maxx = max(abs(freq_domain));
    f = find(abs(freq_domain) > maxx*0.82);

    x = 1:length(freq_domain);
    % possible top
    possible_top = freq_domain(f);
    [val,index]=max(possible_top);
    base = x(f(index));

    err = 2;

    % ismember( find( (x>base/2-err & x<base/2+err) ), f )
    if sum(ismember( find( (x>=base/4-err & x<=base/4+err) ), f ))
        base = x( find( (x>=base/4-err & x<=base/4+err & ismember(x,x(f))) ) );
    elseif sum(ismember( find( (x>=base/3-err & x<=base/3+err) ), f ))
        base = x( find( (x>=base/3-err & x<=base/3+err & ismember(x,x(f))) ) );
    elseif sum(ismember( find( (x>=base/2-err & x<=base/2+err) ), f ))
        base = x( find( (x>=base/2-err & x<=base/2+err & ismember(x,x(f)) ) ) );
    end

    % If more than one base exist, give it with the biggest amp
    ans = find( ismember(x,base) );
    [val, index] = max( freq_domain( ans ) );

    base = x( ans(index) );

end

