function cmcLatIndex = getCMCLatIndex(coh2Lines)

ipsiLabelCol = find(contains(coh2Lines.allFreq(1, :), '__left'));
contraLabelCol = find(contains(coh2Lines.allFreq(1, :), '__right'));

fields = fieldnames(coh2Lines);
for i = 1:length(fields)
    for j =  1:72
        ipsiValue.(fields{i}){j} = coh2Lines.(fields{i}){2, ipsiLabelCol(j)};
        contraValue.(fields{i}){j} = coh2Lines.(fields{i}){2, contraLabelCol(j)};
        cmcLatIndexVal.(fields{i}){j} = (ipsiValue.(fields{i}){j} - contraValue.(fields{i}){j}) ./ (ipsiValue.(fields{i}){j} + contraValue.(fields{i}){j});

            ipsiLabel{j} = coh2Lines.allFreq{1, ipsiLabelCol(j)};
            newLabel{j} = erase(ipsiLabel{j}, '__left');
            cmcLatIndexLabel{j} = strcat(newLabel{j}, '_laterality_index');
    end
        cmcLatIndex.(fields{i}) = vertcat(cmcLatIndexLabel, cmcLatIndexVal.(fields{i}));
    end
    
  