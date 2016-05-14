#!/usr/bin/env julia
#Automates Matplotlib installation for travis.ci
#=
ENV["PYTHON"]=""
Pkg.build("PyCall")
using PyPlot
=#
#Start Test Script
using DifferentialEquations
using Base.Test

testState = true
# Run tests

println("Finite Element Heat Dt Tests")
@time @test include("femHeatDtTests.jl")
println("Finite Element Heat Dx Tests")
@time @test include("femHeatDXtests.jl")
println("Finite Element Heat Method Tests")
@time @test include("femHeatMethodTest.jl")
println("Finite Element Nonlinear Heat Methods Tests")
@time @test include("femHeatNonlinearMethodsTest.jl")
println("Finite Element Poisson Convergence Test")
@time @test include("femPoissonConvTest.jl")
println("Finite Element Nonlinear Poisson Tests")
@time @test include("femPoissonNonlinearTest.jl")
println("Finite Element Stochastic Poisson")
@time @test include("femStochasticPoissonSolo.jl")
println("Finite Element Poisson")
@time @test include("introductionExample.jl")
println("Heat Animation Test")
@time @test include("femHeatAnimationTest.jl")
println("Stochastic Heat Animation Test")
@time @test include("femStochasticHeatAnimationTest.jl")
