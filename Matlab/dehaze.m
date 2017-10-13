function Res = dehaze( Img, Rgf, EPSgf, Rdc, DehazingLVL)

    r = Rdc;
    [n, m, ~] = size(Img);
    I(1:(n + 2*r), 1:(m + 2*r), 1:3) = 1;
    I((r + 1):(n + r), (r + 1):(m + r), 1:3) = Img(1:n, 1:m, 1:3);
    Idark = zeros(n, m);
      
    for ii = 1:n
        for jj = 1:m
            p = I(ii:(ii + 2*r), jj:(jj + 2*r), :);
            Idark(ii, jj) = min(p(:));
        end
    end

    A = guidedfilter(rgb2gray(Img), Idark, Rgf, EPSgf);  
    Diff = abs(Idark - A);
    C = guidedfilter(rgb2gray(Img), Diff, Rgf, EPSgf);
    B = A - C;
    V = zeros(n, m);
    V(:, :) = ((B(:, :) >= 0) .* (B(:, :) <= 1) .* B(:, :)) + (B(:, :) > 1);
    w = DehazingLVL;
    Itrans = 1 - w * V;

    %A(1, 1, 1)
    Res = Img - (1 - cat(3, Itrans, Itrans, Itrans));
    Res = Res ./ cat(3, Itrans, Itrans, Itrans);
    
    figure;
    imshow(Res);
end

