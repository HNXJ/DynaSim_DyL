function out = dlTempFunc(outvars)

	[outvars{:}] = solve_ode_20220504075415_634_mex();
	out = outvars;

end