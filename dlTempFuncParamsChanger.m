function dlTempFuncParamsChanger(dlPath)

	p = load([dlPath, '/params.mat']);

	if sum(strcmpi(fieldnames(p.p), 'SA1_ctx_iPoisson_DC_poisson'))
		p.p.SA1_ctx_iPoisson_DC_poisson = 30000000;
	else
		fprintf("Parameter or variable 'SA1_ctx_iPoisson_DC_poisson' not found in params.mat file. Check if you are refering to a correct variable.\n");
	end

	if sum(strcmpi(fieldnames(p.p), 'SA1_ctx_iPoisson_offset_poisson'))
		p.p.SA1_ctx_iPoisson_offset_poisson = 250;
	else
		fprintf("Parameter or variable 'SA1_ctx_iPoisson_offset_poisson' not found in params.mat file. Check if you are refering to a correct variable.\n");
	end

	if sum(strcmpi(fieldnames(p.p), 'SA1_ctx_iPoisson_onset_poisson'))
		p.p.SA1_ctx_iPoisson_onset_poisson = 150;
	else
		fprintf("Parameter or variable 'SA1_ctx_iPoisson_onset_poisson' not found in params.mat file. Check if you are refering to a correct variable.\n");
	end

	if sum(strcmpi(fieldnames(p.p), 'SA2_ctx_iPoisson_DC_poisson'))
		p.p.SA2_ctx_iPoisson_DC_poisson = 30000000;
	else
		fprintf("Parameter or variable 'SA2_ctx_iPoisson_DC_poisson' not found in params.mat file. Check if you are refering to a correct variable.\n");
	end

	if sum(strcmpi(fieldnames(p.p), 'SA2_ctx_iPoisson_offset_poisson'))
		p.p.SA2_ctx_iPoisson_offset_poisson = 350;
	else
		fprintf("Parameter or variable 'SA2_ctx_iPoisson_offset_poisson' not found in params.mat file. Check if you are refering to a correct variable.\n");
	end

	if sum(strcmpi(fieldnames(p.p), 'SA2_ctx_iPoisson_onset_poisson'))
		p.p.SA2_ctx_iPoisson_onset_poisson = 250;
	else
		fprintf("Parameter or variable 'SA2_ctx_iPoisson_onset_poisson' not found in params.mat file. Check if you are refering to a correct variable.\n");
	end

	if sum(strcmpi(fieldnames(p.p), 'SB1_ctx_iPoisson_DC_poisson'))
		p.p.SB1_ctx_iPoisson_DC_poisson = 30000000;
	else
		fprintf("Parameter or variable 'SB1_ctx_iPoisson_DC_poisson' not found in params.mat file. Check if you are refering to a correct variable.\n");
	end

	if sum(strcmpi(fieldnames(p.p), 'SB1_ctx_iPoisson_offset_poisson'))
		p.p.SB1_ctx_iPoisson_offset_poisson = 250;
	else
		fprintf("Parameter or variable 'SB1_ctx_iPoisson_offset_poisson' not found in params.mat file. Check if you are refering to a correct variable.\n");
	end

	if sum(strcmpi(fieldnames(p.p), 'SB1_ctx_iPoisson_onset_poisson'))
		p.p.SB1_ctx_iPoisson_onset_poisson = 250;
	else
		fprintf("Parameter or variable 'SB1_ctx_iPoisson_onset_poisson' not found in params.mat file. Check if you are refering to a correct variable.\n");
	end

	if sum(strcmpi(fieldnames(p.p), 'SB2_ctx_iPoisson_DC_poisson'))
		p.p.SB2_ctx_iPoisson_DC_poisson = 30000000;
	else
		fprintf("Parameter or variable 'SB2_ctx_iPoisson_DC_poisson' not found in params.mat file. Check if you are refering to a correct variable.\n");
	end

	if sum(strcmpi(fieldnames(p.p), 'SB2_ctx_iPoisson_offset_poisson'))
		p.p.SB2_ctx_iPoisson_offset_poisson = 350;
	else
		fprintf("Parameter or variable 'SB2_ctx_iPoisson_offset_poisson' not found in params.mat file. Check if you are refering to a correct variable.\n");
	end

	if sum(strcmpi(fieldnames(p.p), 'SB2_ctx_iPoisson_onset_poisson'))
		p.p.SB2_ctx_iPoisson_onset_poisson = 350;
	else
		fprintf("Parameter or variable 'SB2_ctx_iPoisson_onset_poisson' not found in params.mat file. Check if you are refering to a correct variable.\n");
	end

	if sum(strcmpi(fieldnames(p.p), 'SC1_ctx_iPoisson_DC_poisson'))
		p.p.SC1_ctx_iPoisson_DC_poisson = 30000000;
	else
		fprintf("Parameter or variable 'SC1_ctx_iPoisson_DC_poisson' not found in params.mat file. Check if you are refering to a correct variable.\n");
	end

	if sum(strcmpi(fieldnames(p.p), 'SC1_ctx_iPoisson_offset_poisson'))
		p.p.SC1_ctx_iPoisson_offset_poisson = 250;
	else
		fprintf("Parameter or variable 'SC1_ctx_iPoisson_offset_poisson' not found in params.mat file. Check if you are refering to a correct variable.\n");
	end

	if sum(strcmpi(fieldnames(p.p), 'SC1_ctx_iPoisson_onset_poisson'))
		p.p.SC1_ctx_iPoisson_onset_poisson = 250;
	else
		fprintf("Parameter or variable 'SC1_ctx_iPoisson_onset_poisson' not found in params.mat file. Check if you are refering to a correct variable.\n");
	end

	if sum(strcmpi(fieldnames(p.p), 'SC2_ctx_iPoisson_DC_poisson'))
		p.p.SC2_ctx_iPoisson_DC_poisson = 30000000;
	else
		fprintf("Parameter or variable 'SC2_ctx_iPoisson_DC_poisson' not found in params.mat file. Check if you are refering to a correct variable.\n");
	end

	if sum(strcmpi(fieldnames(p.p), 'SC2_ctx_iPoisson_offset_poisson'))
		p.p.SC2_ctx_iPoisson_offset_poisson = 350;
	else
		fprintf("Parameter or variable 'SC2_ctx_iPoisson_offset_poisson' not found in params.mat file. Check if you are refering to a correct variable.\n");
	end

	if sum(strcmpi(fieldnames(p.p), 'SC2_ctx_iPoisson_onset_poisson'))
		p.p.SC2_ctx_iPoisson_onset_poisson = 350;
	else
		fprintf("Parameter or variable 'SC2_ctx_iPoisson_onset_poisson' not found in params.mat file. Check if you are refering to a correct variable.\n");
	end

	if sum(strcmpi(fieldnames(p.p), 'tspan'))
		p.p.tspan = [ 0 500];
	else
		fprintf("Parameter or variable 'tspan' not found in params.mat file. Check if you are refering to a correct variable.\n");
	end

	save([dlPath, '/params.mat'], '-struct', 'p');

end