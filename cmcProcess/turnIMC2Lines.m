function IMC2Lines = turnIMC2Lines(coh);

fields = fieldnames(coh);
for i = 23:30
    for j = 2:length(fields)
        tempMatrix = coh.(fields{j})';
        A(2, :) = tempMatrix(24:30, 23);
        B(2, :) = tempMatrix(25:30, 24);
        C(2, :) = tempMatrix(26:30, 25);
        D(2, :) = tempMatrix(27:30, 26);
        E(2, :) = tempMatrix(28:30, 27);
        F(2, :) = tempMatrix(29:30, 28);
        G(2, :) = tempMatrix(30, 29);
        
        
        label2Line = {'left_extensor__right_extensor', 'left_extensor__left_flexor', 'left_extensor__right_flexor', 'left_extensor__left_interossei', 'left_extensor__right_interossei', 'left_extensor__left_biceps', 'left_extensor__right_biceps', 'right_extensor__left_flexor', 'right_extensor__right_flexor', 'right_extensor__left_interossei', 'right_extensor__right_interossei', 'right_extensor__left_biceps', 'right_extensor__right_biceps', 'left_flexor__right_flexor',  'left_flexor__left_interossei', 'left_flexor__right_interossei', 'left_flexor__left_biceps', 'left_flexor__right_biceps', 'right_flexor__left_interossei', 'right_flexor__right_interossei', 'right_flexor__left_biceps', 'right_flexor__right_biceps', 'left_interossei__right_interossei', 'left_interossei__left_biceps', 'left_intorossei__right_biceps', 'right_interossei__left_biceps', 'right_interossei__right_biceps', 'left_biceps__right_biceps'};
        
        
        IMC2Lines.(fields{j}) = horzcat(A,B,C,D,E,F,G);
        
        for k = 1:length(label2Line)
            IMC2Lines.(fields{j}){1, k} = label2Line{1, k};
        end
    end
end