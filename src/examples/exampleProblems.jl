@doc "Example problem with solution: u(x,y,t)=0.1*(1-exp(-100*(t-0.5).^2)).*exp(-25((x-t+0.5).^2 + (y-t+0.5).^2))" ->
function heatProblemExample_moving()
  sol(x,t) = 0.1*(1-exp(-100*(t-0.5).^2)).*exp(-25((x[:,1]-t+0.5).^2 + (x[:,2]-t+0.5).^2))
  Du(x,t) = -50[sol(x,t).*(0.5-t+x[:,1]) sol(x,t).*(0.5-t+x[:,2])]
  f(x,t) = (-5).*exp((-25).*((3/2)+6.*t.^2+x[:,1]+x[:,1].^2+x[:,2]+x[:,2].^2+(-2).*t.*(3+x[:,1]+
    x[:,2]))).*((-20)+(-100).*t.^2+(-49).*x[:,1]+(-50).*x[:,1].^2+(-49).*x[:,2]+(-50).*
    x[:,2].^2+2.*t.*(47+50.*x[:,1]+50.*x[:,2])+exp(25.*(1+(-2).*t).^2).*(22+
    100.*t.^2+49.*x[:,1]+50.*x[:,1].^2+49.*x[:,2]+50.*x[:,2].^2+(-2).*t.*(49+50.*x[:,1]+50.*x[:,2])))
  return(HeatProblem(sol,Du,f))
end

"Example problem with solution: u(x,y,t)=exp(-10((x-.5).^2 + (y-.5).^2 )-t)"
function heatProblemExample_diffuse()
  sol(x,t) = exp(-10((x[:,1]-.5).^2 + (x[:,2]-.5).^2 )-t)
  f(x,t)   = exp(-t-5*(1-2x[:,1]+2x[:,1].^2 - 2x[:,2] +2x[:,2].^2)).*(-161 + 400*(x[:,1] - x[:,1].^2 + x[:,2] - x[:,2].^2))
  Du(x,t) = -20[sol(x,t).*(x[:,1]-.5) sol(x,t).*(x[:,2]-.5)]
  return(HeatProblem(sol,Du,f))
end

"Example problem which starts with 1 at (0.5,0.5) and solves with f=gD=0"
function heatProblemExample_pure()
  f(x,t)  = zeros(size(x,1))
  u0(x) = float((abs(x[:,1]-.5) .< 1e-6) & (abs(x[:,2]-.5) .< 1e-6)) #Only mass at middle of (0,1)^2
  return(HeatProblem(u0,f))
end

"Example problem which starts with 0 and solves with f(u)=1-.1u"
function heatProblemExample_birthdeath()
  f(u,x,t)  = ones(size(x,1)) - .5u
  u0(x) = zeros(size(x,1))
  return(HeatProblem(u0,f))
end

"Example problem which starts with 0 and solves with f(u)=1-.1u"
function heatProblemExample_stochasticbirthdeath()
  f(u,x,t)  = ones(size(x,1)) - .5u
  u0(x) = zeros(size(x,1))
  σ(u,x,t) = 100u.^2
  return(HeatProblem(u0,f,σ=σ))
end

"Example problem with solution: u(x,y,t)= sin(2π.*x).*cos(2π.*y)/(8π*π)"
function poissonProblemExample_wave()
  f(x) = sin(2π.*x[:,1]).*cos(2π.*x[:,2])
  sol(x) = sin(2π.*x[:,1]).*cos(2π.*x[:,2])/(8π*π)
  Du(x) = [cos(2*pi.*x[:,1]).*cos(2*pi.*x[:,2])./(4*pi) -sin(2π.*x[:,1]).*sin(2π.*x[:,2])./(4π)]
  return(PoissonProblem(f,sol,Du))
end

"Example problem with deterministic solution: u(x,y,t)= sin(2π.*x).*cos(2π.*y)/(8π*π)"
function poissonProblemExample_noisyWave()
  f(x) = sin(2π.*x[:,1]).*cos(2π.*x[:,2])
  sol(x) = sin(2π.*x[:,1]).*cos(2π.*x[:,2])/(8π*π)
  Du(x) = [cos(2*pi.*x[:,1]).*cos(2*pi.*x[:,2])./(4*pi) -sin(2π.*x[:,1]).*sin(2π.*x[:,2])./(4π)]
  σ(x) = 5 #Additive noise
  return(PoissonProblem(f,sol,Du,σ=σ))
end

"Example problem for nonlinear Poisson equation"
function poissonProblemExample_birthdeath()
  f(u,x)  = ones(size(x,1)) - .5u
  return(PoissonProblem(f))
end
