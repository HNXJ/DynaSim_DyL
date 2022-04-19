function out = dlTempFuncBridge(dlOutputs, dlTimeInterval)

	[outvars{:}] = F20-25HzLFP(dlOutputs, dlTimeInterval);
	out = outvars;

end