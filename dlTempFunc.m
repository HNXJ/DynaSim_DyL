function out = dlTempFunc(outvars)

	[outvars{:}] = solve_ode_20220402085755_382_mex();
	out = outvars;

end