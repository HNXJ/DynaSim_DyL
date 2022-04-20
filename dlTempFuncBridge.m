function out = dlTempFuncBridge(dlOutputs, dlTimeInterval)

	[outvars{:}] = testCustomKernel(dlOutputs, dlTimeInterval);
	out = outvars;

end