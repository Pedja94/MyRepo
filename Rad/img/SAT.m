function sumAreaTable = SAT( table )
    
    [n, m] = size(table);
    
    for jj = 2:m
        table(:, jj) = table(:, jj) + table(:, jj - 1);
    end
    
    for ii = 2:n
        table(ii, :) = table(ii, :) + table(ii - 1, :);
    end
    
    sumAreaTable = table;
end

