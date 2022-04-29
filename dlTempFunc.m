function out = dlTempFunc(outvars)

	[outvars{:}] = solve_ode_20220429173015_709_mex();
	out = outvars;

end