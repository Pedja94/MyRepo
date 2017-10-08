function res = guidedFilterGray( p, I, r, regParam )
    
    %add frame
    p = Frame(p, r + 1);
    I = Frame(I, r + 1);
    
    %computing [Ak, Bk]
    tableI = SAT(I);
    tableP = SAT(p);
    tableIP = SAT(I .* p);
    tableII = SAT(I .* I);
    
    [n, m] = size(p);
    numOfPix = (2 * r + 1)^2;
    Ak = zeros(n, m);
    Bk = zeros(n, m);
    
    %main computation
    for ii = (r + 2):(n - r)
        for jj = (r + 2):(m - r)
            sumIP = tableIP(ii + r, jj + r) - tableIP(ii - r - 1, jj + r) ...
                - tableIP(ii + r, jj - r - 1) + tableIP(ii - r - 1, jj - r - 1);
            mean = (tableI(ii + r, jj + r) - tableI(ii - r - 1, jj + r) ...
                - tableI(ii + r, jj - r - 1) + tableI(ii - r - 1, jj - r - 1)) ...
                / numOfPix;
            variance = (tableII(ii + r, jj + r) - tableII(ii - r - 1, jj + r) ...
                - tableII(ii + r, jj - r - 1) + tableII(ii - r - 1, jj - r - 1)) ...
                / numOfPix - mean^2;
            meanP = (tableP(ii + r, jj + r) - tableP(ii - r - 1, jj + r) ...
                - tableP(ii + r, jj - r - 1) + tableP(ii - r - 1, jj - r - 1)) ...
                / numOfPix;
            
            Ak(ii, jj) = (sumIP / numOfPix - mean * meanP) / (variance + regParam);
            Bk(ii, jj) = meanP - Ak(ii, jj) * mean;
        end
    end
    
    %edge-top
    for jj = (r + 2):(m - r)
        sumIP = tableIP(2*r + 1, jj + r) - tableIP(2*r + 1, jj - r - 1);
        mean = (tableI(2*r + 1, jj + r) - tableI(2*r + 1, jj - r - 1)) / numOfPix;
        variance = (tableII(2*r + 1, jj + r) - tableII(2*r + 1, jj - r - 1)) ...
                / numOfPix - mean^2;
        meanP = (tableP(2*r + 1, jj + r) - tableP(2*r + 1, jj - r - 1)) ...
                / numOfPix;
            
        Ak(r + 1, jj) = (sumIP / numOfPix - mean * meanP) / (variance + regParam);
        Bk(r + 1, jj) = meanP - Ak(ii, jj) * mean;
    end
    
    %edge-left
    for ii = (r + 2):(n - r)
        sumIP = tableIP(ii + r, 2*r + 1) - tableIP(ii - r - 1, 2*r + 1);
        mean = (tableI(ii + r, 2*r + 1) - tableI(ii - r - 1, 2*r + 1)) / numOfPix;
        variance = (tableII(ii + r, 2*r + 1) - tableII(ii - r - 1, 2*r + 1)) ...
                / numOfPix - mean^2;
        meanP = (tableP(ii + r, 2*r + 1) - tableP(ii - r - 1, 2*r + 1)) ...
                / numOfPix;
            
        Ak(ii, r + 1) = (sumIP / numOfPix - mean * meanP) / (variance + regParam);
        Bk(ii, r + 1) = meanP - Ak(ii, jj) * mean;
    end
    
    %top-left corner
    sumIP = tableIP(2*r + 1, 2*r + 1);
    mean = tableI(2*r + 1, 2*r + 1) / numOfPix;
    variance = tableII(2*r + 1, 2*r + 1) ...
            / numOfPix - mean^2;
    meanP = tableP(2*r + 1, 2*r + 1) / numOfPix;
            
    Ak(r + 1, r + 1) = (sumIP / numOfPix - mean * meanP) / (variance + regParam);
    Bk(r + 1, r + 1) = meanP - Ak(r + 1, r + 1) * mean;
    
    %corners
    %top
    for ii = 1:r
        for jj = (r + 1):(m - r)
            Ak(ii, jj) = Ak(r + 1, jj);
            Bk(ii, jj) = Bk(r + 1, jj);
        end
    end
    
    %bottom
    for ii = (n - r + 1):n
        for jj = (r + 1):(m - r)
            Ak(ii, jj) = Ak(n - r, jj);
            Bk(ii, jj) = Bk(n - r, jj);
        end
    end
    
    %left
    for ii = 1:n
        for jj = 1:r
            Ak(ii, jj) = Ak(ii, r + 1);
            Bk(ii, jj) = Bk(ii, r + 1);
        end
    end
    
    %right
    for ii = 1:n
        for jj = (m - r + 1):m
            Ak(ii, jj) = Ak(ii, m - r);
            Bk(ii, jj) = Bk(ii, m - r);
        end
    end
    
    %computing q
    tableAk = SAT(Ak);
    tableBk = SAT(Bk);
    q = zeros(n, m);
    
    %main computation
    for ii = (r + 2):(n - r)
        for jj = (r + 2):(m - r)
            avgA = (tableAk(ii + r, jj + r) - tableAk(ii - r - 1, jj + r) ...
                - tableAk(ii + r, jj - r - 1) + tableAk(ii - r - 1, jj - r - 1)) ...
                / numOfPix;
            avgB = (tableBk(ii + r, jj + r) - tableBk(ii - r - 1, jj + r) ...
                - tableBk(ii + r, jj - r - 1) + tableBk(ii - r - 1, jj - r - 1)) ...
                / numOfPix;
            
            q(ii, jj) = avgA * I(ii ,jj) + avgB;
        end
    end
          
    res = q((r + 2):(n - r - 1), (r + 2):(m - r - 1));
end

