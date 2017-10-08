function res = Slike( I, r, eps, name)

Id = im2double(I);

Id = guidedFilterGray(Id, Id, r, eps);

Id = im2uint8(Id);

imwrite(Id, name);

imshow(Id);

res = Id;

end

