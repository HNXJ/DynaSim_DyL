function out = dlTempFunc(outvars)

	[outvars{:}] = solve_ode_20220417122353_633_mex();
	out = outvars;

end