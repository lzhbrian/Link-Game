
% Full Process:
file = '/Users/Brian/Desktop/link_game/process/graycapture.jpg';
% file = '/Users/Brian/Desktop/link_game/process/graygroundtruth.jpg';
target = extract_gray(file);
Similarity = match_patterns(target);

% Prob 3 right match:1~10
% Show_10(Similarity, target, 1);
% Prob 4 miss match:183~192
% Show_10(Similarity, target, 181);
% Show_10(Similarity, target, 191);

% Prob 5 show patterns, return mtx
threshold = 0.8;
mtx = get_mtx(Similarity, target, threshold);

% Prob 6 simulate play
% sim_play(mtx, target)