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
L2_L1_iGABAa_netcon = [+6.623922184001321e-01   +7.872423943170437e-02   +5.679475152172303e-01   +9.271059102966903e-01   +5.879979455205738e-01   +8.530700503446762e-01   +8.770437758759093e-01   +3.746048115704157e-01; +1.999208707353798e-01   +1.087549432876293e-01   +9.629086134501177e-01   +6.611897315434169e-01   +4.123632285956480e-01   +3.871404228830926e-01   +3.422294636755866e-02   +9.196077335650128e-01; +9.408881332822864e-01   +6.388803050896186e-01   +8.375582418337879e-01   +8.091088184640304e-01   +4.609691494259205e-01   +6.365393979548620e-01   +2.659371399567600e-01   +1.676853825814979e-01; +7.028172775110109e-01   +9.566927676113194e-01   +6.924145588675326e-01   +4.774323841895735e-01   +8.115170269735253e-01   +8.346374729238321e-02   +5.351501004848855e-01   +5.013505086689015e-01; +7.249139055522019e-01   -2.183836657061481e-03   +7.577679597599148e-01   +3.466683446464405e-01   +2.123145996423019e-03   +8.549800277969967e-01   -9.107446316747574e-05   +9.210762408463619e-01; +9.011499757587915e-01   +8.015551785398268e-01   +7.452307407184371e-01   +3.770051021246976e-01   -3.004993437010023e-02   +6.961415813746478e-01   +9.040805996500620e-01   +8.987806220697288e-01; +4.286327414588692e-01   +1.802317524905998e-01   +2.390801385706134e-01   +8.857006835185957e-01   +1.542005168773731e-01   +8.789527043248920e-01   +3.442848787161040e-02   +7.916474048867250e-01];
L1_L2_iGABAa_netcon = [+6.779722665704849e-01   +9.068957124146753e-01   +1.283288660889151e-01   +2.236715755003917e-01   +3.362154767093334e-01   +2.638547994002438e-01   +4.477731471258047e-01; +4.470689487857958e-01   +6.385411917817014e-01   +7.337044821086397e-01   +3.113613316475962e-01   +4.687414528988539e-01   +5.169113842596944e-01   +4.392849611179549e-01; +2.161004681231916e-01   +5.513049286835582e-01   +1.603210959817296e-01   +9.010332508695328e-01   +3.713264142770931e-01   +7.115182171326431e-02   +1.479029699145514e-01; +5.943439912646849e-02   +3.425787836095079e-01   +2.716629492607748e-01   +7.022287740948451e-01   +6.743594242429235e-01   +3.100223896709114e-02   +1.597614064717612e-01; +5.692564769030388e-01   -1.566599536764512e-02   +6.062864993527155e-01   +6.153657811660233e-01   +1.518265099188329e-01   +5.615693069855072e-02   +6.694925640687886e-02; +1.192018586745010e-01   +6.812344848501793e-01   +4.913261329075297e-01   +1.176697771738078e-01   +2.495285414203227e-01   +5.065796902259659e-01   +1.670737634311677e-02; +7.623620283395176e-01   +3.667411312373524e-01   +4.686087059580292e-01   +8.716898566058690e-01   +9.449937126579522e-01   +8.324855982751257e-01   +2.409947983029922e-01; +3.460277860949425e-01   +5.413486498824882e-01   +7.640504126302940e-02   +3.635087536927911e-01   +6.540500830630511e-01   +6.948946919657125e-01   +7.690785403112119e-01];
L2_L5_iAMPA_netcon = [+5.965553856888535e-01   +6.652383713451272e-01   +1.822709426490977e-01   +7.590594216876313e-01   +5.305226534452396e-01   +4.052269785992314e-01   +4.756829865741748e-01   +2.552571300314022e-01; +9.607722956400607e-01   +1.141081217717164e-02   +1.495659645233483e-01   +9.220364941204851e-02   +5.951577167274997e-01   +6.329206077544305e-01   +8.495335417819526e-02   +7.411088617187682e-02; +6.565221440358043e-01   +2.288822435552678e-01   +5.291929806444829e-01   +4.696298397334293e-01   +8.523721193947499e-01   +1.749234706108311e-01   +3.270778800287289e-02   +7.410348284829408e-01; +4.467546393034674e-01   +5.240871114169828e-01   +9.701178994301611e-01   +6.481280031984156e-02   +2.266387912868418e-01   +3.703878105313616e-01   +4.236688076483694e-01   +9.339705059224480e-01; +3.579136450155734e-01   +5.809709943264050e-01   +7.466847793385200e-01   +7.316149873392371e-01   +3.894847812286760e-01   +7.326940503980059e-03   +5.715525855990673e-01   +2.279848957325722e-01; +8.415408865961517e-01   +3.768565690381216e-01   +8.353059291499283e-01   +9.655431325618506e-01   +2.772830427946135e-01   +5.039937172274588e-01   +8.269422719421221e-02   +3.809920228277484e-01];
L5_L2_iGABA_netcon = [+4.539617297837144e-01   +2.014216993524491e-02   +1.009799503133182e-01   +8.931607347950006e-01   -2.206334362764642e-02   +6.248652370049974e-01; +4.385699605590413e-01   +2.048889597928383e-02   +6.197400475917497e-01   +8.077557196184505e-02   +9.206308197683208e-01   +4.932572454526131e-01; +1.128383714502541e-01   +1.270491217457335e-02   +6.172228011434178e-01   +3.949519707210956e-01   +7.605500439092833e-01   +5.570889216060190e-02; +8.113015398521808e-01   +5.056115896535804e-01   +5.427011126257546e-01   +6.296290207057020e-01   +1.922821849053678e-01   +8.102139206363421e-01; +3.537510599317932e-02   +2.220414114159441e-01   +2.171801192245600e-02   +9.063204892147794e-01   +2.300900697619131e-01   +3.437193512141378e-01; +2.803767667243316e-01   +4.926499434370999e-01   +9.443141912201198e-01   +2.771127020344845e-01   +2.295075828396198e-01   +2.358310890912933e-01; +2.498605463406755e-02   +1.532360591297988e-01   +2.741779782335602e-02   +7.955240650789327e-01   +7.205741876227787e-01   +3.457650540639342e-01; +4.021221720790706e-01   +5.570273183538280e-01   +7.207101655975947e-01   +7.764170770494341e-01   +1.025025676119784e-01   +5.861453797403657e-01];
L3_L2_iAMPA_netcon = [+2.112154289343287e-02   +4.562984786863304e-01   +7.667133701953489e-02   +7.947393882356459e-01   +4.413442424197472e-01; +8.854079769494664e-01   +3.232218169338856e-01   +7.506371234528416e-01   +3.526319328235095e-01   +8.469915713824824e-01; +4.241528650989581e-01   +7.430108747967406e-01   +3.377381087730471e-01   +3.275406863118544e-01   +3.782695012258394e-01; +8.879550896770724e-01   +8.940937091656236e-01   +9.302838767628047e-01   +8.491419579559696e-01   +6.992361745196648e-01; +3.588536765020485e-01   +9.143333285461636e-01   +5.368450584165196e-01   +7.064348798702796e-01   +7.434950567205529e-01; +4.798256928495436e-01   +1.131134629050695e-01   +6.465701114566389e-01   +5.360148587655602e-01   +3.291525797568424e-01; +2.481679991215086e-02   +4.215503590730626e-01   +3.664095751526305e-01   +5.072945435702861e-01   +8.449519062875757e-01; +6.157366042193624e-01   +3.612548281883390e-01   +2.625279844543196e-01   +5.848496627722828e-01   +7.552245896663115e-01];
L2_L3_iAMPA_netcon = [+7.117873537827187e-01   +5.552557538728123e-01   +1.720108278345237e-01   +3.169197047229005e-02   +2.264583243242555e-01   +3.537158142335477e-01   +6.410153561963652e-01   +8.485339696512362e-01; +3.299910421764279e-01   +5.102081467141329e-01   +8.100833521070704e-01   +3.087373126185184e-01   +3.084271447698776e-01   +7.760134592541249e-01   +3.856347890412959e-01   +7.478389826810724e-01; +6.038871520784662e-01   +6.448104419559364e-01   +1.284286732490572e-01   +5.787149424566771e-01   +9.700984506170086e-01   +7.885591471589884e-01   +4.472878501740030e-01   +7.997024512447434e-01; +2.601169468297320e-01   +1.593337499836934e-01   +4.586181229183258e-01   +3.588626739982463e-02   +4.128092657012857e-03   +6.559074293259212e-02   +7.468348715960427e-01   +3.379323609887950e-01; +4.726294437622956e-02   +4.461275705146227e-02   +1.636436950844462e-01   +3.326112723842853e-01   +2.938262071873104e-01   +7.070419027055106e-01   +6.267090427859962e-01   +4.721535283513923e-01];
L1_L4_iGABA_netcon = [+9.751295875394637e-01   +9.801051411042681e-01   +9.524182462179651e-01   +9.774390848270640e-01   +9.832507160778986e-01   +9.750122823280942e-01   +9.614698802830028e-01; +9.640946766290385e-01   +9.698704796989047e-01   +9.734707479723981e-01   +9.709297004229319e-01   +9.650027048282335e-01   +9.587908962932875e-01   +9.720626474476334e-01; +9.832476138664930e-01   +9.830182581803740e-01   +9.752134360527048e-01   +9.751941882532491e-01   +9.742568243102029e-01   +9.889897627883431e-01   +9.749680815564440e-01; +9.785628168355959e-01   +9.837299105832981e-01   +9.754277159490665e-01   +9.623736073601040e-01   +9.814033825475610e-01   +9.731777203401523e-01   +9.669457090473206e-01; +9.727514510729881e-01   +9.753920479677188e-01   +9.768629068418656e-01   +9.717095084330908e-01   +9.728192424377733e-01   +9.714288930809744e-01   +9.810700449325553e-01; +9.727706541873147e-01   +9.807351867560585e-01   +9.663177503480754e-01   +9.746095513457707e-01   +9.719215716285345e-01   +9.656464996733077e-01   +9.771918006820484e-01; +9.761668070218276e-01   +9.765695914087602e-01   +9.837536401913446e-01   +9.673775501727044e-01   +9.619497873970715e-01   +9.820276925231215e-01   +9.711461478688960e-01; +9.772420664966576e-01   +9.770185936333801e-01   +9.820451311477502e-01   +9.836973551577589e-01   +9.702861821676152e-01   +9.753423688935238e-01   +9.779772135752517e-01; +9.782055545202494e-01   +9.665224730156285e-01   +9.815900985504162e-01   +9.621487776768066e-01   +9.761882449078623e-01   +9.805851524527810e-01   +9.668573008698791e-01; +9.741811757406598e-01   +9.775126561651435e-01   +9.886943558142425e-01   +9.693142577225666e-01   +9.480063937792995e-01   +9.619555838730313e-01   +9.597915113561749e-01; +9.693951848341694e-01   +9.629890403809753e-01   +9.766228494136621e-01   +9.709901780819592e-01   +9.648261616178003e-01   +9.775871772967163e-01   +9.702137241616914e-01; +9.805192501366623e-01   +9.621741657547711e-01   +9.544545081597752e-01   +9.742665378382629e-01   +9.732094265044985e-01   +9.658500258815201e-01   +9.801807108665609e-01];
L4_L1_iGABA_netcon = [+9.716448384861357e-01   +9.669121351561831e-01   +9.923456330443170e-01   +9.846814498872112e-01   +9.544283099324551e-01   +9.864812129276118e-01   +9.732625414977700e-01   +9.755548586365406e-01   +9.912964803155266e-01   +9.852629901851440e-01   +9.777316527223542e-01   +9.681764530425873e-01; +9.786948464342358e-01   +9.779388557496159e-01   +9.626198989561281e-01   +1.003521765920987e+00   +9.870579476784094e-01   +9.798816631425190e-01   +9.667224392666812e-01   +9.840190368441661e-01   +9.658411103438934e-01   +9.691399382865938e-01   +9.644977717896984e-01   +9.816049317642218e-01; +9.574424855810884e-01   +9.865035672582021e-01   +9.695309599349657e-01   +9.726506988080463e-01   +9.739894647832488e-01   +9.749860185522297e-01   +9.560908020895150e-01   +9.902868736964068e-01   +9.727195909523050e-01   +9.780225756278917e-01   +9.625056022657064e-01   +9.845602922812654e-01; +9.748425999662129e-01   +9.719027115955415e-01   +9.570735150724295e-01   +9.766939429930919e-01   +9.810839011951336e-01   +9.718656867533610e-01   +9.664231014123196e-01   +9.761936918732644e-01   +9.727821204408725e-01   +9.740825938587935e-01   +9.629158554536579e-01   +9.755746928599529e-01; +9.839496110775114e-01   +9.769217085941994e-01   +9.794717550217102e-01   +9.844412427105986e-01   +9.724357136777401e-01   +9.728591641517531e-01   +9.900917090373451e-01   +9.702622791334256e-01   +9.750078001959170e-01   +9.728195014156407e-01   +9.656187163921008e-01   +9.817741071242150e-01; +9.760060034911842e-01   +9.762486210761234e-01   +9.622606357373323e-01   +9.711371129555874e-01   +9.688097663052214e-01   +9.602655326920664e-01   +9.679560291068662e-01   +9.782400144300111e-01   +9.727284889980022e-01   +9.772114507410503e-01   +9.752534721454834e-01   +9.871458370355067e-01; +9.726250314399812e-01   +9.620777787015161e-01   +9.597224458476513e-01   +9.693699880236731e-01   +9.615427336587370e-01   +9.697531229888885e-01   +9.739179787318981e-01   +9.699783185560216e-01   +9.797565750427939e-01   +9.778671107925996e-01   +9.676179863812768e-01   +9.750309012793441e-01];
L1_L3_iAMPA_netcon = [+9.737444787066470e-01   +9.745671029577390e-01   +9.768684161276681e-01   +9.703593155314230e-01   +9.823445643202816e-01   +9.827817206814614e-01   +9.812453818995671e-01; +9.688072560422042e-01   +9.718003012517374e-01   +9.677540272444226e-01   +9.691798211775718e-01   +9.750250476871396e-01   +9.825859975625419e-01   +9.811211665419776e-01; +9.731836075635838e-01   +9.477109874548058e-01   +9.687388077969344e-01   +9.680631963843135e-01   +9.665301657352465e-01   +9.637887370556104e-01   +9.700837298579771e-01; +9.793853186746820e-01   +9.664284857305557e-01   +9.591636661611592e-01   +9.835630336082900e-01   +9.753009413941259e-01   +9.820460410411090e-01   +9.513755324962472e-01; +9.818122623623964e-01   +9.839249392441317e-01   +9.562067120964317e-01   +9.763021288893847e-01   +9.617217536192677e-01   +9.718698419523767e-01   +9.840977813123484e-01];
L3_L1_iGABA_netcon = [+9.767623060412669e-01   +9.745890328968471e-01   +9.797602930746510e-01   +9.831814065561958e-01   +9.657641278097514e-01; +9.716812760147646e-01   +9.868576487734975e-01   +9.847725573917623e-01   +9.679545395074056e-01   +9.718853881741919e-01; +9.760832086054806e-01   +9.670451308687329e-01   +9.954828501008566e-01   +9.612116985806817e-01   +9.735945017214739e-01; +9.789288031186547e-01   +9.577078533101477e-01   +9.652622165739869e-01   +9.751106944933543e-01   +9.806930266577314e-01; +9.661467715875921e-01   +9.748717748167632e-01   +9.734966608838159e-01   +9.644534836039524e-01   +9.738885113098604e-01; +9.678073197876407e-01   +9.845809578199327e-01   +9.737855902365516e-01   +9.924605525431136e-01   +9.784840818011794e-01; +9.730374868164589e-01   +9.718118442684889e-01   +9.548101098529419e-01   +9.746308834545671e-01   +9.729580164126893e-01];
L5_Input1_iAMPA_netcon = [+9.688154114928045e-01   +9.737299752163758e-01   +9.728781222959172e-01   +9.816190416640167e-01   +9.606937173555077e-01   +9.684018915302889e-01];
L6_Input2_iAMPA_netcon = [+9.669637303342385e-01   +9.872682368415840e-01   +9.715193193407528e-01   +9.812978287189739e-01];
L5_L6_iAMPA_netcon = [+3.234760085976982e-01   +1.182706216987583e-01   +4.769803229140133e-01   +5.266147729974641e-02   +4.868301528785827e-01   +7.730124528741975e-01; +3.600496530648075e-01   +1.683435909152277e-01   +9.076950762669801e-01   +5.377148734302024e-01   +5.554702564336635e-01   +4.127048661203103e-02; +1.110050273266294e-02   +4.972105155880378e-02   +3.956288236973690e-01   +1.164635523647483e-01   +2.366001687465106e-01   +4.189200801833881e-01; +8.829295063956621e-01   +4.415705944128675e-01   -1.145413464128842e-04   +2.148166943203381e-01   +3.615513885929912e-01   +1.976431827088637e-01];
L4_L5_iAMPA_netcon = [+2.756507980528288e-01   +9.881689823081586e-01   +6.863126939697985e-02   +6.087119155045210e-01   +3.194160283282524e-01   +8.924743449022446e-01   +9.724224725911023e-01   +6.819984435464290e-01   +4.051807274420925e-01   +9.999861914326698e-02   +3.936570726883201e-01   +7.897100055595727e-01; +3.532672986442268e-01   +3.545912486253595e-01   +7.228654135130853e-01   +8.191290471789667e-01   +7.263752984477388e-01   +6.607134810744101e-01   +2.506366265375526e-01   +7.244656564366032e-01   +6.367903127907079e-01   +5.225852649498970e-01   +9.058668708357049e-01   +5.974390444859548e-01; +5.471418255031327e-01   +4.834120973584199e-01   +5.937159473493645e-01   +5.567333464076576e-01   +6.724103287696239e-01   +2.310210135014538e-01   +3.339162277189556e-01   +1.595366489768116e-01   +5.306737819929649e-01   +9.440365170856734e-01   +6.486258573771454e-01   +2.467497642750137e-01; +1.425245370110269e-01   +7.539123353951837e-01   +8.942435251799215e-01   +1.531847723242755e-01   +7.791329339059785e-01   +4.286246305383380e-01   +3.892086314576018e-01   +9.113415363310222e-01   +4.344508970945973e-01   +8.030634961165839e-01   +7.486175780860997e-01   +4.651295980618952e-01; +9.557059897559697e-01   +7.214062872033616e-01   +2.121280520164984e-01   +5.338702189349145e-01   +1.249039951298813e-02   +4.104373703282386e-01   +1.643832816191102e-01   +4.261195643196622e-01   +9.166666596212414e-01   -6.850924380269297e-03   +8.133508077805356e-01   +9.329056533044208e-01; +4.774983188139089e-01   +4.263897030682466e-01   +4.684602246081179e-01   +9.299415063675884e-01   +4.629562555711184e-01   +5.320088101330236e-01   +1.986168368085323e-03   +6.395835300649273e-01   +8.405509993956279e-01   +8.582878458904213e-01   +2.289222292384575e-01   +5.848005809403160e-01];

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
  Input1_v_k1 = 30*sin(3*t) * (((t>50)));
  Input1_iNa_m_k1 = (((2.5-.1*(Input1_v_last+65))./(exp(2.5-.1*(Input1_v_last+65))-1))).*(1-Input1_iNa_m_last)-((4*exp(-(Input1_v_last+65)/18))).*Input1_iNa_m_last;
  Input1_iNa_h_k1 = ((.07*exp(-(Input1_v_last+65)/20))).*(1-Input1_iNa_h_last)-((1./(exp(3-.1*(Input1_v_last+65))+1))).*Input1_iNa_h_last;
  Input1_iK_n_k1 = (((.1-.01*(Input1_v_last+65))./(exp(1-.1*(Input1_v_last+65))-1))).*(1-Input1_iK_n_last)-((.125*exp(-(Input1_v_last+65)/80))).*Input1_iK_n_last;
  Input2_v_k1 = 30*sin(3*t) * (((t<50)));
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
