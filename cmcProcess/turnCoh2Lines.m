function coh2Lines = turnCoh2Lines(coh);

fields = fieldnames(coh);
for i = 2:22
    for j = 2:length(fields)
        tempMatrix = coh.(fields{j})';
        A(2, :) = tempMatrix(23, 2:22);
        B(2, :) = tempMatrix(24, 2:22);
        C(2, :) = tempMatrix(25, 2:22);
        D(2, :) = tempMatrix(26, 2:22);
        E(2, :) = tempMatrix(27, 2:22);
        F(2, :) = tempMatrix(28, 2:22);
        G(2, :) = tempMatrix(29, 2:22);
        H(2, :) = tempMatrix(30, 2:22);
        label.(tempMatrix{23, 1}){i-1} = strcat(tempMatrix{23, 1}, '__',  tempMatrix{1, i});
        label.(tempMatrix{24, 1}){i-1} = strcat(tempMatrix{24, 1}, '__',  tempMatrix{1, i});
        label.(tempMatrix{25, 1}){i-1} = strcat(tempMatrix{25, 1}, '__',  tempMatrix{1, i});
        label.(tempMatrix{26, 1}){i-1} = strcat(tempMatrix{26, 1}, '__',  tempMatrix{1, i});
        label.(tempMatrix{27, 1}){i-1} = strcat(tempMatrix{27, 1}, '__',  tempMatrix{1, i});
        label.(tempMatrix{28, 1}){i-1} = strcat(tempMatrix{28, 1}, '__',  tempMatrix{1, i});
        label.(tempMatrix{29, 1}){i-1} = strcat(tempMatrix{29, 1}, '__',  tempMatrix{1, i});
        label.(tempMatrix{30, 1}){i-1} = strcat(tempMatrix{30, 1}, '__',  tempMatrix{1, i});
        
        labelFields = fieldnames(label)';
        label2Line = horzcat(label.(labelFields{1}), label.(labelFields{2}), label.(labelFields{3}), label.(labelFields{4}), label.(labelFields{5}), label.(labelFields{6}), label.(labelFields{7}), label.(labelFields{8}) );
        
        coh2Lines.(fields{j}) = horzcat(A,B,C,D,E,F,G,H);
        
        for k = 1:length(label2Line)
            coh2Lines.(fields{j}){1, k} = label2Line{1, k};
        end
    end
end