//deff('y=f2(x)','y = sum(x.^2)');
function y = f2(x)
  y=sum(x.^2)
endfunction  
//
function y= f36(x)
  pi=3.14
  y=-1.*21.5+x(1)*sin(4.0*pi*x(1))+x(2)*sin(20.0*pi*x(2))
endfunction  

function y= fdj1(xs);
  l=length(xs); s=0.;
  for i=1:l
    s=s+xs(i)*xs(i)
  end
  y= s
endfunction // End of function

PopSize     = 800;
Proba_cross = 0.7;
Proba_mut   = 0.1;
NbGen       = 100;
NbCouples   = 110;
Log         = %T;
nb_disp     = 10; // Nb point to display from the optimal population
pressure    = 0.05;

ga_params = init_param();
// Parameters to adapt to the shape of the optimization problem
//ga_params = add_param(ga_params,'minbound',[-5.12; -5.12]);
//ga_params = add_param(ga_params,'maxbound',[5.12; 5.12]);
ga_params = add_param(ga_params,'dimension',800);
ga_params = add_param(ga_params,'beta',0);
ga_params = add_param(ga_params,'delta',0.1);
// Parameters to fine tune the Genetic algorithm. All these parameters are optional for continuous optimization
// If you need to adapt the GA to a special problem, you 
ga_params = add_param(ga_params,'init_func',init_ga_default);
ga_params = add_param(ga_params,'crossover_func',crossover_ga_default);
ga_params = add_param(ga_params,'mutation_func',mutation_ga_default);
//ga_params = add_param(ga_params,'codage_func',codage_ga_identity);
ga_params = add_param(ga_params,'selection_func',selection_ga_elitist);
//ga_params = add_param(ga_params,'selection_func',selection_ga_random);
ga_params = add_param(ga_params,'nb_couples',NbCouples);
ga_params = add_param(ga_params,'pressure',pressure);

Min = get_param(ga_params,'minbound');
Max = get_param(ga_params,'maxbound');
x0  = (Max - Min) .* rand(size(Min,1),size(Min,2)) + Min;

[pop_opt, fobj_pop_opt, pop_init, fobj_pop_init] = optim_ga(fdj1, PopSize, NbGen, Proba_mut, Proba_cross, Log, ga_params);
 
