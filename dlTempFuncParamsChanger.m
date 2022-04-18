function dlTempFuncParamsChanger(dlPath)

	p = load([dlPath, '/params.mat']);

	if sum(strcmpi(fieldnames(p.p), 'SA1_ctx_iPoisson_g_poisson'))
		p.p.SA1_ctx_iPoisson_g_poisson = 6.300000e-04;
	else
		fprintf("Parameter or variable 'SA1_ctx_iPoisson_g_poisson' not found in params.mat file. Check if you are refering to a correct variable.\n");
	end

	if sum(strcmpi(fieldnames(p.p), 'SA2_ctx_iPoisson_g_poisson'))
		p.p.SA2_ctx_iPoisson_g_poisson = 6.300000e-04;
	else
		fprintf("Parameter or variable 'SA2_ctx_iPoisson_g_poisson' not found in params.mat file. Check if you are refering to a correct variable.\n");
	end

	if sum(strcmpi(fieldnames(p.p), 'test_err'))
		p.p.test_err = 17;
	else
		fprintf("Parameter or variable 'test_err' not found in params.mat file. Check if you are refering to a correct variable.\n");
	end

	if sum(strcmpi(fieldnames(p.p), 'tspan'))
		p.p.tspan = [ 0 500];
	else
		fprintf("Parameter or variable 'tspan' not found in params.mat file. Check if you are refering to a correct variable.\n");
	end

	save([dlPath, '/params.mat'], '-struct', 'p');

end