function steps = omg(mtx)
    % -------------- �������˵�� --------------
    
    %   ��������У�mtxΪͼ���ľ������������ĸ�ʽ��
    %   [ 1 2 3;
    %     0 2 1;
    %     3 0 0 ]
    %   ��ͬ�����ִ�����ͬ��ͼ����0����˴�û�п顣
    %   ������[m, n] = size(mtx)��ȡ������������
    
    %   ע��mtx��������Ϸ�����ͼ����λ�ö�Ӧ��ϵ���±�(x1, y1)��������������
    %   ������������½�Ϊԭ�㽨������ϵ��x�᷽���x1����y�᷽���y1��
    
    % --------------- �������˵�� --------------- %
    
    %   Ҫ�����ó��Ĳ����������steps������,��ʽ���£�
    %   steps(1)��ʾ��������
    %   ֮��ÿ�ĸ���x1 y1 x2 y2�������mtx(x1,y1)��mtx(x2,y2)��ʾ�Ŀ�������
    %   ʾ���� steps = [2, 1, 1, 1, 2, 2, 1, 3, 1];
    %   ��ʾһ������������һ����mtx(1,1)��mtx(1,2)��ʾ�Ŀ�������
    %   �ڶ�����mtx(2,1)��mtx(3,1)��ʾ�Ŀ�������
    
    %% --------------  �������������Ĵ��� O(��_��)O~  ------------
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

