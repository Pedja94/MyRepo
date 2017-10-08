function outputImg = guidedFilter( inputImg, guideImg, kernelR, regParam )

    I = rgb2gray(guideImg);
    p = inputImg;
    
    q(:, :, 1) = guidedFilterGray(p(:, :, 1), I, kernelR, regParam);
    q(:, :, 2) = guidedFilterGray(p(:, :, 2), I, kernelR, regParam);
    q(:, :, 3) = guidedFilterGray(p(:, :, 3), I, kernelR, regParam);
    
    outputImg = q;
end

