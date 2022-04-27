function out = dlTempFunc(outvars)

	[outvars{:}] = solve_ode_20220426180341_429_mex();
	out = outvars;

end