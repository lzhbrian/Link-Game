for i = 1:5
    Show_10(Similarity, target, (i-1)*10+1);
end


target = extract_gray('/Users/Brian/Desktop/link_game/process/graygroundtruth.jpg');
% target = extract_gray('/Users/Brian/Desktop/link_game/process/graycapture.jpg');

Similarity = match_patterns(target);

for i = 1:20
    Show_10(Similarity, target, (i-1)*10+1);
end

ccdf=1-ecdf(Similarity(:));
plot(ccdf);