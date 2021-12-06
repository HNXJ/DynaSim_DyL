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
L2_L1_iGABAa_netcon = [+6.896572542017745e-01   +9.621601397803982e-02   +5.904550907831353e-01   +9.573393144137836e-01   +6.091820109831566e-01   +8.844098329899917e-01   +9.104407324642900e-01   +4.007932141420436e-01; +2.354939991903482e-01   +1.432513588087300e-01   +9.858393550658150e-01   +6.926916648735234e-01   +4.501700950186736e-01   +4.088908903520768e-01   +6.559638197437022e-02   +9.410845601324090e-01; +9.801461314695119e-01   +6.703224030487155e-01   +8.672756579998789e-01   +8.419048625369470e-01   +4.897466378776745e-01   +6.579280677895065e-01   +2.888854468941732e-01   +2.105392805226569e-01; +7.181796262101389e-01   +9.899895604628473e-01   +7.167092247687021e-01   +4.931213125140418e-01   +8.470909374717068e-01   +1.091597783115059e-01   +5.490801659912311e-01   +5.317020885886383e-01; +7.441268547541021e-01   +3.169263221295760e-02   +8.015753238751704e-01   +3.635236462023096e-01   +2.939854704097394e-02   +8.735683670862342e-01   +1.161084123925459e-02   +9.525097648269930e-01; +9.216359862227049e-01   +8.289331720012498e-01   +7.586444677180118e-01   +3.846443331123038e-01   +1.889417504838265e-02   +7.244889976256559e-01   +9.376046364363163e-01   +9.155323794669596e-01; +4.427433139721549e-01   +1.953955360391391e-01   +2.391048264671398e-01   +9.072492022750192e-01   +1.733930447105008e-01   +8.852476899626607e-01   +5.782804907464680e-02   +8.374775246037082e-01];
L1_L2_iGABAa_netcon = [+7.044984858431583e-01   +9.503724448012758e-01   +1.511424226446384e-01   +2.584186132169428e-01   +3.519924342083213e-01   +2.824470090189847e-01   +4.759101657903491e-01; +4.741858013234397e-01   +6.488917854750779e-01   +7.485648643182542e-01   +3.365287072574223e-01   +4.981526253934340e-01   +5.481836450506985e-01   +4.630700188525584e-01; +2.363194767854251e-01   +5.820327386403216e-01   +1.811413646245971e-01   +9.253559217232219e-01   +3.816913930890291e-01   +1.009654162238001e-01   +1.677461101471545e-01; +9.420224584040027e-02   +3.733224978249535e-01   +2.886854853568799e-01   +7.288042726117420e-01   +6.934246350581154e-01   +4.519669388638956e-02   +1.702178212696210e-01; +6.001327482115032e-01   +8.650124768574408e-03   +6.304012924736285e-01   +6.187383901085293e-01   +1.775760664196926e-01   +8.361848938845406e-02   +8.985630913935307e-02; +1.532904403232891e-01   +6.967179164472344e-01   +5.254793368108454e-01   +1.570950249588987e-01   +2.716777480526524e-01   +5.458861472884009e-01   +2.651587588094557e-02; +7.838032840189662e-01   +3.998708576996687e-01   +4.867388140043771e-01   +8.981597727953503e-01   +9.631845910991710e-01   +8.615901409938074e-01   +2.662919268577583e-01; +3.808898797487940e-01   +5.756627309845209e-01   +9.548072232853697e-02   +3.706603031429248e-01   +6.842649056547053e-01   +7.228617228195355e-01   +7.953911976167422e-01];
L2_L5_iAMPA_netcon = [+6.318568258459670e-01   +6.835968302260691e-01   +2.124634305697952e-01   +7.722091557982751e-01   +5.655101594100406e-01   +4.330677372267047e-01   +4.975750598541152e-01   +2.795294610327624e-01; +9.876658667513676e-01   +3.942044822296099e-02   +1.698000863626934e-01   +1.145819856477586e-01   +6.175374955884642e-01   +6.381441344030566e-01   +1.161395027870010e-01   +9.589646236599195e-02; +6.756319832598549e-01   +2.586283749885704e-01   +5.707098068134728e-01   +4.989845920919841e-01   +8.750742898569235e-01   +1.994765013749914e-01   +5.579809804281168e-02   +7.558717303570376e-01; +4.642898511591553e-01   +5.339839151655482e-01   +9.830550844453613e-01   +9.559769445774431e-02   +2.540327580789355e-01   +3.949170019701325e-01   +4.475199228252999e-01   +9.515796060395590e-01; +3.914913549575819e-01   +5.950184462624937e-01   +7.728684161127241e-01   +7.608603187326950e-01   +4.144412455484558e-01   +2.998503407313456e-02   +6.096610423871196e-01   +2.565453118480711e-01; +8.619633039401960e-01   +3.971250756062828e-01   +8.659345383976084e-01   +9.908425193818705e-01   +3.211649892697938e-01   +5.276797937969855e-01   +1.066781307633420e-01   +4.093970688679497e-01];
L5_L2_iGABA_netcon = [+4.753879934025882e-01   +4.747734945850838e-02   +1.303655312630826e-01   +9.179545645534329e-01   +5.687591345866352e-03   +6.371059528538083e-01; +4.750757918899757e-01   +4.044629208548785e-02   +6.421592130990262e-01   +1.077282589771203e-01   +9.274863352780922e-01   +5.027559090997443e-01; +1.305595739042390e-01   +2.797296555020665e-02   +6.378511420031981e-01   +4.281448057196175e-01   +7.866196878599440e-01   +7.084189910498900e-02; +8.188425596287349e-01   +5.340806675805599e-01   +5.728252892886589e-01   +6.382614982703178e-01   +2.120214075642253e-01   +8.340597302099666e-01; +4.295186668166989e-02   +2.589796791584891e-01   +5.655660063367197e-02   +9.212062966918588e-01   +2.560076323610326e-01   +3.862088296901586e-01; +2.937576098267509e-01   +5.303926955515501e-01   +9.675038971212860e-01   +3.165701854166774e-01   +2.571620937841497e-01   +2.565422328835071e-01; +4.557773674310919e-02   +1.866173768198342e-01   +5.413479779972404e-02   +8.141549512234196e-01   +7.512537631046284e-01   +3.708350644754076e-01; +4.263731298590772e-01   +5.791297994085655e-01   +7.656276060403564e-01   +8.082707872293627e-01   +1.330082603956700e-01   +6.264724584030275e-01];
L3_L2_iAMPA_netcon = [+4.377103999803394e-02   +4.979602532999948e-01   +1.069887710865904e-01   +8.189668510903009e-01   +4.577967641083475e-01; +9.100158941752874e-01   +3.554513606561117e-01   +7.884415564032199e-01   +3.707048934079450e-01   +8.704272101661543e-01; +4.417171125970866e-01   +7.571312118103083e-01   +3.458488150517035e-01   +3.507570735815637e-01   +3.992780401003928e-01; +9.161196240119910e-01   +9.141805386856645e-01   +9.516381160937123e-01   +8.751917989181687e-01   +7.175768116470020e-01; +3.892092919010638e-01   +9.493597806191814e-01   +5.480321529856750e-01   +7.302788027729092e-01   +7.626697894913852e-01; +5.004637927552371e-01   +1.444431024103952e-01   +6.770764903086861e-01   +5.590567620894035e-01   +3.411899836356797e-01; +6.116095369563392e-02   +4.336761403376423e-01   +3.886908775072055e-01   +5.203500447035928e-01   +8.627693513806800e-01; +6.319937489718791e-01   +3.903531441483605e-01   +2.807076189756988e-01   +6.101617624494166e-01   +7.884209355581031e-01];
L2_L3_iAMPA_netcon = [+7.208202696231771e-01   +5.825291702270036e-01   +1.982061720338638e-01   +7.035733500868925e-02   +2.472082689209769e-01   +3.753226897798769e-01   +6.621241067520041e-01   +8.629223342633463e-01; +3.497730843809067e-01   +5.285454871486874e-01   +8.362006141723262e-01   +3.376320282998399e-01   +3.357194059123515e-01   +8.063958883117218e-01   +4.286111153464965e-01   +7.632572043625128e-01; +6.299589455052654e-01   +6.710939010469599e-01   +1.419584605599169e-01   +5.951586338412107e-01   +9.886470185764985e-01   +8.115645732636860e-01   +4.687466389976847e-01   +8.232010959417989e-01; +2.809933901166281e-01   +1.799354183446063e-01   +4.897032738526474e-01   +8.494604984446581e-02   +3.399665261808608e-02   +9.914850344957596e-02   +7.811826044168615e-01   +3.667849965382742e-01; +9.128431549362231e-02   +7.123271628502953e-02   +1.849385390822015e-01   +3.420919721609675e-01   +3.198160490615316e-01   +7.496502357285498e-01   +6.549505096408704e-01   +4.890007557259323e-01];
L1_L4_iGABA_netcon = [+1.001935493037282e+00   +9.990231110580102e-01   +9.959114668732474e-01   +9.987540221843697e-01   +9.979548194412728e-01   +9.975598518505030e-01   +1.000211732854846e+00; +9.955429420134548e-01   +9.944191597106750e-01   +9.952198304868977e-01   +9.971852281421553e-01   +9.973807529871549e-01   +9.946107005114800e-01   +9.977664094847768e-01; +9.962493201309597e-01   +9.999427181248326e-01   +9.996805977194562e-01   +9.962329924281397e-01   +9.995021484176139e-01   +9.987679925388179e-01   +9.967409151484269e-01; +1.000932324010507e+00   +9.999363047048381e-01   +9.972869606987373e-01   +9.971925642094865e-01   +9.999289931318781e-01   +9.986947521938627e-01   +9.945131255265244e-01; +9.960122491433434e-01   +9.960032759196891e-01   +9.993687303861607e-01   +9.990250527517959e-01   +1.000674082847654e+00   +9.954074363093425e-01   +9.990565978810075e-01; +9.985838771844125e-01   +1.000136225218363e+00   +9.972049793978165e-01   +9.955585908187634e-01   +1.000216953980672e+00   +9.995271425294555e-01   +9.952494510118575e-01; +9.969843577462291e-01   +1.000010673008940e+00   +9.996773108776408e-01   +9.970750111170807e-01   +9.973415609084926e-01   +9.976636231157827e-01   +9.949712711815002e-01; +9.969935030889316e-01   +9.977384076495635e-01   +9.963288733159290e-01   +1.001575642588691e+00   +9.984753719964249e-01   +9.973828768567389e-01   +9.991559998628153e-01; +9.979941452907933e-01   +9.967572525235414e-01   +9.959725667600033e-01   +9.958129609635024e-01   +9.998109983499067e-01   +9.983445059972025e-01   +9.946194834774414e-01; +9.977827897593609e-01   +9.995063695202827e-01   +9.999147036465129e-01   +9.953835727819980e-01   +9.968312167952176e-01   +9.995671622466917e-01   +9.963816196103813e-01; +9.984656787215080e-01   +9.947802094535725e-01   +9.987655663472672e-01   +9.985257356623465e-01   +9.965920942848768e-01   +9.993233891079010e-01   +9.999320412491179e-01; +9.987687322342584e-01   +9.974473050998146e-01   +9.977268322149079e-01   +9.964849324505652e-01   +9.962353177621273e-01   +9.976180287087236e-01   +9.990087653316687e-01];
L4_L1_iGABA_netcon = [+9.979658106464419e-01   +9.978023387536815e-01   +9.957001392988903e-01   +9.975478722367115e-01   +9.962146453979598e-01   +9.954852950180946e-01   +1.000009862694825e+00   +1.000109463698879e+00   +9.993493702975473e-01   +1.001032661800601e+00   +9.985484799528435e-01   +1.000270174003768e+00; +1.000091494492332e+00   +9.998537710933451e-01   +9.952664366367334e-01   +1.000226248906925e+00   +9.959357233039243e-01   +9.984588163075548e-01   +9.986459451990288e-01   +9.967579816834392e-01   +9.982891043458938e-01   +9.963242413610457e-01   +9.964924486829628e-01   +9.965942254245499e-01; +9.961907293992102e-01   +9.967259318437695e-01   +9.980884996125033e-01   +9.988015015177841e-01   +9.965257517165161e-01   +9.971004478915960e-01   +9.944852190896940e-01   +9.954989305092140e-01   +9.979624753264676e-01   +9.983359836346766e-01   +9.960526106966804e-01   +9.990803158478337e-01; +9.999777473679696e-01   +9.980417492047385e-01   +9.961337285777517e-01   +9.960384021445492e-01   +9.956809023062927e-01   +9.989702924888676e-01   +9.977029223714469e-01   +9.953316545691486e-01   +9.985188532357642e-01   +9.981647140959324e-01   +9.948298771042676e-01   +9.952512218100408e-01; +9.962785089031948e-01   +9.987342747073830e-01   +9.964313260440835e-01   +1.000091521027252e+00   +9.974592495677459e-01   +9.968515481076535e-01   +9.984005258555040e-01   +9.950594659162865e-01   +9.980202491090931e-01   +9.960183640067842e-01   +9.986175186070432e-01   +1.000212634680219e+00; +9.998738188553746e-01   +9.964217050294788e-01   +9.972093547401560e-01   +1.000814070769382e+00   +9.957431273667765e-01   +9.961088487848566e-01   +9.973453862310939e-01   +9.966430670686582e-01   +9.968002362690240e-01   +9.959393502836040e-01   +1.000218022207366e+00   +9.997193565910679e-01; +9.992085900526869e-01   +9.953037918404468e-01   +9.982490224247293e-01   +9.956432444506867e-01   +9.966941691309507e-01   +9.993107097499463e-01   +9.955782161575263e-01   +9.997693791470708e-01   +9.999429655825146e-01   +9.981792257644142e-01   +9.955052445023956e-01   +9.997295680493636e-01];
L1_L3_iAMPA_netcon = [+9.985455705501151e-01   +9.984612735702683e-01   +1.001308686929146e+00   +9.986461104750572e-01   +1.000031343379665e+00   +9.980834223256703e-01   +9.985663215714922e-01; +1.001744469055017e+00   +9.984572634611837e-01   +9.961776208643973e-01   +1.001332990104448e+00   +1.001155492582960e+00   +9.989078000633308e-01   +9.988425628916290e-01; +9.974463769444777e-01   +9.951162371487502e-01   +9.995137329869753e-01   +9.986932621160816e-01   +9.949378500887749e-01   +9.991628510750918e-01   +1.000656800542775e+00; +9.969888954843314e-01   +9.955958043787619e-01   +9.944731118091226e-01   +9.998339806053620e-01   +9.952050245461392e-01   +1.000926382039742e+00   +9.986861673088420e-01; +9.991988872505122e-01   +9.968744383457582e-01   +9.966017594569984e-01   +9.966444160477709e-01   +9.960901041836809e-01   +9.975375958334043e-01   +9.970340761017764e-01];
L3_L1_iGABA_netcon = [+9.967284306807809e-01   +1.000762687648350e+00   +9.967359693324110e-01   +9.989835214387419e-01   +9.958185360455049e-01; +1.001385854710258e+00   +9.980706343767822e-01   +9.980334723451423e-01   +1.000526621611622e+00   +1.000903109745891e+00; +9.960277676895761e-01   +1.000060902693589e+00   +1.001084980481795e+00   +9.954078680466862e-01   +9.996989751744252e-01; +1.000825666174828e+00   +9.967024218146191e-01   +9.979961904634684e-01   +9.972534319892058e-01   +9.979461446302249e-01; +9.969429549299467e-01   +9.948771394490040e-01   +9.984739028131683e-01   +9.961840415829948e-01   +1.001126761480709e+00; +9.989106750546856e-01   +9.991376816798925e-01   +9.995394510551440e-01   +9.965116902421953e-01   +9.999231602997860e-01; +9.996041255745880e-01   +9.959390077792994e-01   +9.966623267697211e-01   +9.968359292417690e-01   +9.982809257016252e-01];
L5_Input1_iAMPA_netcon = [+9.989719461862282e-01   +9.998814715903289e-01   +9.950975926172766e-01   +9.976261911982101e-01   +1.000303654216275e+00   +9.990887942874579e-01];
L6_Input2_iAMPA_netcon = [+9.953925513374156e-01   +9.982454741002343e-01   +1.000125822942895e+00   +9.970810648008046e-01];
L5_L6_iAMPA_netcon = [+3.433200667150796e-01   +1.435504394396207e-01   +4.973415416091807e-01   +8.645291590224014e-02   +5.153399673143152e-01   +8.119767749775990e-01; +3.857148932559373e-01   +1.829268596638310e-01   +9.278763980654288e-01   +5.623409260211226e-01   +5.833142506329769e-01   +6.170635756290219e-02; +2.720319415585650e-02   +6.931582175320196e-02   +4.262902689934752e-01   +1.500949458340727e-01   +2.556671469981993e-01   +4.369579709363701e-01; +9.205431261990585e-01   +4.653444542305179e-01   +2.439142921262714e-02   +2.566104758119792e-01   +3.944669659583409e-01   +2.208523286304243e-01];
L4_L5_iAMPA_netcon = [+3.112406344471557e-01   +1.000195235749450e+00   +8.451825294688982e-02   +6.498845935179444e-01   +3.595143927891263e-01   +9.294384147808947e-01   +9.875322654694363e-01   +7.024686814456427e-01   +4.210917413730805e-01   +1.229972809462614e-01   +4.115518184971111e-01   +8.233473552776023e-01; +3.757372630545802e-01   +3.809324456938032e-01   +7.441213020892415e-01   +8.309641317947035e-01   +7.492657536578177e-01   +6.691215498494917e-01   +2.657173858792032e-01   +7.573498262912657e-01   +6.564708642497517e-01   +5.425494698476264e-01   +9.308276552337928e-01   +6.275529113472866e-01; +5.762417442495938e-01   +5.087315316330319e-01   +6.300566595161791e-01   +5.918540990849319e-01   +6.943273077044172e-01   +2.601913227161575e-01   +3.641080253959204e-01   +1.646166324527591e-01   +5.452638572342651e-01   +9.618380370902726e-01   +6.832638747413874e-01   +2.729323120625068e-01; +1.760603132159790e-01   +8.017721754992799e-01   +9.150461713901206e-01   +1.819044936810754e-01   +8.056504754468171e-01   +4.499491457219393e-01   +4.185100731022317e-01   +9.385640749640619e-01   +4.524884367080741e-01   +8.327028339432979e-01   +7.672198535952656e-01   +4.913174238306897e-01; +9.745837852462943e-01   +7.410933578880976e-01   +2.367945287379467e-01   +5.609177925586540e-01   +4.317640545748726e-02   +4.270331491655814e-01   +1.835718921353937e-01   +4.463757985666163e-01   +9.476635530114330e-01   +2.033412046519001e-02   +8.477140549621093e-01   +9.671307729918392e-01; +4.985191444672343e-01   +4.481205129923508e-01   +4.962405360427141e-01   +9.564952109331492e-01   +5.003966166440458e-01   +5.616579073756162e-01   +2.893260865603736e-02   +6.786207615615225e-01   +8.748785336101212e-01   +8.675988161700421e-01   +2.546617250603879e-01   +6.171122680285340e-01];

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
