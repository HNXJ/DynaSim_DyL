# DynaSim Trainable Dynamical Neural Network Model Extention

An integrated class for trainable interactive biophysical neural models of DynaSim

You can use your model's Dynasim struct for it and define RL parameters in the train step method (run_trial(~);) of DynaNet.

## Short doc:

### s = [Your DynaSim Neural Model Struct];
  
### m = DynaModel(s);
  
### m.run_trial(c_input, input_layers, output_indice, T, dT, c_target, lambda, update_mode, error_mode);

*c_input is the current input, the initial model has two inputs so it consists of two equations.
  
*input_layers is the index list of populations in the model that are inputs of the model
  
*output_indice is the variable that is defined to be output; for example I've defined the number of spikes of layer L1 as the final output of the system.
T, dT are time length and time step of the model for solver block
  
*c_target is the target that the model should learn to generate, here it is the number of spikes that L1 should generate for the corresponding output.
  
*lambda is the Rascorla-Wagner's delta rule constant for reinforcement learning steps (here it is about 0.001)
  
*update_mode is the training step change method, current options are uniform random, normal random and constant changes to the connectivity matrix weights
  
*error_mode is the error calculation method, MAE, MSE, difference, distance are the options


