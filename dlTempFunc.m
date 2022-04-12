function out = dlTempFunc(outvars)

	[outvars{:}] = solve_ode_20220412163712_709_mex();
	out = outvars;

end