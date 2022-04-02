function dsMexBridge(mexfilename)

    fileID = fopen('dsTempFunc.m', 'w');
    fprintf(fileID,'function out = dsTempFunc(outvars)\n\n\t[outvars{:}] = %s();\n\tout = outvars;\n\nend', mexfilename);
    fclose(fileID);

end