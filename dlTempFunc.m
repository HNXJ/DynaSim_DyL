function out = dlTempFunc(outvars)

	[outvars{:}] = solve_ode_20220413175612_732_mex();
	out = outvars;

end