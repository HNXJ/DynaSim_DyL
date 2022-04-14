function dsParamsModifier(tempfuncname, map)

    fileID = fopen(tempfuncname, 'w');
    fprintf(fileID, 'function dlTempFuncParamsChanger(dlPath)\n\n');
    fprintf(fileID, '\tp = load([dlPath, ''/params.mat'']);\n\n');
    n = size(map);
    
    labels = map.keys();
    values = map.values();
    
    for i = 1:n
    
        if strcmpi(class(values{1, i}), 'double')
            
            m = max(size(values{1, i}));
            if m == 1
                
                fprintf(fileID, '\tp.p.%s = %d;\n', labels{1, i}, values{1, i});
            
            else
                
                x = values{1, i};
                m = size(x, 1);
                l = size(x, 2);
                
                fprintf(fileID, '\tp.p.%s = [', labels{1, i});
                for i = 1:m
                    
                    if i > 1                    
                        fprintf(fileID, ';');
                    end
                    
                    for j = 1:l
                        fprintf(fileID, ' %d', x(i, j));
                    end
                    
                end
                fprintf(fileID, '];\n');
                
            end
            
        elseif ischar(values{1, i})
            
            fprintf(fileID, '\tp.p.%s = ''%s'';\n', labels{1, i}, values{1, i});
        
        else
            
            fprintf(fileID, '\tp.p.%s = %g;\n', labels{1, i}, values{1, i});
        
        end
        
    end
    
    fprintf(fileID, '\n\tsave([dlPath, ''/params.mat''], ''-struct'', ''p'');\n\nend');
    fclose(fileID);

end