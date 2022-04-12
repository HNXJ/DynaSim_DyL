function dlTempFuncParamsChanger(dlPath)

	p = load([dlPath, 'params.mat']);

	p.p.q = 'fff';
	p.p.qw = 1.142000e+02;
	p.p.tspan = 0;
	p.p.d = 
	save([obj.dlPath, '/params.mat'], '-struct', 'p');

end