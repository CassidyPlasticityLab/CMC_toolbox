function cohSquare = cohAllReg(regions, fd)
%Create empty matrix for cohSquare
cohSquare = cell(size(regions, 2)+1, size(regions, 2)+1);

%Create x and y labels corresponding to ROIs
yLabel = horzcat(' ', regions(1, :));
xLabel = horzcat(' ', regions(1, :))';

%Define length of index
range = (size(regions, 2)+1);

%Create coherence value upper triangle matrix for left sided stroke
if fd.lesion_side =='l'
    parfor i = 2:range
        for j = 2:range
            if i <= j
                cohSquare{i, j} = getCoh(regions{2, i-1}, regions{2, j-1}, fd);
            end
        end
    end
    %Create coherence value upper triangle matrix for right sided stroke
else fd.lesion_side == 'r'
    parfor i = 2:range
        for j = 2:range
            if i <= j
                cohSquare{i, j} = getCoh(regions{5, i-1}, regions{5, j-1}, fd);
            end
        end
    end
end

cohSquare(1, :) = xLabel;
cohSquare(:, 1) = yLabel;

end
