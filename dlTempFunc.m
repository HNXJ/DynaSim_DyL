function out = dlTempFunc(outvars)

	[outvars{:}] = solve_ode_20220406132637_392_mex();
	out = outvars;

end