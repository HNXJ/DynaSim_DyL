function out = dlTempFunc(outvars)

	[outvars{:}] = solve_ode_20220429032828_906_mex();
	out = outvars;

end