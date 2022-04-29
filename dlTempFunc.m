function out = dlTempFunc(outvars)

	[outvars{:}] = solve_ode_20220429140437_210_mex();
	out = outvars;

end