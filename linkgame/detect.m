function bool = detect(mtx, x1, y1, x2, y2)
    % ========================== ����˵�� ==========================
    
    % ��������У�mtxΪͼ���ľ������������ĸ�ʽ��
    % [ 1 2 3;
    %   0 2 1;
    %   3 0 0 ]
    % ��ͬ�����ִ�����ͬ��ͼ����0����˴�û�п顣
    % ������[m, n] = size(mtx)��ȡ������������
    % (x1, y1)�루x2, y2��Ϊ���жϵ�������±꣬���ж�mtx(x1, y1)��mtx(x2, y2)
    % �Ƿ������ȥ��
    
    % ע��mtx��������Ϸ�����ͼ����λ�ö�Ӧ��ϵ���±�(x1, y1)��������������
    % ������������½�Ϊԭ�㽨������ϵ��x�᷽���x1����y�᷽���y1��
    
    % �������bool = 1��ʾ������ȥ��bool = 0��ʾ������ȥ��
    
    %% �����������Ĵ���O(��_��)O
    
    [m, n] = size(mtx);
    if ~( (x1 == x2) & (y1 == y2) )
	    if mtx(x1, y1) == mtx(x2, y2)
	    	bool = directline(mtx, x1, y1, x2, y2) | ...
	    			one_turn(mtx, x1, y1, x2, y2) | ...
	    			two_turn(mtx, x1, y1, x2, y2);
		else
			bool = 0;
		end
	else
	    bool = 0;
	end
end

function bool = directline(mtx, x1, y1, x2, y2)
	
	% Initialize
	bool = 0;
	flag = 0;

	% Horizontal
	if x1 == x2
		if abs(y1-y2) == 1
			flag = 0;
		elseif y1 < y2
			for i = (y1+1):(y2-1)
				if mtx(x1, i) ~= 0
					flag = 1;
				end
			end
		elseif y1 > y2
			for i = (y2+1):(y1-1)
				if mtx(x1, i) ~= 0
					flag = 1;
				end
			end
		end
		if flag == 0
			bool = 1;
		end
	% Vertical
	elseif y1 == y2
		if abs(x1-x2) == 1
			flag = 0;
		elseif x1 < x2
			for i = (x1+1):(x2-1)
				if mtx(i, y1) ~= 0
					flag = 1;
				end
			end
		elseif x1 > x2
			for i = (x2+1):(x1-1)
				if mtx(i, y1) ~= 0
					flag = 1;
				end
			end
		end
		if flag == 0
			bool = 1;
		end
	end
end

function bool = one_turn(mtx, x1, y1, x2, y2)
	bool = 0;
	first_situation = directline(mtx, x1, y1, x2, y1) ...
					& directline(mtx, x2, y2, x2, y1) ...
					& (mtx(x2, y1) == 0);
	second_situation= directline(mtx, x1, y1, x1, y2) ...
					& directline(mtx, x2, y2, x1, y2) ...
					& (mtx(x1, y2) == 0);
	bool = first_situation | second_situation;
end

function bool = two_turn(mtx, x1, y1, x2, y2)
	flag = 0;
	bool = 0;
	[m, n] = size(mtx);
	
	% Augment
	augmented_mtx = [mtx;zeros(1,n)]; % down
	augmented_mtx = [augmented_mtx zeros(m+1,1)]; % right
	augmented_mtx = [zeros(1,n+1);augmented_mtx]; % up
	augmented_mtx = [zeros(m+2,1) augmented_mtx]; % left

	x1 = x1 + 1;
	y1 = y1 + 1;
	x2 = x2 + 1;
	y2 = y2 + 1;
	% Prolong
	[m, n] = size(augmented_mtx);
	for i = 1:m
		if (augmented_mtx(i,y1) == 0) & directline(augmented_mtx,i,y1,x1,y1) % Check if valid prolonged
			if one_turn(augmented_mtx,i,y1,x2,y2) % check if can one_turn 
				flag = 1;
				break;
			end
		end
	end
	if flag == 0
		for i = 1:n
			if (augmented_mtx(x1,i) == 0) & directline(augmented_mtx,x1,i,x1,y1) % Check if valid prolonged
				if one_turn(augmented_mtx,x1,i,x2,y2) % check if can one_turn 
					flag = 1;
					break
				end
			end
		end
	end
	% Final
	if flag == 1
		bool = 1;
	end
end


















