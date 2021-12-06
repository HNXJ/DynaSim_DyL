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
L2_L1_iGABAa_netcon = [+6.693130558603867e-01   +7.841752169462177e-02   +5.784061970165933e-01   +9.354039931162513e-01   +5.943916966189606e-01   +8.553323824925226e-01   +8.871552277297028e-01   +3.769923836966838e-01; +2.058683620534527e-01   +1.183549911918682e-01   +9.662870742420993e-01   +6.597189063083490e-01   +4.249987926907537e-01   +3.967675959116126e-01   +4.345269483384834e-02   +9.253541906335576e-01; +9.520325094983106e-01   +6.412363715142618e-01   +8.434157690132793e-01   +8.157972230549391e-01   +4.698977647930989e-01   +6.385073661782545e-01   +2.720901854309113e-01   +1.800444291208581e-01; +7.076496056542148e-01   +9.669742732393130e-01   +6.984769470401685e-01   +4.796339060162255e-01   +8.272589488016020e-01   +8.617265073707071e-02   +5.404607213592302e-01   +5.169563971100314e-01; +7.233425758640420e-01   +9.241349163688461e-03   +7.716827357005128e-01   +3.529404594793963e-01   -2.134361352639265e-03   +8.614086717500620e-01   +3.043500528412465e-03   +9.293787843903566e-01; +8.986491460260736e-01   +8.100204650506102e-01   +7.447708647520841e-01   +3.768615793933383e-01   -1.289676950087894e-02   +6.974971552574799e-01   +9.108425125018647e-01   +8.929813287541144e-01; +4.313420091652080e-01   +1.782573284268594e-01   +2.338119342944200e-01   +8.923952457223916e-01   +1.576893286012587e-01   +8.803344665860278e-01   +4.190252429678371e-02   +7.974283689163674e-01];
L1_L2_iGABAa_netcon = [+6.808349667519213e-01   +9.250275182341801e-01   +1.310731129688665e-01   +2.263130567044216e-01   +3.393633081117055e-01   +2.715836255133554e-01   +4.544098900814840e-01; +4.465994602975437e-01   +6.381291567475142e-01   +7.395943698418099e-01   +3.156834224247592e-01   +4.734957572176343e-01   +5.243986036872011e-01   +4.447419513120888e-01; +2.243407331480964e-01   +5.629224300318265e-01   +1.632769207310600e-01   +9.052370261257775e-01   +3.697392965925425e-01   +8.305873282538966e-02   +1.479412220231796e-01; +7.029277998953730e-02   +3.566155646188466e-01   +2.806675521585877e-01   +7.121824254266625e-01   +6.810424017697296e-01   +2.721760671307539e-02   +1.647738732818670e-01; +5.728898745413997e-01   -8.123150634552790e-03   +6.133219364485516e-01   +6.146772737472606e-01   +1.595368705607751e-01   +6.427396446199236e-02   +7.188092980971957e-02; +1.307389405130143e-01   +6.815338789384606e-01   +5.048449041457280e-01   +1.283915961963686e-01   +2.564784868167531e-01   +5.182598978511402e-01   +1.591238893178425e-02; +7.706502419962357e-01   +3.753809595116274e-01   +4.730259281237952e-01   +8.817422214924417e-01   +9.498062739426731e-01   +8.398431760732428e-01   +2.445523908697884e-01; +3.573963637691899e-01   +5.496780421796985e-01   +7.513286376737574e-02   +3.670374230377436e-01   +6.607714892269633e-01   +7.032082104511272e-01   +7.733538787514895e-01];
L2_L5_iAMPA_netcon = [+6.059353754290470e-01   +6.654861849207924e-01   +1.877379862174809e-01   +7.604700539592810e-01   +5.421971107084549e-01   +4.122845962597887e-01   +4.807401991514417e-01   +2.616292128240481e-01; +9.611138694041466e-01   +2.576922779682736e-02   +1.563622726799741e-01   +1.004653920252563e-01   +5.978333214639013e-01   +6.317011781718542e-01   +8.748625625537677e-02   +7.535142504660929e-02; +6.590121951351340e-01   +2.300928731190240e-01   +5.406299667831530e-01   +4.752164354290797e-01   +8.643982902459137e-01   +1.760393201448538e-01   +3.870804363770056e-02   +7.406960424760273e-01; +4.504982526045129e-01   +5.290183723584320e-01   +9.595823631593315e-01   +6.752374189158777e-02   +2.341796729854576e-01   +3.786113647403797e-01   +4.244327876778570e-01   +9.433905548645957e-01; +3.600327667979385e-01   +5.837454536866236e-01   +7.494511993674978e-01   +7.359795156121193e-01   +3.953062050123286e-01   +4.190858629562442e-03   +5.820436987957629e-01   +2.331190411291037e-01; +8.459541867353600e-01   +3.785667448005919e-01   +8.458496934253922e-01   +9.719022681914169e-01   +2.902308695006817e-01   +5.120997307537233e-01   +9.232600648037914e-02   +3.877232406188724e-01];
L5_L2_iGABA_netcon = [+4.582502879150033e-01   +2.087881003029476e-02   +1.086624916815001e-01   +8.989853750618013e-01   -1.038451168466852e-02   +6.227796695794938e-01; +4.487041180695701e-01   +1.824727078972591e-02   +6.261111908237891e-01   +8.536184119584908e-02   +9.228211195212759e-01   +4.936598564876470e-01; +1.214669888071347e-01   +7.663445089669423e-03   +6.266887727589247e-01   +4.049527279991243e-01   +7.718211362603059e-01   +6.208243222674673e-02; +8.126880547306843e-01   +5.103656802608895e-01   +5.514691308971220e-01   +6.299241264767019e-01   +1.966206764450740e-01   +8.105135538628807e-01; +3.382110354470909e-02   +2.312436736922616e-01   +2.722139352707900e-02   +9.083539332998442e-01   +2.391434905272717e-01   +3.520858175969111e-01; +2.800243718745890e-01   +5.110868684200367e-01   +9.497260568681919e-01   +2.850108629513780e-01   +2.398077431898558e-01   +2.437389914360602e-01; +2.852709486491650e-02   +1.629720384612853e-01   +2.972765617620927e-02   +8.053910218018455e-01   +7.354534243752905e-01   +3.501658488993701e-01; +4.082373903805948e-01   +5.573447852520353e-01   +7.357797953628701e-01   +7.915619678997998e-01   +1.044276071779059e-01   +5.995282279258292e-01];
L3_L2_iAMPA_netcon = [+2.399674944764828e-02   +4.668141172738254e-01   +8.789619444580699e-02   +7.977878701444996e-01   +4.420577956098333e-01; +8.899064381437374e-01   +3.285155498503147e-01   +7.590300230573928e-01   +3.651479581645878e-01   +8.601656990338309e-01; +4.278612590961858e-01   +7.372028219283454e-01   +3.446502825929210e-01   +3.338471156624855e-01   +3.864809226921467e-01; +8.954155528794725e-01   +9.000530212058546e-01   +9.427491837460598e-01   +8.584018090450798e-01   +7.041091268296534e-01; +3.660948085216553e-01   +9.263490408164916e-01   +5.370864331864986e-01   +7.136669669986296e-01   +7.519208882937812e-01; +4.833251535385621e-01   +1.190682676147116e-01   +6.509548327711550e-01   +5.389190528847463e-01   +3.271524691813676e-01; +3.145508453772754e-02   +4.224411463069370e-01   +3.739231263408861e-01   +5.108018007381439e-01   +8.526796765337571e-01; +6.155307909507464e-01   +3.722304639448457e-01   +2.661345850964014e-01   +5.874948390429626e-01   +7.601827228747250e-01];
L2_L3_iAMPA_netcon = [+7.066876057313141e-01   +5.615691932911856e-01   +1.750974559683405e-01   +3.765930768119270e-02   +2.314969329673408e-01   +3.577853260082134e-01   +6.439144652867860e-01   +8.501436188957369e-01; +3.339350713481635e-01   +5.175019670716666e-01   +8.074155703266721e-01   +3.120612071611943e-01   +3.152871508832395e-01   +7.851948926494022e-01   +4.005535330488702e-01   +7.533795375428455e-01; +6.137862728483291e-01   +6.503968050075984e-01   +1.284566420493403e-01   +5.788783723077453e-01   +9.725507776391196e-01   +7.969148005055361e-01   +4.542636165532496e-01   +8.087276035716336e-01; +2.645026139899346e-01   +1.599196660977438e-01   +4.652230392330546e-01   +4.753138698172127e-02   +1.041057315818167e-02   +7.079919804183515e-02   +7.569714023827402e-01   +3.470874361670396e-01; +6.204577191724826e-02   +4.935042375274826e-02   +1.699443349043597e-01   +3.326322099834520e-01   +2.988559149771026e-01   +7.176805328983595e-01   +6.353493832749294e-01   +4.744768637807825e-01];
L1_L4_iGABA_netcon = [+9.854195231607915e-01   +9.863235846298095e-01   +9.686125409457891e-01   +9.774594405025818e-01   +9.846888983203925e-01   +9.791562490399450e-01   +9.723665744361146e-01; +9.745839512334754e-01   +9.745545661649208e-01   +9.762082869488424e-01   +9.724923413741283e-01   +9.794026032299719e-01   +9.677055226030721e-01   +9.811793625567111e-01; +9.906478582346526e-01   +9.870859630984189e-01   +9.826105484768295e-01   +9.830205758535459e-01   +9.818964610598943e-01   +9.853868852805430e-01   +9.810051013161831e-01; +9.814900042210926e-01   +9.931599903612458e-01   +9.850134074705814e-01   +9.727037685447284e-01   +9.872264990646406e-01   +9.826437867563350e-01   +9.792386475716257e-01; +9.850954566762363e-01   +9.827097711847841e-01   +9.821116561253415e-01   +9.765864541637448e-01   +9.816584442050110e-01   +9.829891047378009e-01   +9.889836448401385e-01; +9.833156858226747e-01   +9.908080406730621e-01   +9.781601180448308e-01   +9.835284116258800e-01   +9.844067325281982e-01   +9.759934349342835e-01   +9.793740718908475e-01; +9.757711927273195e-01   +9.871891544429122e-01   +9.940958115789575e-01   +9.751591861458775e-01   +9.681839525903890e-01   +9.917580095531936e-01   +9.774939822146060e-01; +9.777391206474254e-01   +9.841523113557037e-01   +9.854917331521965e-01   +9.866681339764575e-01   +9.666325654053280e-01   +9.837697042903857e-01   +9.895720965389997e-01; +9.870783274573346e-01   +9.709593322555787e-01   +9.865686238781460e-01   +9.763200219019701e-01   +9.817857499361603e-01   +9.812802019718126e-01   +9.719214516951594e-01; +9.845070694393666e-01   +9.882090962656316e-01   +9.878947267335880e-01   +9.815456233739694e-01   +9.578276919304728e-01   +9.743636269187634e-01   +9.693412458179030e-01; +9.772215966161235e-01   +9.766916406832417e-01   +9.804302114346436e-01   +9.804996322342703e-01   +9.738556687551729e-01   +9.859185026852595e-01   +9.790463061070849e-01; +9.799419011737311e-01   +9.710943012342995e-01   +9.617800530549381e-01   +9.793030238757450e-01   +9.813197073924185e-01   +9.772002649878493e-01   +9.837058309051839e-01];
L4_L1_iGABA_netcon = [+9.815474762179937e-01   +9.794064863539811e-01   +9.914277369244062e-01   +9.862741818846886e-01   +9.614073999594706e-01   +9.886882646879828e-01   +9.773977794696130e-01   +9.815158215032377e-01   +9.895845804416618e-01   +9.891368011218650e-01   +9.799299668420471e-01   +9.761005871406523e-01; +9.823600816335669e-01   +9.804116141657848e-01   +9.679040650611304e-01   +9.971127954369645e-01   +9.870116487184331e-01   +9.805363738780464e-01   +9.869770314719846e-01   +9.809912329583527e-01   +9.796114519795603e-01   +9.707596056216465e-01   +9.717883475549455e-01   +9.863246671871437e-01; +9.660462607704401e-01   +9.878430365625558e-01   +9.809912972066145e-01   +9.863991657732811e-01   +9.900744056311858e-01   +9.791092832501710e-01   +9.735553635646430e-01   +9.938172437363765e-01   +9.815155933671296e-01   +9.777497669269943e-01   +9.690495227927655e-01   +9.932874679076561e-01; +9.839757132496639e-01   +9.771223684512824e-01   +9.656783244436999e-01   +9.830534900193515e-01   +9.846587559257584e-01   +9.810196332077784e-01   +9.703750231514368e-01   +9.805162897474874e-01   +9.837799966046006e-01   +9.889276817069812e-01   +9.652124002427134e-01   +9.794489599058787e-01; +9.778386834694193e-01   +9.855049662838844e-01   +9.835285563596434e-01   +9.839123090673046e-01   +9.780468551208782e-01   +9.857802180526066e-01   +9.880193751201598e-01   +9.688983332554139e-01   +9.846608152483410e-01   +9.753526761952008e-01   +9.740730544721273e-01   +9.878009928813842e-01; +9.815417706439191e-01   +9.849079715366051e-01   +9.658986083344226e-01   +9.736049432722272e-01   +9.804580704319105e-01   +9.691421727524576e-01   +9.733997023765697e-01   +9.793838517461656e-01   +9.827234261334431e-01   +9.775033944716518e-01   +9.835196470343698e-01   +9.782395009706858e-01; +9.799061965438308e-01   +9.682103030496602e-01   +9.733380179176978e-01   +9.783790654651280e-01   +9.795724750818910e-01   +9.749546057453267e-01   +9.731859945265052e-01   +9.770598516901563e-01   +9.905099228490822e-01   +9.796989876506006e-01   +9.789209522967529e-01   +9.823179308092357e-01];
L1_L3_iAMPA_netcon = [+9.795962148089650e-01   +9.805571020598791e-01   +9.844670448043662e-01   +9.763968201237816e-01   +9.823890326528391e-01   +9.875482444001330e-01   +9.822253996653471e-01; +9.701027121284190e-01   +9.833581315498238e-01   +9.796111573731250e-01   +9.757136286916444e-01   +9.892758213832740e-01   +9.847047770325448e-01   +9.872589213450351e-01; +9.754743827480806e-01   +9.656148177388353e-01   +9.808370564834807e-01   +9.781469164363398e-01   +9.755802357928088e-01   +9.724582417747751e-01   +9.811093295549146e-01; +9.887257640734001e-01   +9.722974816668598e-01   +9.678434148427709e-01   +9.912329998206330e-01   +9.784153347514828e-01   +9.843881111434736e-01   +9.660206526201085e-01; +9.869349454674273e-01   +9.898179151709340e-01   +9.640438579678584e-01   +9.825672831651667e-01   +9.719782098940123e-01   +9.827295812820567e-01   +9.882360933080980e-01];
L3_L1_iGABA_netcon = [+9.862864732563106e-01   +9.770886697987056e-01   +9.892483661852780e-01   +9.824677845228997e-01   +9.651170805368143e-01; +9.800126371848610e-01   +9.844755961637917e-01   +9.950403123171676e-01   +9.788182940982362e-01   +9.809578073666169e-01; +9.775780847972898e-01   +9.850929247835278e-01   +9.953442055088062e-01   +9.796617592820218e-01   +9.798888768219119e-01; +9.794834022307768e-01   +9.692179623218887e-01   +9.791762368557604e-01   +9.780525630996268e-01   +9.845261422630533e-01; +9.670508159808151e-01   +9.832032410296401e-01   +9.836148576562813e-01   +9.690275155803321e-01   +9.780264349916641e-01; +9.805288205181260e-01   +9.883517114472818e-01   +9.784534810731951e-01   +9.957640970066390e-01   +9.897276211737189e-01; +9.810453102790379e-01   +9.808588704723632e-01   +9.679647637897822e-01   +9.808824760163621e-01   +9.800351399570404e-01];
L5_Input1_iAMPA_netcon = [+9.683036076429657e-01   +9.858340582303471e-01   +9.820683223888269e-01   +9.895693636423901e-01   +9.724044229934627e-01   +9.712388140929096e-01];
L6_Input2_iAMPA_netcon = [+9.742254125488469e-01   +9.914575506100222e-01   +9.774305421790798e-01   +9.833800168803674e-01];
L5_L6_iAMPA_netcon = [+3.320646529669746e-01   +1.260767551869171e-01   +4.798194137952609e-01   +5.556435638984964e-02   +4.978502870887959e-01   +7.826099552692912e-01; +3.684348859021255e-01   +1.717330505101636e-01   +9.105099023380896e-01   +5.443932310743989e-01   +5.618789429070946e-01   +4.123705304216473e-02; +1.390207838470843e-02   +5.422216062287604e-02   +4.037474603442404e-01   +1.194651477523747e-01   +2.360552594420307e-01   +4.258715623467174e-01; +8.914185692705519e-01   +4.458393170036880e-01   +3.893685345518376e-03   +2.252901750443123e-01   +3.657206446702217e-01   +2.111007984075106e-01];
L4_L5_iAMPA_netcon = [+2.770733676822990e-01   +9.930002198409119e-01   +7.107538509725726e-02   +6.174964146453337e-01   +3.259661046819941e-01   +9.008978664701799e-01   +9.764066456797211e-01   +6.888799107655310e-01   +4.038521226537088e-01   +1.042310437696887e-01   +3.983999866046189e-01   +7.966841420432913e-01; +3.610734416475808e-01   +3.621384517878842e-01   +7.283396886241891e-01   +8.199045621868559e-01   +7.332677853200948e-01   +6.633780071518198e-01   +2.546770219543684e-01   +7.290201510974508e-01   +6.423833273551616e-01   +5.250051898884794e-01   +9.134720036980071e-01   +6.108711989274436e-01; +5.436057621205010e-01   +4.970648129004196e-01   +6.027686580468561e-01   +5.661793256863320e-01   +6.743521519955504e-01   +2.378419312303767e-01   +3.433133827181133e-01   +1.481199160105757e-01   +5.305141719876139e-01   +9.475149098995431e-01   +6.608632946798677e-01   +2.509339115157103e-01; +1.510324516292962e-01   +7.613038470190483e-01   +8.988779373836243e-01   +1.665980541979404e-01   +7.864620481508985e-01   +4.267492777319583e-01   +3.928594910221578e-01   +9.194735853990604e-01   +4.352254670779439e-01   +8.053981914223501e-01   +7.515770650661162e-01   +4.678656296033060e-01; +9.557754594376168e-01   +7.199205771696511e-01   +2.199201601054212e-01   +5.371039829485487e-01   +2.765815630553076e-02   +4.109166543912511e-01   +1.725083893780750e-01   +4.255732425365552e-01   +9.296329569417280e-01   -6.871293401046415e-04   +8.220993447822259e-01   +9.462684590408744e-01; +4.806239288219287e-01   +4.340265692621810e-01   +4.679434480449692e-01   +9.298453055969657e-01   +4.729910652367317e-01   +5.395147815845983e-01   +4.713545725533005e-03   +6.509209451383302e-01   +8.539884995919603e-01   +8.606382088167924e-01   +2.400964969382297e-01   +5.956586679200730e-01];

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
