function dsMexBridge(tempfuncname, mexfilename)

    fileID = fopen(tempfuncname, 'w');
    fprintf(fileID,'function out = dsTempFunc(outvars)\n\n\t[outvars{:}] = %s();\n\tout = outvars;\n\nend', mexfilename);
    fclose(fileID);

end