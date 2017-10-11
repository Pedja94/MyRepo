function Res = GF3( I, p, r, eps )

Res = zeros(size(p));

Res(:, :, 1) = guidedfilter(I(:, :, 1), p(:, :, 1), r, eps);
Res(:, :, 2) = guidedfilter(I(:, :, 2), p(:, :, 2), r, eps);
Res(:, :, 3) = guidedfilter(I(:, :, 3), p(:, :, 3), r, eps);

end

