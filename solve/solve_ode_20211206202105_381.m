function [T,L1_v,L1_iNa_m,L1_iNa_h,L1_iK_n,L2_v,L2_iNa_m,L2_iNa_h,L2_iK_n,L3_v,L3_iNa_m,L3_iNa_h,L3_iK_n,L4_v,L4_iNa_m,L4_iNa_h,L4_iK_n,L5_v,L5_iNa_m,L5_iNa_h,L5_iK_n,L6_v,L6_iNa_m,L6_iNa_h,L6_iK_n,Input1_v,Input1_iNa_m,Input1_iNa_h,Input1_iK_n,Input2_v,Input2_iNa_m,Input2_iNa_h,Input2_iK_n,L2_L1_iGABAa_s,L1_L2_iGABAa_s,L2_L5_iAMPA_s,L5_L2_iGABA_s,L3_L2_iAMPA_s,L2_L3_iAMPA_s,L1_L4_iGABA_s,L4_L1_iGABA_s,L1_L3_iAMPA_s,L3_L1_iGABA_s,L5_Input1_iAMPA_s,L6_Input2_iAMPA_s,L5_L6_iAMPA_s,L4_L5_iAMPA_s,L1_v_spikes,L2_v_spikes,L3_v_spikes,L4_v_spikes,L5_v_spikes,L6_v_spikes,Input1_v_spikes,Input2_v_spikes,L1_L2_iGABAa_IGABAa,L1_L3_iAMPA_IAMPA,L1_L4_iGABA_IGABA,L2_L1_iGABAa_IGABAa,L2_L3_iAMPA_IAMPA,L2_L5_iAMPA_IAMPA,L3_L1_iGABA_IGABA,L3_L2_iAMPA_IAMPA,L4_L1_iGABA_IGABA,L4_L5_iAMPA_IAMPA,L5_Input1_iAMPA_IAMPA,L5_L2_iGABA_IGABA,L5_L6_iAMPA_IAMPA,L6_Input2_iAMPA_IAMPA,L2_L1_iGABAa_netcon,L1_L2_iGABAa_netcon,L2_L5_iAMPA_netcon,L5_L2_iGABA_netcon,L3_L2_iAMPA_netcon,L2_L3_iAMPA_netcon,L1_L4_iGABA_netcon,L4_L1_iGABA_netcon,L1_L3_iAMPA_netcon,L3_L1_iGABA_netcon,L5_Input1_iAMPA_netcon,L6_Input2_iAMPA_netcon,L5_L6_iAMPA_netcon,L4_L5_iAMPA_netcon]=solve_ode

% ------------------------------------------------------------
% Parameters:
% ------------------------------------------------------------
params = load('params.mat','p');
p = params.p;
downsample_factor=p.downsample_factor;
dt=p.dt;
T=(p.tspan(1):dt:p.tspan(2))';
ntime=length(T);
nsamp=length(1:downsample_factor:ntime);

% random_seed was set to shuffle earlier. 

% ------------------------------------------------------------
% Fixed variables:
% ------------------------------------------------------------
L2_L1_iGABAa_netcon = [+6.701658821447024e-01   +7.838695162552019e-02   +5.743181961786166e-01   +9.352448127770465e-01   +5.941879133778720e-01   +8.542379931014992e-01   +8.846076925066335e-01   +3.763055830204262e-01; +2.028591313546141e-01   +1.150066150840702e-01   +9.663960780999096e-01   +6.594226337239198e-01   +4.230929604878902e-01   +3.971037439356931e-01   +4.114384841222161e-02   +9.238268955926099e-01; +9.495177794636662e-01   +6.432024134588550e-01   +8.424215637484901e-01   +8.153499199239883e-01   +4.690752737770884e-01   +6.378895194850587e-01   +2.705133246339796e-01   +1.769784023381883e-01; +7.078203593838768e-01   +9.679025776822350e-01   +6.973673799476005e-01   +4.806231786663402e-01   +8.257609042730087e-01   +8.753065753215727e-02   +5.410106083932953e-01   +5.131027246143887e-01; +7.227096623659396e-01   +4.664717716535038e-03   +7.674130247663044e-01   +3.493447607703380e-01   -3.716362043871117e-04   +8.615767418550259e-01   +2.320992292506266e-03   +9.312999295413598e-01; +8.954056353782974e-01   +8.091353347764663e-01   +7.463315030120312e-01   +3.773080749535729e-01   -1.520559847717000e-02   +6.982548663207314e-01   +9.085347059058223e-01   +8.938403229701415e-01; +4.321715296028687e-01   +1.799058685501427e-01   +2.347582413304669e-01   +8.925351214675034e-01   +1.570534128283919e-01   +8.804667968211265e-01   +4.150221503457741e-02   +7.934894774708440e-01];
L1_L2_iGABAa_netcon = [+6.780921484301674e-01   +9.199151180741548e-01   +1.303330029601747e-01   +2.257520733378970e-01   +3.362762078198691e-01   +2.706539635828410e-01   +4.502674175285054e-01; +4.465365183227902e-01   +6.389770328566299e-01   +7.368583412199445e-01   +3.136913557951902e-01   +4.724251910584064e-01   +5.203752917682969e-01   +4.458914609995708e-01; +2.226852697145447e-01   +5.606454037522520e-01   +1.642349992646608e-01   +9.047108039935415e-01   +3.692832109839070e-01   +8.072916089272854e-02   +1.485260531452282e-01; +6.710192548045203e-02   +3.557980471758095e-01   +2.807507078073505e-01   +7.120988649136485e-01   +6.776066368434345e-01   +2.570567218788128e-02   +1.638788311589580e-01; +5.719289040839379e-01   -1.403165125535026e-02   +6.116901813653604e-01   +6.169069523134100e-01   +1.605836132110908e-01   +6.093299632280074e-02   +6.951511796369811e-02; +1.288187983085463e-01   +6.846338866855260e-01   +5.016660438213457e-01   +1.253562254242157e-01   +2.541933006953626e-01   +5.149880969650777e-01   +1.714567265610954e-02; +7.706864837183066e-01   +3.742843321747452e-01   +4.738500938521021e-01   +8.815246061068984e-01   +9.451002093460540e-01   +8.412431986934046e-01   +2.451243260917857e-01; +3.535241000773932e-01   +5.464846109548545e-01   +7.693764702269811e-02   +3.653560665273561e-01   +6.581012586292527e-01   +7.011224636538851e-01   +7.716114721110455e-01];
L2_L5_iAMPA_netcon = [+6.042718653781122e-01   +6.656312730119862e-01   +1.908153737538396e-01   +7.617569871866087e-01   +5.418928558413281e-01   +4.102586876706677e-01   +4.780608840546713e-01   +2.638135471813355e-01; +9.620595912444415e-01   +2.157091528498055e-02   +1.570089936119794e-01   +9.890166963800089e-02   +5.978017907145199e-01   +6.356534448029423e-01   +8.930180064067102e-02   +7.356705536519192e-02; +6.578138104416472e-01   +2.298863071517861e-01   +5.378391464470968e-01   +4.757676192480151e-01   +8.640107919187822e-01   +1.766885592146272e-01   +3.802512127335517e-02   +7.401309746446905e-01; +4.493020800717819e-01   +5.271323328394766e-01   +9.593781601542445e-01   +6.941841178255771e-02   +2.306094291205831e-01   +3.768443178367945e-01   +4.237828452584871e-01   +9.414845266547421e-01; +3.628778004704996e-01   +5.844205869599057e-01   +7.505650030719605e-01   +7.345564358688155e-01   +3.955146350921345e-01   +6.236045925378267e-03   +5.819114312263994e-01   +2.325929268859099e-01; +8.478818103898820e-01   +3.732630532114558e-01   +8.430917169537337e-01   +9.713771663038854e-01   +2.892690317185275e-01   +5.124875300418416e-01   +9.099464304091402e-02   +3.847022842635116e-01];
L5_L2_iGABA_netcon = [+4.598450446967330e-01   +2.216359782438181e-02   +1.073414563797578e-01   +8.955833863950958e-01   -1.383668863001685e-02   +6.235350301364735e-01; +4.444530611131519e-01   +2.048079179059048e-02   +6.233075627400722e-01   +8.719040476993210e-02   +9.223305946102760e-01   +4.922521218563249e-01; +1.199471940312517e-01   +7.579908200396199e-03   +6.249714708338613e-01   +4.003366356128182e-01   +7.696255925946963e-01   +6.347814405056847e-02; +8.129960221295557e-01   +5.085510310385120e-01   +5.551245333416144e-01   +6.282656232053492e-01   +1.962569661849053e-01   +8.115123058898925e-01; +3.097890438250626e-02   +2.301978113018407e-01   +2.612665442967225e-02   +9.074682939584275e-01   +2.358115138669100e-01   +3.528805390629604e-01; +2.782060613266949e-01   +5.077464619022213e-01   +9.483237701621240e-01   +2.812463904304861e-01   +2.368121805159863e-01   +2.431762541820710e-01; +2.721162333223306e-02   +1.585264790462188e-01   +2.829730631698498e-02   +8.022269946011846e-01   +7.348951535542871e-01   +3.514170829694623e-01; +4.090031580831061e-01   +5.612996476718286e-01   +7.328544487740020e-01   +7.896556075854089e-01   +1.051029866280112e-01   +5.993623608910993e-01];
L3_L2_iAMPA_netcon = [+2.093588531174499e-02   +4.679679793653250e-01   +8.815087454087804e-02   +7.945039145524216e-01   +4.378054446417283e-01; +8.908675375078877e-01   +3.315206920304637e-01   +7.597820095256212e-01   +3.652859378335416e-01   +8.593949466321366e-01; +4.280734865352280e-01   +7.377919304787500e-01   +3.411572822348063e-01   +3.328555485494736e-01   +3.854749345144183e-01; +8.927710535542709e-01   +8.987503504690900e-01   +9.402055659629044e-01   +8.580560951344730e-01   +7.022760803387059e-01; +3.643079411323263e-01   +9.235265977797820e-01   +5.388141630170559e-01   +7.164508996450081e-01   +7.485938259242275e-01; +4.798963296157778e-01   +1.172585406181288e-01   +6.514530881093779e-01   +5.363410613124254e-01   +3.290785139184390e-01; +3.389187850693355e-02   +4.235451829358396e-01   +3.699129783284978e-01   +5.103527174662309e-01   +8.535850232879135e-01; +6.145752687368963e-01   +3.682043951662696e-01   +2.666541656062061e-01   +5.867690031151001e-01   +7.584706442174819e-01];
L2_L3_iAMPA_netcon = [+7.070621912282194e-01   +5.600215413421947e-01   +1.735424266974509e-01   +3.876525748329412e-02   +2.303400599021888e-01   +3.598548182570757e-01   +6.446079136140063e-01   +8.483278918264895e-01; +3.342400691839179e-01   +5.181699581486287e-01   +8.086173413964401e-01   +3.102315638516487e-01   +3.105986436878925e-01   +7.835147048700929e-01   +4.006978239836114e-01   +7.528465641528157e-01; +6.109506248039021e-01   +6.480370450762664e-01   +1.272490525360242e-01   +5.778954774629269e-01   +9.742476716917668e-01   +7.945804478611602e-01   +4.532201253717865e-01   +8.037917945110116e-01; +2.631699063708386e-01   +1.576095704409412e-01   +4.617565224170079e-01   +4.349715096870167e-02   +7.801498761054631e-03   +7.060358798398481e-02   +7.586033992501736e-01   +3.457078487324521e-01; +5.808563305060917e-02   +4.885200906530437e-02   +1.688898151527813e-01   +3.334719582095780e-01   +2.955821061139546e-01   +7.151784250085235e-01   +6.328461832239312e-01   +4.765962368745676e-01];
L1_L4_iGABA_netcon = [+9.850142523538974e-01   +9.853533140482017e-01   +9.684478564092630e-01   +9.795030714623814e-01   +9.855617802840556e-01   +9.800355040220945e-01   +9.722149384323957e-01; +9.726125691859795e-01   +9.757405899969815e-01   +9.747721537260785e-01   +9.696494522823426e-01   +9.764710562431428e-01   +9.687604965697408e-01   +9.784948537634814e-01; +9.904650425045161e-01   +9.838810151724073e-01   +9.828782560848212e-01   +9.799475407117075e-01   +9.773343280311171e-01   +9.857823025607219e-01   +9.831811167762228e-01; +9.809876986455546e-01   +9.915348408271090e-01   +9.856303865966952e-01   +9.721152803198583e-01   +9.867316608304207e-01   +9.799074579327353e-01   +9.815339270712816e-01; +9.814641171302597e-01   +9.795082823067647e-01   +9.786956341574996e-01   +9.761097638115952e-01   +9.828871440623318e-01   +9.817257454821791e-01   +9.870045965152742e-01; +9.802707965411249e-01   +9.888135556994589e-01   +9.760800756208812e-01   +9.812801245227092e-01   +9.842169028796544e-01   +9.741001187622683e-01   +9.789493042894836e-01; +9.744457384668527e-01   +9.834747581679538e-01   +9.898639386832686e-01   +9.740854135754612e-01   +9.664985783356669e-01   +9.926179260386512e-01   +9.757955266349226e-01; +9.753069134706838e-01   +9.865742342248309e-01   +9.819101904652749e-01   +9.852845943427150e-01   +9.655840101759052e-01   +9.843920895544639e-01   +9.856614013022670e-01; +9.832280148282885e-01   +9.672190646457338e-01   +9.880802380444147e-01   +9.742930641124512e-01   +9.804558798860669e-01   +9.805524886881856e-01   +9.724771642092881e-01; +9.817955604798401e-01   +9.849814806183883e-01   +9.860807605212062e-01   +9.790569905604313e-01   +9.547341754088035e-01   +9.736072198571097e-01   +9.689164007131531e-01; +9.780823511877047e-01   +9.725344438312503e-01   +9.811726022588664e-01   +9.788638815798786e-01   +9.706666405251229e-01   +9.857417118132874e-01   +9.776691964987677e-01; +9.808331370452742e-01   +9.717990504568759e-01   +9.595413127022933e-01   +9.745154306372107e-01   +9.797782852290706e-01   +9.745530476685496e-01   +9.801919457108743e-01];
L4_L1_iGABA_netcon = [+9.820115326029046e-01   +9.747833300547084e-01   +9.897545678694464e-01   +9.863961585834566e-01   +9.579719440422564e-01   +9.880877835880508e-01   +9.761414033583856e-01   +9.797457305390265e-01   +9.863555395594062e-01   +9.890447473152079e-01   +9.800312870579955e-01   +9.744288954090475e-01; +9.809162370050785e-01   +9.793204044042222e-01   +9.670551553457530e-01   +9.993866709699684e-01   +9.848521121790401e-01   +9.830513036279510e-01   +9.824861389977960e-01   +9.813098035953923e-01   +9.792948447948138e-01   +9.708508146942145e-01   +9.703504095293465e-01   +9.885172602181247e-01; +9.631798868334184e-01   +9.854117228650662e-01   +9.800044580923577e-01   +9.817182806141472e-01   +9.881519570300439e-01   +9.764518721364124e-01   +9.697796580979908e-01   +9.942480041067353e-01   +9.794400910607872e-01   +9.794884452661976e-01   +9.694083660686720e-01   +9.928780909743654e-01; +9.829662499625670e-01   +9.771709368017653e-01   +9.635852537343207e-01   +9.819845097037307e-01   +9.856990335759527e-01   +9.817609189678829e-01   +9.712989218077009e-01   +9.773870456235958e-01   +9.794498834446537e-01   +9.851406053540224e-01   +9.662310022843051e-01   +9.788048888568036e-01; +9.811295767643541e-01   +9.849676924061591e-01   +9.805402093312784e-01   +9.821275954836141e-01   +9.711096498880786e-01   +9.846000933608197e-01   +9.861748122632426e-01   +9.687699711007708e-01   +9.821897208471297e-01   +9.730095636422099e-01   +9.733125939772691e-01   +9.866385562109292e-01; +9.824176430467040e-01   +9.809466420456743e-01   +9.690841305203636e-01   +9.749730487776614e-01   +9.779663513472154e-01   +9.695067756274830e-01   +9.694138276501097e-01   +9.796739247476880e-01   +9.811439018847457e-01   +9.757669589307432e-01   +9.814081677243855e-01   +9.786202361269704e-01; +9.821687727791251e-01   +9.697115976735862e-01   +9.688532553272851e-01   +9.760121484536862e-01   +9.757699117668991e-01   +9.734134511786936e-01   +9.713928734334542e-01   +9.777527219727828e-01   +9.889005459791523e-01   +9.789316001867742e-01   +9.776791231057949e-01   +9.823815191986170e-01];
L1_L3_iAMPA_netcon = [+9.750827095029623e-01   +9.800459836603330e-01   +9.816100413306863e-01   +9.749393320109194e-01   +9.844260069126602e-01   +9.849127069164775e-01   +9.820258259991544e-01; +9.688141109069435e-01   +9.846013646541372e-01   +9.774989904593824e-01   +9.757464959481582e-01   +9.871496797160950e-01   +9.870785464046866e-01   +9.878007996160119e-01; +9.753611833801530e-01   +9.605832522960516e-01   +9.793728800052584e-01   +9.765330824214464e-01   +9.736656329907302e-01   +9.691927994301747e-01   +9.796678091851837e-01; +9.866906597075493e-01   +9.711280935563427e-01   +9.660541680587883e-01   +9.906727961335738e-01   +9.795361876263824e-01   +9.843545251181711e-01   +9.666785448965535e-01; +9.832541147117382e-01   +9.905972140546601e-01   +9.628991331973292e-01   +9.853749741267621e-01   +9.705251362158458e-01   +9.823902212389117e-01   +9.889864808249602e-01];
L3_L1_iGABA_netcon = [+9.861809782900003e-01   +9.768714826943435e-01   +9.882030994502750e-01   +9.835253319403257e-01   +9.666286280120082e-01; +9.772032286992565e-01   +9.834455710998390e-01   +9.931901758708386e-01   +9.763844611353851e-01   +9.794481987401575e-01; +9.751120305200025e-01   +9.792177383233758e-01   +9.971024429685321e-01   +9.771366876853976e-01   +9.778568567762209e-01; +9.758303337216654e-01   +9.634920358247727e-01   +9.760919851229305e-01   +9.757993562252547e-01   +9.850629460887089e-01; +9.640610144936228e-01   +9.802019056740295e-01   +9.794028527776490e-01   +9.698607502852363e-01   +9.745282295631952e-01; +9.792149816346222e-01   +9.878354197286907e-01   +9.767799528271145e-01   +9.954115219916176e-01   +9.900609336849034e-01; +9.800702262467373e-01   +9.785117614333001e-01   +9.643540701851038e-01   +9.810810096497277e-01   +9.819639164516403e-01];
L5_Input1_iAMPA_netcon = [+9.654611781665791e-01   +9.848332192276870e-01   +9.803602627458207e-01   +9.895076615877760e-01   +9.716710301996153e-01   +9.704134215504321e-01];
L6_Input2_iAMPA_netcon = [+9.743390908575343e-01   +9.942691157120597e-01   +9.773938848466728e-01   +9.845940240677905e-01];
L5_L6_iAMPA_netcon = [+3.272033823704242e-01   +1.239257848947275e-01   +4.784203995272185e-01   +5.404250685273972e-02   +4.986646441804617e-01   +7.789456615043464e-01; +3.637583167537155e-01   +1.692247434480978e-01   +9.108767443940579e-01   +5.471591843364784e-01   +5.605576242190863e-01   +4.048002823658977e-02; +1.294206285958169e-02   +5.481384290967189e-02   +4.002905535334892e-01   +1.179536802075008e-01   +2.370106522306098e-01   +4.248241329163914e-01; +8.906357350517823e-01   +4.425547958107098e-01   +2.651648989689170e-03   +2.259689647408850e-01   +3.638000481582542e-01   +2.080322704109923e-01];
L4_L5_iAMPA_netcon = [+2.745194343218706e-01   +9.913283795181295e-01   +7.207664811258507e-02   +6.177617414796771e-01   +3.229756048591205e-01   +8.980814560588197e-01   +9.737382549738699e-01   +6.875013366725048e-01   +4.045523159943382e-01   +1.039413698707719e-01   +3.943240921155202e-01   +7.968117553306131e-01; +3.607075576005714e-01   +3.622919938217011e-01   +7.266697899385172e-01   +8.176982661642641e-01   +7.321674814843553e-01   +6.652517288584601e-01   +2.515504008396298e-01   +7.284301126540571e-01   +6.407005052149702e-01   +5.253407689286596e-01   +9.145226512128989e-01   +6.088214135430045e-01; +5.446385278227835e-01   +4.933407619666337e-01   +6.022860495899979e-01   +5.658786251770231e-01   +6.763741926535105e-01   +2.342519311738873e-01   +3.434559769678637e-01   +1.531962428491848e-01   +5.297639570931953e-01   +9.462181964565306e-01   +6.575806684970126e-01   +2.485451567413768e-01; +1.474166443856054e-01   +7.605184744140540e-01   +8.995415470543168e-01   +1.670639049447926e-01   +7.842094351806221e-01   +4.271816994312028e-01   +3.926932674156761e-01   +9.177125740914601e-01   +4.364005920789573e-01   +8.023564151503699e-01   +7.543250743638545e-01   +4.663520596962670e-01; +9.586161695145841e-01   +7.190936766445863e-01   +2.192932906043709e-01   +5.341190743997145e-01   +2.279611912055574e-02   +4.128973965132426e-01   +1.699231401233380e-01   +4.272808701466233e-01   +9.285415341625788e-01   -4.993872079583054e-03   +8.229077155219126e-01   +9.415426684292845e-01; +4.810096311177443e-01   +4.330446202446614e-01   +4.673325394848153e-01   +9.280378412431933e-01   +4.695833360416866e-01   +5.348474793264858e-01   +5.526679395603834e-03   +6.496473423462181e-01   +8.513871517088054e-01   +8.605445392318767e-01   +2.410025857496434e-01   +5.935851407378911e-01];

% ------------------------------------------------------------
% Initial conditions:
% ------------------------------------------------------------
t=0; k=1;

% STATE_VARIABLES:
L1_v_last = zeros(1,p.L1_Npop);
L1_v = zeros(nsamp,p.L1_Npop);
L1_v(1,:) = L1_v_last;
L1_iNa_m_last = p.L1_iNa_m_IC+p.L1_iNa_IC_noise*rand(1,p.L1_Npop);
L1_iNa_m = zeros(nsamp,p.L1_Npop);
L1_iNa_m(1,:) = L1_iNa_m_last;
L1_iNa_h_last = p.L1_iNa_h_IC+p.L1_iNa_IC_noise*rand(1,p.L1_Npop);
L1_iNa_h = zeros(nsamp,p.L1_Npop);
L1_iNa_h(1,:) = L1_iNa_h_last;
L1_iK_n_last = p.L1_iK_n_IC+p.L1_iK_IC_noise*rand(1,p.L1_Npop);
L1_iK_n = zeros(nsamp,p.L1_Npop);
L1_iK_n(1,:) = L1_iK_n_last;
L2_v_last = zeros(1,p.L2_Npop);
L2_v = zeros(nsamp,p.L2_Npop);
L2_v(1,:) = L2_v_last;
L2_iNa_m_last = p.L2_iNa_m_IC+p.L2_iNa_IC_noise*rand(1,p.L2_Npop);
L2_iNa_m = zeros(nsamp,p.L2_Npop);
L2_iNa_m(1,:) = L2_iNa_m_last;
L2_iNa_h_last = p.L2_iNa_h_IC+p.L2_iNa_IC_noise*rand(1,p.L2_Npop);
L2_iNa_h = zeros(nsamp,p.L2_Npop);
L2_iNa_h(1,:) = L2_iNa_h_last;
L2_iK_n_last = p.L2_iK_n_IC+p.L2_iK_IC_noise*rand(1,p.L2_Npop);
L2_iK_n = zeros(nsamp,p.L2_Npop);
L2_iK_n(1,:) = L2_iK_n_last;
L3_v_last = zeros(1,p.L3_Npop);
L3_v = zeros(nsamp,p.L3_Npop);
L3_v(1,:) = L3_v_last;
L3_iNa_m_last = p.L3_iNa_m_IC+p.L3_iNa_IC_noise*rand(1,p.L3_Npop);
L3_iNa_m = zeros(nsamp,p.L3_Npop);
L3_iNa_m(1,:) = L3_iNa_m_last;
L3_iNa_h_last = p.L3_iNa_h_IC+p.L3_iNa_IC_noise*rand(1,p.L3_Npop);
L3_iNa_h = zeros(nsamp,p.L3_Npop);
L3_iNa_h(1,:) = L3_iNa_h_last;
L3_iK_n_last = p.L3_iK_n_IC+p.L3_iK_IC_noise*rand(1,p.L3_Npop);
L3_iK_n = zeros(nsamp,p.L3_Npop);
L3_iK_n(1,:) = L3_iK_n_last;
L4_v_last = zeros(1,p.L4_Npop);
L4_v = zeros(nsamp,p.L4_Npop);
L4_v(1,:) = L4_v_last;
L4_iNa_m_last = p.L4_iNa_m_IC+p.L4_iNa_IC_noise*rand(1,p.L4_Npop);
L4_iNa_m = zeros(nsamp,p.L4_Npop);
L4_iNa_m(1,:) = L4_iNa_m_last;
L4_iNa_h_last = p.L4_iNa_h_IC+p.L4_iNa_IC_noise*rand(1,p.L4_Npop);
L4_iNa_h = zeros(nsamp,p.L4_Npop);
L4_iNa_h(1,:) = L4_iNa_h_last;
L4_iK_n_last = p.L4_iK_n_IC+p.L4_iK_IC_noise*rand(1,p.L4_Npop);
L4_iK_n = zeros(nsamp,p.L4_Npop);
L4_iK_n(1,:) = L4_iK_n_last;
L5_v_last = zeros(1,p.L5_Npop);
L5_v = zeros(nsamp,p.L5_Npop);
L5_v(1,:) = L5_v_last;
L5_iNa_m_last = p.L5_iNa_m_IC+p.L5_iNa_IC_noise*rand(1,p.L5_Npop);
L5_iNa_m = zeros(nsamp,p.L5_Npop);
L5_iNa_m(1,:) = L5_iNa_m_last;
L5_iNa_h_last = p.L5_iNa_h_IC+p.L5_iNa_IC_noise*rand(1,p.L5_Npop);
L5_iNa_h = zeros(nsamp,p.L5_Npop);
L5_iNa_h(1,:) = L5_iNa_h_last;
L5_iK_n_last = p.L5_iK_n_IC+p.L5_iK_IC_noise*rand(1,p.L5_Npop);
L5_iK_n = zeros(nsamp,p.L5_Npop);
L5_iK_n(1,:) = L5_iK_n_last;
L6_v_last = zeros(1,p.L6_Npop);
L6_v = zeros(nsamp,p.L6_Npop);
L6_v(1,:) = L6_v_last;
L6_iNa_m_last = p.L6_iNa_m_IC+p.L6_iNa_IC_noise*rand(1,p.L6_Npop);
L6_iNa_m = zeros(nsamp,p.L6_Npop);
L6_iNa_m(1,:) = L6_iNa_m_last;
L6_iNa_h_last = p.L6_iNa_h_IC+p.L6_iNa_IC_noise*rand(1,p.L6_Npop);
L6_iNa_h = zeros(nsamp,p.L6_Npop);
L6_iNa_h(1,:) = L6_iNa_h_last;
L6_iK_n_last = p.L6_iK_n_IC+p.L6_iK_IC_noise*rand(1,p.L6_Npop);
L6_iK_n = zeros(nsamp,p.L6_Npop);
L6_iK_n(1,:) = L6_iK_n_last;
Input1_v_last = zeros(1,p.Input1_Npop);
Input1_v = zeros(nsamp,p.Input1_Npop);
Input1_v(1,:) = Input1_v_last;
Input1_iNa_m_last = p.Input1_iNa_m_IC+p.Input1_iNa_IC_noise*rand(1,p.Input1_Npop);
Input1_iNa_m = zeros(nsamp,p.Input1_Npop);
Input1_iNa_m(1,:) = Input1_iNa_m_last;
Input1_iNa_h_last = p.Input1_iNa_h_IC+p.Input1_iNa_IC_noise*rand(1,p.Input1_Npop);
Input1_iNa_h = zeros(nsamp,p.Input1_Npop);
Input1_iNa_h(1,:) = Input1_iNa_h_last;
Input1_iK_n_last = p.Input1_iK_n_IC+p.Input1_iK_IC_noise*rand(1,p.Input1_Npop);
Input1_iK_n = zeros(nsamp,p.Input1_Npop);
Input1_iK_n(1,:) = Input1_iK_n_last;
Input2_v_last = zeros(1,p.Input2_Npop);
Input2_v = zeros(nsamp,p.Input2_Npop);
Input2_v(1,:) = Input2_v_last;
Input2_iNa_m_last = p.Input2_iNa_m_IC+p.Input2_iNa_IC_noise*rand(1,p.Input2_Npop);
Input2_iNa_m = zeros(nsamp,p.Input2_Npop);
Input2_iNa_m(1,:) = Input2_iNa_m_last;
Input2_iNa_h_last = p.Input2_iNa_h_IC+p.Input2_iNa_IC_noise*rand(1,p.Input2_Npop);
Input2_iNa_h = zeros(nsamp,p.Input2_Npop);
Input2_iNa_h(1,:) = Input2_iNa_h_last;
Input2_iK_n_last = p.Input2_iK_n_IC+p.Input2_iK_IC_noise*rand(1,p.Input2_Npop);
Input2_iK_n = zeros(nsamp,p.Input2_Npop);
Input2_iK_n(1,:) = Input2_iK_n_last;
L2_L1_iGABAa_s_last =  p.L2_L1_iGABAa_IC+p.L2_L1_iGABAa_IC_noise.*rand(1,p.L1_Npop);
L2_L1_iGABAa_s = zeros(nsamp,p.L1_Npop);
L2_L1_iGABAa_s(1,:) = L2_L1_iGABAa_s_last;
L1_L2_iGABAa_s_last =  p.L1_L2_iGABAa_IC+p.L1_L2_iGABAa_IC_noise.*rand(1,p.L2_Npop);
L1_L2_iGABAa_s = zeros(nsamp,p.L2_Npop);
L1_L2_iGABAa_s(1,:) = L1_L2_iGABAa_s_last;
L2_L5_iAMPA_s_last =  p.L2_L5_iAMPA_IC+p.L2_L5_iAMPA_IC_noise.*rand(1,p.L5_Npop);
L2_L5_iAMPA_s = zeros(nsamp,p.L5_Npop);
L2_L5_iAMPA_s(1,:) = L2_L5_iAMPA_s_last;
L5_L2_iGABA_s_last =  p.L5_L2_iGABA_IC+p.L5_L2_iGABA_IC_noise.*rand(1,p.L2_Npop);
L5_L2_iGABA_s = zeros(nsamp,p.L2_Npop);
L5_L2_iGABA_s(1,:) = L5_L2_iGABA_s_last;
L3_L2_iAMPA_s_last =  p.L3_L2_iAMPA_IC+p.L3_L2_iAMPA_IC_noise.*rand(1,p.L2_Npop);
L3_L2_iAMPA_s = zeros(nsamp,p.L2_Npop);
L3_L2_iAMPA_s(1,:) = L3_L2_iAMPA_s_last;
L2_L3_iAMPA_s_last =  p.L2_L3_iAMPA_IC+p.L2_L3_iAMPA_IC_noise.*rand(1,p.L3_Npop);
L2_L3_iAMPA_s = zeros(nsamp,p.L3_Npop);
L2_L3_iAMPA_s(1,:) = L2_L3_iAMPA_s_last;
L1_L4_iGABA_s_last =  p.L1_L4_iGABA_IC+p.L1_L4_iGABA_IC_noise.*rand(1,p.L4_Npop);
L1_L4_iGABA_s = zeros(nsamp,p.L4_Npop);
L1_L4_iGABA_s(1,:) = L1_L4_iGABA_s_last;
L4_L1_iGABA_s_last =  p.L4_L1_iGABA_IC+p.L4_L1_iGABA_IC_noise.*rand(1,p.L1_Npop);
L4_L1_iGABA_s = zeros(nsamp,p.L1_Npop);
L4_L1_iGABA_s(1,:) = L4_L1_iGABA_s_last;
L1_L3_iAMPA_s_last =  p.L1_L3_iAMPA_IC+p.L1_L3_iAMPA_IC_noise.*rand(1,p.L3_Npop);
L1_L3_iAMPA_s = zeros(nsamp,p.L3_Npop);
L1_L3_iAMPA_s(1,:) = L1_L3_iAMPA_s_last;
L3_L1_iGABA_s_last =  p.L3_L1_iGABA_IC+p.L3_L1_iGABA_IC_noise.*rand(1,p.L1_Npop);
L3_L1_iGABA_s = zeros(nsamp,p.L1_Npop);
L3_L1_iGABA_s(1,:) = L3_L1_iGABA_s_last;
L5_Input1_iAMPA_s_last =  p.L5_Input1_iAMPA_IC+p.L5_Input1_iAMPA_IC_noise.*rand(1,p.Input1_Npop);
L5_Input1_iAMPA_s = zeros(nsamp,p.Input1_Npop);
L5_Input1_iAMPA_s(1,:) = L5_Input1_iAMPA_s_last;
L6_Input2_iAMPA_s_last =  p.L6_Input2_iAMPA_IC+p.L6_Input2_iAMPA_IC_noise.*rand(1,p.Input2_Npop);
L6_Input2_iAMPA_s = zeros(nsamp,p.Input2_Npop);
L6_Input2_iAMPA_s(1,:) = L6_Input2_iAMPA_s_last;
L5_L6_iAMPA_s_last =  p.L5_L6_iAMPA_IC+p.L5_L6_iAMPA_IC_noise.*rand(1,p.L6_Npop);
L5_L6_iAMPA_s = zeros(nsamp,p.L6_Npop);
L5_L6_iAMPA_s(1,:) = L5_L6_iAMPA_s_last;
L4_L5_iAMPA_s_last =  p.L4_L5_iAMPA_IC+p.L4_L5_iAMPA_IC_noise.*rand(1,p.L5_Npop);
L4_L5_iAMPA_s = zeros(nsamp,p.L5_Npop);
L4_L5_iAMPA_s(1,:) = L4_L5_iAMPA_s_last;

% MONITORS:
L1_tspike = -1e32*ones(2,p.L1_Npop);
L1_buffer_index = ones(1,p.L1_Npop);
L1_v_spikes = zeros(nsamp,p.L1_Npop);
L2_tspike = -1e32*ones(2,p.L2_Npop);
L2_buffer_index = ones(1,p.L2_Npop);
L2_v_spikes = zeros(nsamp,p.L2_Npop);
L3_tspike = -1e32*ones(2,p.L3_Npop);
L3_buffer_index = ones(1,p.L3_Npop);
L3_v_spikes = zeros(nsamp,p.L3_Npop);
L4_tspike = -1e32*ones(2,p.L4_Npop);
L4_buffer_index = ones(1,p.L4_Npop);
L4_v_spikes = zeros(nsamp,p.L4_Npop);
L5_tspike = -1e32*ones(2,p.L5_Npop);
L5_buffer_index = ones(1,p.L5_Npop);
L5_v_spikes = zeros(nsamp,p.L5_Npop);
L6_tspike = -1e32*ones(2,p.L6_Npop);
L6_buffer_index = ones(1,p.L6_Npop);
L6_v_spikes = zeros(nsamp,p.L6_Npop);
Input1_tspike = -1e32*ones(2,p.Input1_Npop);
Input1_buffer_index = ones(1,p.Input1_Npop);
Input1_v_spikes = zeros(nsamp,p.Input1_Npop);
Input2_tspike = -1e32*ones(2,p.Input2_Npop);
Input2_buffer_index = ones(1,p.Input2_Npop);
Input2_v_spikes = zeros(nsamp,p.Input2_Npop);
L1_L2_iGABAa_IGABAa = zeros(nsamp,p.L1_Npop);
  L1_L2_iGABAa_IGABAa(1,:)=-p.L1_L2_iGABAa_gGABAa.*(L1_L2_iGABAa_s_last*L1_L2_iGABAa_netcon).*(L1_v_last-p.L1_L2_iGABAa_EGABAa);
L1_L3_iAMPA_IAMPA = zeros(nsamp,p.L1_Npop);
  L1_L3_iAMPA_IAMPA(1,:)=-p.L1_L3_iAMPA_gAMPA.*(L1_L3_iAMPA_s_last*L1_L3_iAMPA_netcon).*(L1_v_last-p.L1_L3_iAMPA_EAMPA);
L1_L4_iGABA_IGABA = zeros(nsamp,p.L1_Npop);
  L1_L4_iGABA_IGABA(1,:)=(p.L1_L4_iGABA_gGABA.*(L1_L4_iGABA_s_last*L1_L4_iGABA_netcon).*(L1_v_last-p.L1_L4_iGABA_EGABA));
L2_L1_iGABAa_IGABAa = zeros(nsamp,p.L2_Npop);
  L2_L1_iGABAa_IGABAa(1,:)=-p.L2_L1_iGABAa_gGABAa.*(L2_L1_iGABAa_s_last*L2_L1_iGABAa_netcon).*(L2_v_last-p.L2_L1_iGABAa_EGABAa);
L2_L3_iAMPA_IAMPA = zeros(nsamp,p.L2_Npop);
  L2_L3_iAMPA_IAMPA(1,:)=-p.L2_L3_iAMPA_gAMPA.*(L2_L3_iAMPA_s_last*L2_L3_iAMPA_netcon).*(L2_v_last-p.L2_L3_iAMPA_EAMPA);
L2_L5_iAMPA_IAMPA = zeros(nsamp,p.L2_Npop);
  L2_L5_iAMPA_IAMPA(1,:)=-p.L2_L5_iAMPA_gAMPA.*(L2_L5_iAMPA_s_last*L2_L5_iAMPA_netcon).*(L2_v_last-p.L2_L5_iAMPA_EAMPA);
L3_L1_iGABA_IGABA = zeros(nsamp,p.L3_Npop);
  L3_L1_iGABA_IGABA(1,:)=(p.L3_L1_iGABA_gGABA.*(L3_L1_iGABA_s_last*L3_L1_iGABA_netcon).*(L3_v_last-p.L3_L1_iGABA_EGABA));
L3_L2_iAMPA_IAMPA = zeros(nsamp,p.L3_Npop);
  L3_L2_iAMPA_IAMPA(1,:)=-p.L3_L2_iAMPA_gAMPA.*(L3_L2_iAMPA_s_last*L3_L2_iAMPA_netcon).*(L3_v_last-p.L3_L2_iAMPA_EAMPA);
L4_L1_iGABA_IGABA = zeros(nsamp,p.L4_Npop);
  L4_L1_iGABA_IGABA(1,:)=(p.L4_L1_iGABA_gGABA.*(L4_L1_iGABA_s_last*L4_L1_iGABA_netcon).*(L4_v_last-p.L4_L1_iGABA_EGABA));
L4_L5_iAMPA_IAMPA = zeros(nsamp,p.L4_Npop);
  L4_L5_iAMPA_IAMPA(1,:)=-p.L4_L5_iAMPA_gAMPA.*(L4_L5_iAMPA_s_last*L4_L5_iAMPA_netcon).*(L4_v_last-p.L4_L5_iAMPA_EAMPA);
L5_Input1_iAMPA_IAMPA = zeros(nsamp,p.L5_Npop);
  L5_Input1_iAMPA_IAMPA(1,:)=-p.L5_Input1_iAMPA_gAMPA.*(L5_Input1_iAMPA_s_last*L5_Input1_iAMPA_netcon).*(L5_v_last-p.L5_Input1_iAMPA_EAMPA);
L5_L2_iGABA_IGABA = zeros(nsamp,p.L5_Npop);
  L5_L2_iGABA_IGABA(1,:)=(p.L5_L2_iGABA_gGABA.*(L5_L2_iGABA_s_last*L5_L2_iGABA_netcon).*(L5_v_last-p.L5_L2_iGABA_EGABA));
L5_L6_iAMPA_IAMPA = zeros(nsamp,p.L5_Npop);
  L5_L6_iAMPA_IAMPA(1,:)=-p.L5_L6_iAMPA_gAMPA.*(L5_L6_iAMPA_s_last*L5_L6_iAMPA_netcon).*(L5_v_last-p.L5_L6_iAMPA_EAMPA);
L6_Input2_iAMPA_IAMPA = zeros(nsamp,p.L6_Npop);
  L6_Input2_iAMPA_IAMPA(1,:)=-p.L6_Input2_iAMPA_gAMPA.*(L6_Input2_iAMPA_s_last*L6_Input2_iAMPA_netcon).*(L6_v_last-p.L6_Input2_iAMPA_EAMPA);

% ###########################################################
% Numerical integration:
% ###########################################################
n=2;
for k=2:ntime
  t=T(k-1);
  L1_v_k1 =p.L1_Iapp+0.5*((((-p.L1_iNa_gNa.*L1_iNa_m_last.^3.*L1_iNa_h_last.*(L1_v_last-p.L1_iNa_ENa))))+((((-p.L1_iK_gK.*L1_iK_n_last.^4.*(L1_v_last-p.L1_iK_EK))))+((((-p.L1_L2_iGABAa_gGABAa.*(L1_L2_iGABAa_s_last*L1_L2_iGABAa_netcon).*(L1_v_last-p.L1_L2_iGABAa_EGABAa))))+((-(((p.L1_L4_iGABA_gGABA.*(L1_L4_iGABA_s_last*L1_L4_iGABA_netcon).*(L1_v_last-p.L1_L4_iGABA_EGABA)))))+((((-p.L1_L3_iAMPA_gAMPA.*(L1_L3_iAMPA_s_last*L1_L3_iAMPA_netcon).*(L1_v_last-p.L1_L3_iAMPA_EAMPA)))))))))+p.L1_noise*rand(1,p.L1_Npop);
  L1_iNa_m_k1 = (((2.5-.1*(L1_v_last+65))./(exp(2.5-.1*(L1_v_last+65))-1))).*(1-L1_iNa_m_last)-((4*exp(-(L1_v_last+65)/18))).*L1_iNa_m_last;
  L1_iNa_h_k1 = ((.07*exp(-(L1_v_last+65)/20))).*(1-L1_iNa_h_last)-((1./(exp(3-.1*(L1_v_last+65))+1))).*L1_iNa_h_last;
  L1_iK_n_k1 = (((.1-.01*(L1_v_last+65))./(exp(1-.1*(L1_v_last+65))-1))).*(1-L1_iK_n_last)-((.125*exp(-(L1_v_last+65)/80))).*L1_iK_n_last;
  L2_v_k1 =p.L2_Iapp+0.5*((((-p.L2_iNa_gNa.*L2_iNa_m_last.^3.*L2_iNa_h_last.*(L2_v_last-p.L2_iNa_ENa))))+((((-p.L2_iK_gK.*L2_iK_n_last.^4.*(L2_v_last-p.L2_iK_EK))))+((((-p.L2_L1_iGABAa_gGABAa.*(L2_L1_iGABAa_s_last*L2_L1_iGABAa_netcon).*(L2_v_last-p.L2_L1_iGABAa_EGABAa))))+((((-p.L2_L5_iAMPA_gAMPA.*(L2_L5_iAMPA_s_last*L2_L5_iAMPA_netcon).*(L2_v_last-p.L2_L5_iAMPA_EAMPA))))+((((-p.L2_L3_iAMPA_gAMPA.*(L2_L3_iAMPA_s_last*L2_L3_iAMPA_netcon).*(L2_v_last-p.L2_L3_iAMPA_EAMPA)))))))))+p.L2_noise*rand(1,p.L2_Npop);
  L2_iNa_m_k1 = (((2.5-.1*(L2_v_last+65))./(exp(2.5-.1*(L2_v_last+65))-1))).*(1-L2_iNa_m_last)-((4*exp(-(L2_v_last+65)/18))).*L2_iNa_m_last;
  L2_iNa_h_k1 = ((.07*exp(-(L2_v_last+65)/20))).*(1-L2_iNa_h_last)-((1./(exp(3-.1*(L2_v_last+65))+1))).*L2_iNa_h_last;
  L2_iK_n_k1 = (((.1-.01*(L2_v_last+65))./(exp(1-.1*(L2_v_last+65))-1))).*(1-L2_iK_n_last)-((.125*exp(-(L2_v_last+65)/80))).*L2_iK_n_last;
  L3_v_k1 =p.L3_Iapp+0.5*((((-p.L3_iNa_gNa.*L3_iNa_m_last.^3.*L3_iNa_h_last.*(L3_v_last-p.L3_iNa_ENa))))+((((-p.L3_iK_gK.*L3_iK_n_last.^4.*(L3_v_last-p.L3_iK_EK))))+((((-p.L3_L2_iAMPA_gAMPA.*(L3_L2_iAMPA_s_last*L3_L2_iAMPA_netcon).*(L3_v_last-p.L3_L2_iAMPA_EAMPA))))+((-(((p.L3_L1_iGABA_gGABA.*(L3_L1_iGABA_s_last*L3_L1_iGABA_netcon).*(L3_v_last-p.L3_L1_iGABA_EGABA)))))))))+p.L3_noise*rand(1,p.L3_Npop);
  L3_iNa_m_k1 = (((2.5-.1*(L3_v_last+65))./(exp(2.5-.1*(L3_v_last+65))-1))).*(1-L3_iNa_m_last)-((4*exp(-(L3_v_last+65)/18))).*L3_iNa_m_last;
  L3_iNa_h_k1 = ((.07*exp(-(L3_v_last+65)/20))).*(1-L3_iNa_h_last)-((1./(exp(3-.1*(L3_v_last+65))+1))).*L3_iNa_h_last;
  L3_iK_n_k1 = (((.1-.01*(L3_v_last+65))./(exp(1-.1*(L3_v_last+65))-1))).*(1-L3_iK_n_last)-((.125*exp(-(L3_v_last+65)/80))).*L3_iK_n_last;
  L4_v_k1 =p.L4_Iapp+0.5*((((-p.L4_iNa_gNa.*L4_iNa_m_last.^3.*L4_iNa_h_last.*(L4_v_last-p.L4_iNa_ENa))))+((((-p.L4_iK_gK.*L4_iK_n_last.^4.*(L4_v_last-p.L4_iK_EK))))+((-(((p.L4_L1_iGABA_gGABA.*(L4_L1_iGABA_s_last*L4_L1_iGABA_netcon).*(L4_v_last-p.L4_L1_iGABA_EGABA)))))+((((-p.L4_L5_iAMPA_gAMPA.*(L4_L5_iAMPA_s_last*L4_L5_iAMPA_netcon).*(L4_v_last-p.L4_L5_iAMPA_EAMPA))))))))+p.L4_noise*rand(1,p.L4_Npop);
  L4_iNa_m_k1 = (((2.5-.1*(L4_v_last+65))./(exp(2.5-.1*(L4_v_last+65))-1))).*(1-L4_iNa_m_last)-((4*exp(-(L4_v_last+65)/18))).*L4_iNa_m_last;
  L4_iNa_h_k1 = ((.07*exp(-(L4_v_last+65)/20))).*(1-L4_iNa_h_last)-((1./(exp(3-.1*(L4_v_last+65))+1))).*L4_iNa_h_last;
  L4_iK_n_k1 = (((.1-.01*(L4_v_last+65))./(exp(1-.1*(L4_v_last+65))-1))).*(1-L4_iK_n_last)-((.125*exp(-(L4_v_last+65)/80))).*L4_iK_n_last;
  L5_v_k1 =p.L5_Iapp+0.5*((((-p.L5_iNa_gNa.*L5_iNa_m_last.^3.*L5_iNa_h_last.*(L5_v_last-p.L5_iNa_ENa))))+((((-p.L5_iK_gK.*L5_iK_n_last.^4.*(L5_v_last-p.L5_iK_EK))))+((-(((p.L5_L2_iGABA_gGABA.*(L5_L2_iGABA_s_last*L5_L2_iGABA_netcon).*(L5_v_last-p.L5_L2_iGABA_EGABA)))))+((((-p.L5_Input1_iAMPA_gAMPA.*(L5_Input1_iAMPA_s_last*L5_Input1_iAMPA_netcon).*(L5_v_last-p.L5_Input1_iAMPA_EAMPA))))+((((-p.L5_L6_iAMPA_gAMPA.*(L5_L6_iAMPA_s_last*L5_L6_iAMPA_netcon).*(L5_v_last-p.L5_L6_iAMPA_EAMPA)))))))))+p.L5_noise*rand(1,p.L5_Npop);
  L5_iNa_m_k1 = (((2.5-.1*(L5_v_last+65))./(exp(2.5-.1*(L5_v_last+65))-1))).*(1-L5_iNa_m_last)-((4*exp(-(L5_v_last+65)/18))).*L5_iNa_m_last;
  L5_iNa_h_k1 = ((.07*exp(-(L5_v_last+65)/20))).*(1-L5_iNa_h_last)-((1./(exp(3-.1*(L5_v_last+65))+1))).*L5_iNa_h_last;
  L5_iK_n_k1 = (((.1-.01*(L5_v_last+65))./(exp(1-.1*(L5_v_last+65))-1))).*(1-L5_iK_n_last)-((.125*exp(-(L5_v_last+65)/80))).*L5_iK_n_last;
  L6_v_k1 =p.L6_Iapp+0.5*((((-p.L6_iNa_gNa.*L6_iNa_m_last.^3.*L6_iNa_h_last.*(L6_v_last-p.L6_iNa_ENa))))+((((-p.L6_iK_gK.*L6_iK_n_last.^4.*(L6_v_last-p.L6_iK_EK))))+((((-p.L6_Input2_iAMPA_gAMPA.*(L6_Input2_iAMPA_s_last*L6_Input2_iAMPA_netcon).*(L6_v_last-p.L6_Input2_iAMPA_EAMPA)))))))+p.L6_noise*rand(1,p.L6_Npop);
  L6_iNa_m_k1 = (((2.5-.1*(L6_v_last+65))./(exp(2.5-.1*(L6_v_last+65))-1))).*(1-L6_iNa_m_last)-((4*exp(-(L6_v_last+65)/18))).*L6_iNa_m_last;
  L6_iNa_h_k1 = ((.07*exp(-(L6_v_last+65)/20))).*(1-L6_iNa_h_last)-((1./(exp(3-.1*(L6_v_last+65))+1))).*L6_iNa_h_last;
  L6_iK_n_k1 = (((.1-.01*(L6_v_last+65))./(exp(1-.1*(L6_v_last+65))-1))).*(1-L6_iK_n_last)-((.125*exp(-(L6_v_last+65)/80))).*L6_iK_n_last;
  Input1_v_k1 = 30*sin(3*t) * (((t<50)));
  Input1_iNa_m_k1 = (((2.5-.1*(Input1_v_last+65))./(exp(2.5-.1*(Input1_v_last+65))-1))).*(1-Input1_iNa_m_last)-((4*exp(-(Input1_v_last+65)/18))).*Input1_iNa_m_last;
  Input1_iNa_h_k1 = ((.07*exp(-(Input1_v_last+65)/20))).*(1-Input1_iNa_h_last)-((1./(exp(3-.1*(Input1_v_last+65))+1))).*Input1_iNa_h_last;
  Input1_iK_n_k1 = (((.1-.01*(Input1_v_last+65))./(exp(1-.1*(Input1_v_last+65))-1))).*(1-Input1_iK_n_last)-((.125*exp(-(Input1_v_last+65)/80))).*Input1_iK_n_last;
  Input2_v_k1 = 30*sin(3*t) * (((t>50)));
  Input2_iNa_m_k1 = (((2.5-.1*(Input2_v_last+65))./(exp(2.5-.1*(Input2_v_last+65))-1))).*(1-Input2_iNa_m_last)-((4*exp(-(Input2_v_last+65)/18))).*Input2_iNa_m_last;
  Input2_iNa_h_k1 = ((.07*exp(-(Input2_v_last+65)/20))).*(1-Input2_iNa_h_last)-((1./(exp(3-.1*(Input2_v_last+65))+1))).*Input2_iNa_h_last;
  Input2_iK_n_k1 = (((.1-.01*(Input2_v_last+65))./(exp(1-.1*(Input2_v_last+65))-1))).*(1-Input2_iK_n_last)-((.125*exp(-(Input2_v_last+65)/80))).*Input2_iK_n_last;
  L2_L1_iGABAa_s_k1 = -L2_L1_iGABAa_s_last./p.L2_L1_iGABAa_tauD + 1/2*(1+tanh(L1_v_last/10)).*((1-L2_L1_iGABAa_s_last)/p.L2_L1_iGABAa_tauR);
  L1_L2_iGABAa_s_k1 = -L1_L2_iGABAa_s_last./p.L1_L2_iGABAa_tauD + 1/2*(1+tanh(L2_v_last/10)).*((1-L1_L2_iGABAa_s_last)/p.L1_L2_iGABAa_tauR);
  L2_L5_iAMPA_s_k1 = -L2_L5_iAMPA_s_last./p.L2_L5_iAMPA_tauD + 1/2*(1+tanh(L5_v_last/10)).*((1-L2_L5_iAMPA_s_last)/p.L2_L5_iAMPA_tauR);
  L5_L2_iGABA_s_k1 = -L5_L2_iGABA_s_last./p.L5_L2_iGABA_tauGABA + ((1-L5_L2_iGABA_s_last)/p.L5_L2_iGABA_tauGABAr).*(1+tanh(L2_v_last/10));
  L3_L2_iAMPA_s_k1 = -L3_L2_iAMPA_s_last./p.L3_L2_iAMPA_tauD + 1/2*(1+tanh(L2_v_last/10)).*((1-L3_L2_iAMPA_s_last)/p.L3_L2_iAMPA_tauR);
  L2_L3_iAMPA_s_k1 = -L2_L3_iAMPA_s_last./p.L2_L3_iAMPA_tauD + 1/2*(1+tanh(L3_v_last/10)).*((1-L2_L3_iAMPA_s_last)/p.L2_L3_iAMPA_tauR);
  L1_L4_iGABA_s_k1 = -L1_L4_iGABA_s_last./p.L1_L4_iGABA_tauGABA + ((1-L1_L4_iGABA_s_last)/p.L1_L4_iGABA_tauGABAr).*(1+tanh(L4_v_last/10));
  L4_L1_iGABA_s_k1 = -L4_L1_iGABA_s_last./p.L4_L1_iGABA_tauGABA + ((1-L4_L1_iGABA_s_last)/p.L4_L1_iGABA_tauGABAr).*(1+tanh(L1_v_last/10));
  L1_L3_iAMPA_s_k1 = -L1_L3_iAMPA_s_last./p.L1_L3_iAMPA_tauD + 1/2*(1+tanh(L3_v_last/10)).*((1-L1_L3_iAMPA_s_last)/p.L1_L3_iAMPA_tauR);
  L3_L1_iGABA_s_k1 = -L3_L1_iGABA_s_last./p.L3_L1_iGABA_tauGABA + ((1-L3_L1_iGABA_s_last)/p.L3_L1_iGABA_tauGABAr).*(1+tanh(L1_v_last/10));
  L5_Input1_iAMPA_s_k1 = -L5_Input1_iAMPA_s_last./p.L5_Input1_iAMPA_tauD + 1/2*(1+tanh(Input1_v_last/10)).*((1-L5_Input1_iAMPA_s_last)/p.L5_Input1_iAMPA_tauR);
  L6_Input2_iAMPA_s_k1 = -L6_Input2_iAMPA_s_last./p.L6_Input2_iAMPA_tauD + 1/2*(1+tanh(Input2_v_last/10)).*((1-L6_Input2_iAMPA_s_last)/p.L6_Input2_iAMPA_tauR);
  L5_L6_iAMPA_s_k1 = -L5_L6_iAMPA_s_last./p.L5_L6_iAMPA_tauD + 1/2*(1+tanh(L6_v_last/10)).*((1-L5_L6_iAMPA_s_last)/p.L5_L6_iAMPA_tauR);
  L4_L5_iAMPA_s_k1 = -L4_L5_iAMPA_s_last./p.L4_L5_iAMPA_tauD + 1/2*(1+tanh(L5_v_last/10)).*((1-L4_L5_iAMPA_s_last)/p.L4_L5_iAMPA_tauR);

  % ------------------------------------------------------------
  % Update state variables:
  % ------------------------------------------------------------
  L1_v_last = L1_v_last+dt*L1_v_k1;
  L1_iNa_m_last = L1_iNa_m_last+dt*L1_iNa_m_k1;
  L1_iNa_h_last = L1_iNa_h_last+dt*L1_iNa_h_k1;
  L1_iK_n_last = L1_iK_n_last+dt*L1_iK_n_k1;
  L2_v_last = L2_v_last+dt*L2_v_k1;
  L2_iNa_m_last = L2_iNa_m_last+dt*L2_iNa_m_k1;
  L2_iNa_h_last = L2_iNa_h_last+dt*L2_iNa_h_k1;
  L2_iK_n_last = L2_iK_n_last+dt*L2_iK_n_k1;
  L3_v_last = L3_v_last+dt*L3_v_k1;
  L3_iNa_m_last = L3_iNa_m_last+dt*L3_iNa_m_k1;
  L3_iNa_h_last = L3_iNa_h_last+dt*L3_iNa_h_k1;
  L3_iK_n_last = L3_iK_n_last+dt*L3_iK_n_k1;
  L4_v_last = L4_v_last+dt*L4_v_k1;
  L4_iNa_m_last = L4_iNa_m_last+dt*L4_iNa_m_k1;
  L4_iNa_h_last = L4_iNa_h_last+dt*L4_iNa_h_k1;
  L4_iK_n_last = L4_iK_n_last+dt*L4_iK_n_k1;
  L5_v_last = L5_v_last+dt*L5_v_k1;
  L5_iNa_m_last = L5_iNa_m_last+dt*L5_iNa_m_k1;
  L5_iNa_h_last = L5_iNa_h_last+dt*L5_iNa_h_k1;
  L5_iK_n_last = L5_iK_n_last+dt*L5_iK_n_k1;
  L6_v_last = L6_v_last+dt*L6_v_k1;
  L6_iNa_m_last = L6_iNa_m_last+dt*L6_iNa_m_k1;
  L6_iNa_h_last = L6_iNa_h_last+dt*L6_iNa_h_k1;
  L6_iK_n_last = L6_iK_n_last+dt*L6_iK_n_k1;
  Input1_v_last = Input1_v_last+dt*Input1_v_k1;
  Input1_iNa_m_last = Input1_iNa_m_last+dt*Input1_iNa_m_k1;
  Input1_iNa_h_last = Input1_iNa_h_last+dt*Input1_iNa_h_k1;
  Input1_iK_n_last = Input1_iK_n_last+dt*Input1_iK_n_k1;
  Input2_v_last = Input2_v_last+dt*Input2_v_k1;
  Input2_iNa_m_last = Input2_iNa_m_last+dt*Input2_iNa_m_k1;
  Input2_iNa_h_last = Input2_iNa_h_last+dt*Input2_iNa_h_k1;
  Input2_iK_n_last = Input2_iK_n_last+dt*Input2_iK_n_k1;
  L2_L1_iGABAa_s_last = L2_L1_iGABAa_s_last+dt*L2_L1_iGABAa_s_k1;
  L1_L2_iGABAa_s_last = L1_L2_iGABAa_s_last+dt*L1_L2_iGABAa_s_k1;
  L2_L5_iAMPA_s_last = L2_L5_iAMPA_s_last+dt*L2_L5_iAMPA_s_k1;
  L5_L2_iGABA_s_last = L5_L2_iGABA_s_last+dt*L5_L2_iGABA_s_k1;
  L3_L2_iAMPA_s_last = L3_L2_iAMPA_s_last+dt*L3_L2_iAMPA_s_k1;
  L2_L3_iAMPA_s_last = L2_L3_iAMPA_s_last+dt*L2_L3_iAMPA_s_k1;
  L1_L4_iGABA_s_last = L1_L4_iGABA_s_last+dt*L1_L4_iGABA_s_k1;
  L4_L1_iGABA_s_last = L4_L1_iGABA_s_last+dt*L4_L1_iGABA_s_k1;
  L1_L3_iAMPA_s_last = L1_L3_iAMPA_s_last+dt*L1_L3_iAMPA_s_k1;
  L3_L1_iGABA_s_last = L3_L1_iGABA_s_last+dt*L3_L1_iGABA_s_k1;
  L5_Input1_iAMPA_s_last = L5_Input1_iAMPA_s_last+dt*L5_Input1_iAMPA_s_k1;
  L6_Input2_iAMPA_s_last = L6_Input2_iAMPA_s_last+dt*L6_Input2_iAMPA_s_k1;
  L5_L6_iAMPA_s_last = L5_L6_iAMPA_s_last+dt*L5_L6_iAMPA_s_k1;
  L4_L5_iAMPA_s_last = L4_L5_iAMPA_s_last+dt*L4_L5_iAMPA_s_k1;

  % ------------------------------------------------------------
  % Conditional actions:
  % ------------------------------------------------------------
  conditional_test=any(any(Input2_v_last>=-20&Input2_v(n-1,:)<-20));
  conditional_indx=(any(Input2_v_last>=-20&Input2_v(n-1,:)<-20));
  if conditional_test, Input2_v_spikes(n,conditional_indx)=1;inds=find(conditional_indx); for j=1:length(inds), i=inds(j); Input2_tspike(Input2_buffer_index(i),i)=t; Input2_buffer_index(i)=mod(-1+(Input2_buffer_index(i)+1),2)+1; end; end
  conditional_test=any(any(Input1_v_last>=-20&Input1_v(n-1,:)<-20));
  conditional_indx=(any(Input1_v_last>=-20&Input1_v(n-1,:)<-20));
  if conditional_test, Input1_v_spikes(n,conditional_indx)=1;inds=find(conditional_indx); for j=1:length(inds), i=inds(j); Input1_tspike(Input1_buffer_index(i),i)=t; Input1_buffer_index(i)=mod(-1+(Input1_buffer_index(i)+1),2)+1; end; end
  conditional_test=any(any(L6_v_last>=-20&L6_v(n-1,:)<-20));
  conditional_indx=(any(L6_v_last>=-20&L6_v(n-1,:)<-20));
  if conditional_test, L6_v_spikes(n,conditional_indx)=1;inds=find(conditional_indx); for j=1:length(inds), i=inds(j); L6_tspike(L6_buffer_index(i),i)=t; L6_buffer_index(i)=mod(-1+(L6_buffer_index(i)+1),2)+1; end; end
  conditional_test=any(any(L5_v_last>=-20&L5_v(n-1,:)<-20));
  conditional_indx=(any(L5_v_last>=-20&L5_v(n-1,:)<-20));
  if conditional_test, L5_v_spikes(n,conditional_indx)=1;inds=find(conditional_indx); for j=1:length(inds), i=inds(j); L5_tspike(L5_buffer_index(i),i)=t; L5_buffer_index(i)=mod(-1+(L5_buffer_index(i)+1),2)+1; end; end
  conditional_test=any(any(L4_v_last>=-20&L4_v(n-1,:)<-20));
  conditional_indx=(any(L4_v_last>=-20&L4_v(n-1,:)<-20));
  if conditional_test, L4_v_spikes(n,conditional_indx)=1;inds=find(conditional_indx); for j=1:length(inds), i=inds(j); L4_tspike(L4_buffer_index(i),i)=t; L4_buffer_index(i)=mod(-1+(L4_buffer_index(i)+1),2)+1; end; end
  conditional_test=any(any(L3_v_last>=-20&L3_v(n-1,:)<-20));
  conditional_indx=(any(L3_v_last>=-20&L3_v(n-1,:)<-20));
  if conditional_test, L3_v_spikes(n,conditional_indx)=1;inds=find(conditional_indx); for j=1:length(inds), i=inds(j); L3_tspike(L3_buffer_index(i),i)=t; L3_buffer_index(i)=mod(-1+(L3_buffer_index(i)+1),2)+1; end; end
  conditional_test=any(any(L2_v_last>=-20&L2_v(n-1,:)<-20));
  conditional_indx=(any(L2_v_last>=-20&L2_v(n-1,:)<-20));
  if conditional_test, L2_v_spikes(n,conditional_indx)=1;inds=find(conditional_indx); for j=1:length(inds), i=inds(j); L2_tspike(L2_buffer_index(i),i)=t; L2_buffer_index(i)=mod(-1+(L2_buffer_index(i)+1),2)+1; end; end
  conditional_test=any(any(L1_v_last>=-20&L1_v(n-1,:)<-20));
  conditional_indx=(any(L1_v_last>=-20&L1_v(n-1,:)<-20));
  if conditional_test, L1_v_spikes(n,conditional_indx)=1;inds=find(conditional_indx); for j=1:length(inds), i=inds(j); L1_tspike(L1_buffer_index(i),i)=t; L1_buffer_index(i)=mod(-1+(L1_buffer_index(i)+1),2)+1; end; end

  if mod(k,downsample_factor)==0 % store this time point

  % ------------------------------------------------------------
  % Store state variables:
  % ------------------------------------------------------------
    L1_v(n,:) = L1_v_last;
    L1_iNa_m(n,:) = L1_iNa_m_last;
    L1_iNa_h(n,:) = L1_iNa_h_last;
    L1_iK_n(n,:) = L1_iK_n_last;
    L2_v(n,:) = L2_v_last;
    L2_iNa_m(n,:) = L2_iNa_m_last;
    L2_iNa_h(n,:) = L2_iNa_h_last;
    L2_iK_n(n,:) = L2_iK_n_last;
    L3_v(n,:) = L3_v_last;
    L3_iNa_m(n,:) = L3_iNa_m_last;
    L3_iNa_h(n,:) = L3_iNa_h_last;
    L3_iK_n(n,:) = L3_iK_n_last;
    L4_v(n,:) = L4_v_last;
    L4_iNa_m(n,:) = L4_iNa_m_last;
    L4_iNa_h(n,:) = L4_iNa_h_last;
    L4_iK_n(n,:) = L4_iK_n_last;
    L5_v(n,:) = L5_v_last;
    L5_iNa_m(n,:) = L5_iNa_m_last;
    L5_iNa_h(n,:) = L5_iNa_h_last;
    L5_iK_n(n,:) = L5_iK_n_last;
    L6_v(n,:) = L6_v_last;
    L6_iNa_m(n,:) = L6_iNa_m_last;
    L6_iNa_h(n,:) = L6_iNa_h_last;
    L6_iK_n(n,:) = L6_iK_n_last;
    Input1_v(n) = Input1_v_last;
    Input1_iNa_m(n) = Input1_iNa_m_last;
    Input1_iNa_h(n) = Input1_iNa_h_last;
    Input1_iK_n(n) = Input1_iK_n_last;
    Input2_v(n) = Input2_v_last;
    Input2_iNa_m(n) = Input2_iNa_m_last;
    Input2_iNa_h(n) = Input2_iNa_h_last;
    Input2_iK_n(n) = Input2_iK_n_last;
    L2_L1_iGABAa_s(n,:) = L2_L1_iGABAa_s_last;
    L1_L2_iGABAa_s(n,:) = L1_L2_iGABAa_s_last;
    L2_L5_iAMPA_s(n,:) = L2_L5_iAMPA_s_last;
    L5_L2_iGABA_s(n,:) = L5_L2_iGABA_s_last;
    L3_L2_iAMPA_s(n,:) = L3_L2_iAMPA_s_last;
    L2_L3_iAMPA_s(n,:) = L2_L3_iAMPA_s_last;
    L1_L4_iGABA_s(n,:) = L1_L4_iGABA_s_last;
    L4_L1_iGABA_s(n,:) = L4_L1_iGABA_s_last;
    L1_L3_iAMPA_s(n,:) = L1_L3_iAMPA_s_last;
    L3_L1_iGABA_s(n,:) = L3_L1_iGABA_s_last;
    L5_Input1_iAMPA_s(n) = L5_Input1_iAMPA_s_last;
    L6_Input2_iAMPA_s(n) = L6_Input2_iAMPA_s_last;
    L5_L6_iAMPA_s(n,:) = L5_L6_iAMPA_s_last;
    L4_L5_iAMPA_s(n,:) = L4_L5_iAMPA_s_last;

  % ------------------------------------------------------------
  % Update monitors:
  % ------------------------------------------------------------
  L1_L2_iGABAa_IGABAa(n,:)=-p.L1_L2_iGABAa_gGABAa.*(L1_L2_iGABAa_s(n,:)*L1_L2_iGABAa_netcon).*(L1_v(n,:)-p.L1_L2_iGABAa_EGABAa);
  L1_L3_iAMPA_IAMPA(n,:)=-p.L1_L3_iAMPA_gAMPA.*(L1_L3_iAMPA_s(n,:)*L1_L3_iAMPA_netcon).*(L1_v(n,:)-p.L1_L3_iAMPA_EAMPA);
  L1_L4_iGABA_IGABA(n,:)=(p.L1_L4_iGABA_gGABA.*(L1_L4_iGABA_s(n,:)*L1_L4_iGABA_netcon).*(L1_v(n,:)-p.L1_L4_iGABA_EGABA));
  L2_L1_iGABAa_IGABAa(n,:)=-p.L2_L1_iGABAa_gGABAa.*(L2_L1_iGABAa_s(n,:)*L2_L1_iGABAa_netcon).*(L2_v(n,:)-p.L2_L1_iGABAa_EGABAa);
  L2_L3_iAMPA_IAMPA(n,:)=-p.L2_L3_iAMPA_gAMPA.*(L2_L3_iAMPA_s(n,:)*L2_L3_iAMPA_netcon).*(L2_v(n,:)-p.L2_L3_iAMPA_EAMPA);
  L2_L5_iAMPA_IAMPA(n,:)=-p.L2_L5_iAMPA_gAMPA.*(L2_L5_iAMPA_s(n,:)*L2_L5_iAMPA_netcon).*(L2_v(n,:)-p.L2_L5_iAMPA_EAMPA);
  L3_L1_iGABA_IGABA(n,:)=(p.L3_L1_iGABA_gGABA.*(L3_L1_iGABA_s(n,:)*L3_L1_iGABA_netcon).*(L3_v(n,:)-p.L3_L1_iGABA_EGABA));
  L3_L2_iAMPA_IAMPA(n,:)=-p.L3_L2_iAMPA_gAMPA.*(L3_L2_iAMPA_s(n,:)*L3_L2_iAMPA_netcon).*(L3_v(n,:)-p.L3_L2_iAMPA_EAMPA);
  L4_L1_iGABA_IGABA(n,:)=(p.L4_L1_iGABA_gGABA.*(L4_L1_iGABA_s(n,:)*L4_L1_iGABA_netcon).*(L4_v(n,:)-p.L4_L1_iGABA_EGABA));
  L4_L5_iAMPA_IAMPA(n,:)=-p.L4_L5_iAMPA_gAMPA.*(L4_L5_iAMPA_s(n,:)*L4_L5_iAMPA_netcon).*(L4_v(n,:)-p.L4_L5_iAMPA_EAMPA);
  L5_Input1_iAMPA_IAMPA(n,:)=-p.L5_Input1_iAMPA_gAMPA.*(L5_Input1_iAMPA_s(n)*L5_Input1_iAMPA_netcon).*(L5_v(n,:)-p.L5_Input1_iAMPA_EAMPA);
  L5_L2_iGABA_IGABA(n,:)=(p.L5_L2_iGABA_gGABA.*(L5_L2_iGABA_s(n,:)*L5_L2_iGABA_netcon).*(L5_v(n,:)-p.L5_L2_iGABA_EGABA));
  L5_L6_iAMPA_IAMPA(n,:)=-p.L5_L6_iAMPA_gAMPA.*(L5_L6_iAMPA_s(n,:)*L5_L6_iAMPA_netcon).*(L5_v(n,:)-p.L5_L6_iAMPA_EAMPA);
  L6_Input2_iAMPA_IAMPA(n,:)=-p.L6_Input2_iAMPA_gAMPA.*(L6_Input2_iAMPA_s(n)*L6_Input2_iAMPA_netcon).*(L6_v(n,:)-p.L6_Input2_iAMPA_EAMPA);

    n=n+1;
  end
end

T=T(1:downsample_factor:ntime);

end
