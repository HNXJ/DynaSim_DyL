function out = dlTempFunc(outvars)

	[outvars{:}] = solve_ode_20220416171024_853_mex();
	out = outvars;

end