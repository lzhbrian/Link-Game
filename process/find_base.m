function base = find_base(freq_domain)

    % filter top
    maxx = max(abs(freq_domain));
    f = find(abs(freq_domain) > maxx*0.1);

    x = 1:length(freq_domain);
    % possible top
    possible_top = freq_domain(f);
    [val,index]=max(possible_top);
    base = x(f(index));

    err = 3;

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