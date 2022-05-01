function out = dlTempFunc(outvars)

	[outvars{:}] = solve_ode_20220429030405_795_mex();
	out = outvars;

end