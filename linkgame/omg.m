function steps = omg(mtx)
    % -------------- 输入参数说明 --------------
    
    %   输入参数中，mtx为图像块的矩阵，类似这样的格式：
    %   [ 1 2 3;
    %     0 2 1;
    %     3 0 0 ]
    %   相同的数字代表相同的图案，0代表此处没有块。
    %   可以用[m, n] = size(mtx)获取行数和列数。
    
    %   注意mtx矩阵与游戏区域的图像不是位置对应关系。下标(x1, y1)在连连看界面中
    %   代表的是以左下角为原点建立坐标系，x轴方向第x1个，y轴方向第y1个
    
    % --------------- 输出参数说明 --------------- %
    
    %   要求最后得出的操作步骤放在steps数组里,格式如下：
    %   steps(1)表示步骤数。
    %   之后每四个数x1 y1 x2 y2，代表把mtx(x1,y1)与mtx(x2,y2)表示的块相连。
    %   示例： steps = [2, 1, 1, 1, 2, 2, 1, 3, 1];
    %   表示一共有两步，第一步把mtx(1,1)和mtx(1,2)表示的块相连，
    %   第二步把mtx(2,1)和mtx(3,1)表示的块相连。
    
    %% --------------  请在下面加入你的代码 O(∩_∩)O~  ------------
    steps = [];
    [m, n] = size(mtx);
    
    % An array of unique pattern number
    patterns = unique(mtx);

    for i = 1:length(patterns)
        p = patterns(i);
        if p ~= 0
            target_array = [];

            target = find(mtx == p);
            for x = 1:length(target)
                y = target(x);
                target_array = [target_array, y];
            end
            eval(['target_array_' num2str(p) '=target_array;']); 
            % target_array_1 = target_array;
        end
    end

    continue_flag = 1;
    while (continue_flag == 1)
        continue_flag = 0;
        for i = 1:length(patterns)
            p = patterns(i);
            if p ~= 0
                
                eval(['target_array=target_array_' num2str(p) ';']); 
                % target_array = target_array_1;
                
                break_flag = 0;
                for j = 1:length(target_array)
                    t = target_array(j);

                    m1 = mod(t, m);
                    n1 = ceil(t/m);
                    if m1 == 0
                        m1 = m;
                    end
                    
                    for l = 1:length(target_array)
                        r = target_array(l);

                        m2 = mod(r, m);
                        n2 = ceil(r/m);
                        if m2 == 0
                            m2 = m;
                        end
                        
                        if detect(mtx, m1, n1, m2, n2)
                            steps = [steps, m1, n1, m2, n2];
                            
                            % Delete item
                            target_array([j,l]) = [];
                            mtx([t,r]) = 0;

                            break_flag = 1;
                            break;
                        end
                    end

                    if break_flag == 1
                        eval(['target_array_' num2str(p) '=target_array;']);
                        % target_array_1 = target_array;

                        if length(target_array) ~= 0
                            continue_flag = 1;
                        end
                        
                        break;
                    else
                        if length(target_array) ~= 0
                            continue_flag = 1;
                        end
                    end

                end

            end
        end

    end
    steps = [length(steps)/4, steps];


end

