function res = Frame( img, r )

    [n, m] = size(img);
    res = zeros(n + 2*r, m + 2*r);
    res((r + 1):(n + r), (r + 1):(m + r)) = img(1:n, 1:m);
    
    tmp = res(r + 1, :);
    for ii = 1:r
        res(ii, :) = tmp;
    end
    tmp = res(n + r, :);
    for ii = (n + r + 1):(n + 2*r)
        res(ii, :) = tmp;
    end
    tmp = res(:, r + 1);
    for ii = 1:r
        res(:, ii) = tmp;
    end
    tmp = res(:, m + r);
    for ii = (m + r + 1):(m + 2*r)
        res(:, ii) = tmp;
    end
end

