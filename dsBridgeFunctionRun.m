function dsBridgeFunctionRun(dlOutputType)

    tempfuncname = 'dlTempFuncBridge.m';
    fileID = fopen(tempfuncname, 'w');
    fprintf(fileID, 'function out = dlTempFuncBridge(dlOutputs, dlTimeInterval)\n\n\t[outvars{:}] = %s(dlOutputs, dlTimeInterval);\n\tout = outvars;\n\nend', dlOutputType);
    fclose(fileID);

end