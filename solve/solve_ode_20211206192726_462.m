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
L2_L1_iGABAa_netcon = [+5.293455394927598e-01   +7.216004132955665e-01   +9.361731308200369e-02   +7.452504770857763e-01   +9.037746100011051e-01   +8.571302085712554e-01   +3.734119928081901e-02   +8.866965486758592e-01; +1.249366296477274e-01   +9.890624496205694e-01   +1.770892730321005e-02   +4.446883284892037e-03   +4.391403195527907e-01   +2.617900786384764e-01   +5.717968811835410e-01   +3.676104647237712e-01; +7.904255311291588e-01   +1.370993142618905e-01   +4.926980707359574e-01   +1.269088175222013e-01   -1.802989100183837e-02   +2.625980948667007e-01   +4.249181079758355e-01   +9.639161845184520e-01; +5.544819305191683e-01   +2.121355608372708e-01   +7.647324841562637e-01   +5.660833570081508e-01   +8.804149273705810e-01   +7.517296837471266e-01   +1.503762307051111e-02   +6.635180742680112e-01; +3.022721086217766e-01   +5.471729392582704e-01   +3.878756252617065e-01   +2.630478690536937e-01   +8.768383394975592e-01   +7.948270584975345e-01   +8.278200847767035e-01   +4.774267822183463e-01; +4.088944396780200e-01   +2.642709092717457e-01   +4.940038510091052e-01   +9.134725561555981e-01   +3.264463111768469e-01   +1.362327790713353e-01   +1.851419984581924e-01   +7.412571362029307e-01; +5.192238441676875e-01   +4.520203857948998e-01   +7.076346182717694e-01   +7.579622616479966e-01   +7.837938825523628e-01   +2.393742605597052e-01   +6.347328262769697e-01   +5.796266713257586e-01];
L1_L2_iGABAa_netcon = [+5.998944451513737e-01   +7.759345903312187e-01   +6.270666496425498e-01   +2.275914074561054e-01   +9.468669786149712e-01   +6.511954673489113e-01   +6.457562658739275e-01; +5.862695823420196e-01   +4.156274981503159e-01   +2.047781332145044e-01   +2.359421322988636e-01   +8.211506547122374e-01   +6.426855240606091e-01   +2.640422463671327e-01; +8.629948728995700e-01   +2.607636412237587e-01   +2.880364077783185e-01   +4.571507639871630e-01   +6.195234359916708e-01   +6.093717134666856e-01   +3.883419384307458e-01; +2.069567831786325e-01   +2.997396876343578e-01   +7.157747175425535e-01   +8.938185286403285e-01   +8.617128072991650e-01   +3.370602629951262e-01   +4.033480542246813e-01; +6.970704163866763e-02   +3.204975450426701e-01   +2.111640077283762e-01   +3.504066663374525e-01   +7.815217185308426e-01   +7.954608752431962e-01   +2.862366423199377e-01; +4.356575740252745e-01   +9.930926917875085e-02   +6.314100618646638e-01   +4.519431248026350e-01   +8.039132826213449e-01   +4.435867517341349e-01   +3.786457056421883e-01; +4.545533842282362e-02   +2.207438482497169e-01   +5.256853279628592e-01   +7.716940930751649e-01   +7.342227683236231e-01   +2.530584693171457e-02   +8.994511981374316e-01; +1.756183352699167e-02   +4.384974457510493e-01   +1.488171096562688e-01   +9.874067748609426e-01   +3.705042062693866e-01   +6.116473613430154e-01   +6.653173222879348e-01];
L2_L5_iAMPA_netcon = [+7.321817133358838e-01   +6.747305733837243e-01   +6.693601961633093e-01   +8.977605229874404e-01   +3.781093952755563e-02   +8.690374757145716e-01   +9.316914817927630e-01   +4.056857487303646e-01; +4.451228864530918e-01   +8.835380130803105e-01   +2.466104119184327e-01   +2.395767177928285e-01   +4.261947432029090e-01   +7.238354955703673e-01   +6.560024932420992e-01   +9.287296965333296e-01; +2.446636275399080e-01   +9.681605827835295e-01   +2.376023684952058e-01   +5.736127114866968e-01   +6.512477108118957e-01   -1.271842762106386e-03   +7.259314332776231e-01   +4.797421750390099e-01; +4.228580342783951e-01   +8.695272805998010e-01   -1.098146339547859e-02   +3.558706525840108e-01   +6.839148073144687e-01   +2.858231261379550e-01   +4.643460703393080e-02   +1.185700426670149e-01; +8.167253820403261e-01   +6.263612192374137e-01   +5.965414513935620e-01   +5.731110258423989e-01   +2.671920087325783e-02   +4.621307441847540e-01   +3.253882642107856e-01   +5.038005006243419e-01; +1.190520323741723e-01   +1.190308397546646e-01   +8.984809782361661e-01   +1.683765121900418e-01   +4.661084127681682e-01   +1.622720540147372e-01   +5.978006132758062e-01   +8.579794144766923e-01];
L5_L2_iGABA_netcon = [+4.946968433477472e-01   +9.438057345548210e-01   +2.707535973210777e-01   +6.519710060897657e-01   +7.105955046860100e-01   +4.951527047283237e-01; +1.967478892060020e-02   +4.990411905150090e-01   +3.526638768427511e-01   +9.657600591946844e-01   +5.603815826031022e-01   +4.148149251482157e-01; +7.516753264233746e-01   +4.455048523386296e-01   +3.489234550925203e-01   +8.687431813154560e-01   +9.127991197454407e-01   +3.061386348206928e-01; +2.857878335482962e-01   +8.202776860151950e-01   +5.825398162501115e-02   +7.439825512491183e-01   +4.586159792822276e-01   +7.044472711389129e-01; +2.777037034478628e-01   +5.258188190996453e-01   +4.173511668524732e-02   +4.106053618145694e-01   +3.387900829580528e-01   +6.326819543861592e-01; +9.193715840234820e-02   +5.439510128100877e-02   +9.088611142288006e-01   +2.582802945869942e-01   +6.436143615492061e-01   +5.677033976881382e-01; +6.770870459462280e-01   +2.416050235972864e-01   +3.613710686372782e-01   +7.179669805063787e-01   +6.110559052148632e-01   +9.120984895336551e-01; +9.776646194222935e-01   +3.951934302571554e-01   +2.024546560784543e-01   +6.918067210769953e-01   +8.950929991565111e-01   +3.710485232595732e-03];
L3_L2_iAMPA_netcon = [+1.028302099376833e-02   +6.501453341964714e-02   +4.421056890700624e-01   +8.510689325955280e-01   +8.638259215119186e-01; +6.278055175564954e-01   +7.275757659158906e-01   +9.370173356785094e-01   +8.115119520255073e-01   +2.188325970484409e-02; +9.093558192355449e-01   +9.782665393306396e-01   +9.159685676932959e-01   +9.577845191151866e-01   +7.248027002612408e-01; +2.544773638683608e-01   +8.702777543724635e-01   +4.960547686109639e-01   +8.242538682108577e-01   +8.936649447477230e-01; +6.416994114923971e-01   +4.757348957025919e-02   +8.876182565942469e-01   +6.009442833299971e-01   +6.766069521039034e-01; +4.838079368694589e-01   +2.248930325010746e-01   +8.217323811775379e-01   +3.095990790564429e-01   +1.194526924698606e-01; +8.428459638713791e-01   +1.812890180169087e-01   +1.073021868025541e-01   +2.773642506946258e-02   +8.391994824566665e-01; +3.045601481682811e-01   +5.593100047993838e-01   +2.512899373841796e-01   +3.930986217530554e-01   +6.507953918376852e-01];
L2_L3_iAMPA_netcon = [+7.703240150300978e-01   +5.795610232237650e-01   +4.140691474193169e-01   +5.184535074815778e-02   +5.184349710255540e-01   +1.838116424612613e-01   +4.436644708111573e-01   +2.737512712673514e-01; +9.264872481582773e-01   +1.465465188179101e-01   +4.213746086540271e-01   +3.618411115880243e-01   +6.087816636366032e-01   +2.008034386797118e-01   +3.789430951622376e-01   +7.439478491670640e-01; +5.793229451001304e-01   +4.743060385069327e-01   +2.957179754190809e-01   +6.744147426317046e-01   +7.223183647504311e-01   +4.993915261723179e-01   +6.064980251946461e-01   +6.394439286696326e-01; +8.431771209709729e-01   +1.564620902896912e-01   +5.651166846186071e-01   +9.233023342727887e-01   +5.877628331301418e-01   +6.934503582977608e-01   +9.053944044977756e-01   +2.654718511336768e-01; +1.498249789498580e-01   +4.569172536870981e-01   +5.524424936071923e-01   +2.679700848809233e-01   +1.911276519215567e-01   +9.009943803322831e-01   +1.021529822019631e+00   +3.059980295806805e-01];
L1_L4_iGABA_netcon = [+9.588227981709605e-01   +1.003927862253911e+00   +1.019744581226953e+00   +1.010846036993252e+00   +1.033125814861117e+00   +9.958554121056813e-01   +1.013856708307514e+00; +9.843315847709334e-01   +1.016745568363156e+00   +1.018572412090502e+00   +9.931312412079114e-01   +9.932779354445684e-01   +1.001867331429104e+00   +1.061838548848461e+00; +9.783455110668614e-01   +9.918518242398873e-01   +9.885229983520278e-01   +9.601303155650546e-01   +1.017091622962474e+00   +9.955634435991823e-01   +1.022094503708131e+00; +9.713039172011423e-01   +1.003116751576382e+00   +1.042456145925809e+00   +1.010280482095297e+00   +9.700322732635417e-01   +1.020382828747036e+00   +1.012434304141539e+00; +9.911901696736420e-01   +9.881432963592187e-01   +9.558304729773516e-01   +9.904773723390430e-01   +1.016417874413019e+00   +9.791576463534947e-01   +1.021048370376928e+00; +1.022374183607991e+00   +9.785591139270721e-01   +1.020388645371153e+00   +9.840756599346359e-01   +9.767905722350775e-01   +1.036359557144292e+00   +9.897215231827564e-01; +1.015093556393848e+00   +9.993355571178691e-01   +9.662569764705476e-01   +9.760045549899341e-01   +9.950967791715015e-01   +1.024112717172144e+00   +1.001151483078258e+00; +1.069621583491698e+00   +1.005854772161801e+00   +9.909314516052298e-01   +1.008065406084782e+00   +9.983499309704535e-01   +9.890295143040480e-01   +1.012881235262795e+00; +1.021404007410277e+00   +1.008260855856382e+00   +9.613381823787072e-01   +1.028903607851697e+00   +9.899108899403944e-01   +1.022859604237516e+00   +9.924543819930128e-01; +1.018739820309217e+00   +1.013229826209347e+00   +1.001852300544355e+00   +9.748169847602047e-01   +1.036394394410433e+00   +9.992038343650175e-01   +9.733963632426815e-01; +1.002718514472375e+00   +9.932862146053839e-01   +9.895956079484967e-01   +1.035885827444050e+00   +1.010866551034894e+00   +1.018871768971565e+00   +9.909959592075052e-01; +9.626428533837410e-01   +1.008140684235384e+00   +1.021476364054371e+00   +1.034017947626884e+00   +1.007350268868845e+00   +9.816597606701271e-01   +9.991481532274827e-01];
L4_L1_iGABA_netcon = [+1.028765247507194e+00   +9.939414369859607e-01   +1.021145572499006e+00   +9.957906221572917e-01   +9.989442501318188e-01   +1.002397983027113e+00   +9.772954530122822e-01   +9.705554477911672e-01   +1.002339503327901e+00   +9.709623717150161e-01   +1.029283272026146e+00   +1.011308176474502e+00; +9.949468718525110e-01   +1.007892196672632e+00   +1.023594584535826e+00   +1.024403399250817e+00   +9.824604509215267e-01   +1.009944894315918e+00   +1.013143644303810e+00   +1.040073937764121e+00   +9.766382114221582e-01   +9.898620974200109e-01   +1.021018074401637e+00   +9.820093306665707e-01; +1.010148311462449e+00   +9.779805486270035e-01   +1.011894084134109e+00   +1.030828957867736e+00   +1.000396270223357e+00   +9.966006506358821e-01   +1.001009104622633e+00   +9.715596069562005e-01   +1.033307768638406e+00   +1.001983099448772e+00   +9.882801994961898e-01   +1.032615991141054e+00; +1.010670281197618e+00   +9.943372080326713e-01   +9.940883698435741e-01   +9.797593091297457e-01   +1.003914825897907e+00   +1.024233173656488e+00   +1.013893766669347e+00   +1.041971574758716e+00   +1.053751850060417e+00   +9.949259882505920e-01   +9.797366572797079e-01   +1.011944268412050e+00; +1.001548133892866e+00   +9.951235679943835e-01   +1.019813479929948e+00   +9.754112827005813e-01   +9.898207991603113e-01   +9.991440755443013e-01   +9.867143669068827e-01   +9.941848270190112e-01   +9.942740378484012e-01   +9.651863950940653e-01   +9.795958523214253e-01   +1.032447732616683e+00; +9.762293966313107e-01   +9.890776446402871e-01   +1.028032599175749e+00   +9.720735965072590e-01   +9.787697822932557e-01   +9.489028453838926e-01   +1.007690611456081e+00   +9.838313508841899e-01   +1.035017198308593e+00   +9.646367568789681e-01   +1.003958636657829e+00   +9.836590201474613e-01; +1.027904710366343e+00   +9.951083453980087e-01   +1.016866578805370e+00   +9.974327686742090e-01   +9.808732881821407e-01   +9.818504600604703e-01   +9.901530841389125e-01   +1.005762117370181e+00   +1.014080037003360e+00   +9.771579211167631e-01   +1.000174856735406e+00   +9.694733531284381e-01];
L1_L3_iAMPA_netcon = [+9.816192813128972e-01   +1.012940665411995e+00   +9.780456465261111e-01   +1.056625865134862e+00   +1.007027235639724e+00   +1.022124175337723e+00   +9.920249046489590e-01; +1.002774771824991e+00   +9.888297148645030e-01   +9.933320079140390e-01   +1.022774448555654e+00   +9.969825469187974e-01   +1.023920303577071e+00   +9.588851011037746e-01; +1.045158609152405e+00   +9.887547704569477e-01   +1.020562065946335e+00   +9.896467958939973e-01   +1.007956712512428e+00   +9.979795658949302e-01   +9.758173716867765e-01; +9.957346701682099e-01   +9.915664645513804e-01   +9.981124852723061e-01   +1.012647454310924e+00   +9.796485567977270e-01   +1.008842348317574e+00   +1.010965095134178e+00; +1.016206353177329e+00   +1.032773996408328e+00   +9.942567666468355e-01   +9.683896088557457e-01   +1.016371989482470e+00   +1.018759654210439e+00   +9.786219058572592e-01];
L3_L1_iGABA_netcon = [+1.000107704340357e+00   +9.925926834281447e-01   +9.559834937394933e-01   +9.900654888913152e-01   +1.001376573733484e+00; +1.041535364289853e+00   +1.018692593690605e+00   +9.729924519414535e-01   +9.808630127129359e-01   +9.818744096909747e-01; +1.004615434695202e+00   +1.001432762842019e+00   +1.013538691242041e+00   +9.926655541826113e-01   +1.011756250583043e+00; +1.046305508102537e+00   +9.866587486171113e-01   +1.022399797536896e+00   +1.039623068535909e+00   +1.007082190541682e+00; +9.909415117297830e-01   +1.039857811921544e+00   +9.968629827717805e-01   +9.673304449763661e-01   +1.015020732651856e+00; +1.032229324593406e+00   +9.936097060436926e-01   +9.920016791994563e-01   +1.018577180771901e+00   +9.916393741018550e-01; +1.016415767665052e+00   +9.652524272151602e-01   +9.780475909815565e-01   +1.038457791192702e+00   +1.021276892756961e+00];
L5_Input1_iAMPA_netcon = [+9.977799500642734e-01   +1.042650690545047e+00   +9.887262006351408e-01   +9.991457567971472e-01   +9.957110366045560e-01   +1.016611392950536e+00];
L6_Input2_iAMPA_netcon = [+1.018143124262785e+00   +1.019355538392704e+00   +1.003032229769763e+00   +1.014008079860595e+00];
L5_L6_iAMPA_netcon = [+3.395057818147268e-01   +2.530676096636839e-01   +3.835690945500125e-01   +7.076128864875769e-01   +8.819934317854383e-01   +4.599024988314719e-01; +9.610970193362544e-01   +5.299619348134071e-01   +5.547791695774766e-01   +5.094139802151317e-01   +7.226742468770230e-01   +7.686455075916890e-01; +4.830504437461767e-01   +5.560068176217167e-01   +7.355496609430461e-01   +1.370685273851018e-01   +2.904827451944176e-01   +3.538147713512375e-01; +2.297875757562688e-01   +6.474996479102460e-02   +4.785663630020149e-01   +9.681886746150811e-01   +8.332313264930906e-01   +5.781650829520033e-01];
L4_L5_iAMPA_netcon = [+3.794841026564674e-01   +6.586364225420865e-01   +1.935682454591028e-01   +8.142670260756667e-01   +8.306631441905928e-01   +2.170164311722051e-01   +7.432887586748839e-01   +3.030028781562483e-01   +5.845603694247687e-01   +7.963035500376543e-01   +3.169456967263807e-01   +4.979506356958239e-01; +8.893731490199861e-01   +6.090691391341613e-01   +2.881862898939990e-01   +2.472835440574717e-01   +1.572396641438963e-01   +8.004288198024564e-01   +3.094727167376606e-01   +5.524081018015630e-01   +6.930820254381753e-01   +8.639476426603866e-01   +7.781177926844864e-02   +6.223852925521761e-01; +9.480765309879620e-01   +8.821293570374256e-01   +8.006879098686570e-01   +9.681409417945263e-01   +1.227923381938475e-01   +2.782391435286398e-01   +3.546041898495549e-01   +9.137771629131507e-01   +8.237789242370593e-01   +5.254774654730742e-01   +9.214600480419629e-01   +7.961223325412443e-01; +5.579438766686449e-01   +3.329259459471872e-01   +6.887159405175243e-02   +8.260255774769407e-01   +3.300719207487957e-02   +5.711724884692020e-01   +6.650348763833748e-01   +2.667495159159884e-01   +6.418571366658017e-01   +3.659567233025063e-01   +5.793875845783419e-01   +6.948836065372905e-01; +3.262117602062140e-01   +2.458522517205912e-01   +4.719679574931067e-01   +3.131215729636769e-01   +5.508577426843492e-01   +4.526162314231156e-01   +8.526314079475085e-01   +8.186666223042206e-01   +5.246802141904117e-01   +9.038824562666293e-01   +6.601475939605055e-02   +5.734264317168127e-01; +4.630346674630086e-01   +7.444211330377770e-01   +5.052236740165090e-01   +2.904547058212588e-01   +4.420583419790672e-01   +9.057267856485994e-01   +4.383524825326768e-01   +9.690752205481652e-02   +8.640598597767993e-01   +3.366609685308889e-01   +7.394750984756192e-01   +1.640793040111702e-01];

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
