function out = dlTempFunc(outvars)

	[outvars{:}] = solve_ode_20220402075405_490_mex();
	out = outvars;

end