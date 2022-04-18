function out = dlTempFunc(outvars)

	[outvars{:}] = solve_ode_20220417124217_213_mex();
	out = outvars;

end