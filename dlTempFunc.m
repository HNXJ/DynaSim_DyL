function out = dlTempFunc(outvars)

	[outvars{:}] = solve_ode_20220407074515_164_mex();
	out = outvars;

end