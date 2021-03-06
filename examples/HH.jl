using SpikingNetworks
@codegen
parseParameters"""
C=1
gₖ=36
gₙ=120
gₗ=0.3
Eₖ= -12
Eₙ=115
Eₗ= 10.613
Iₑ=10"""

parseEquations"""
dV/dt=1/C*(-gₖ*n^4*(V-Eₖ)-gₙ*m^3*h*(V-Eₙ) -gₗ*(V-Eₗ)+Iₑ)
dn/dt=αₙ(V)-(αₙ(V)+βₙ(V))*n
dm/dt=αₘ(V)-(αₘ(V)+βₘ(V))*m
dh/dt=αₕ(V)-(αₕ(V)+βₕ(V))*h
αₙ(V)=(0.01*(-V+10))./(exp((-V+10)/10)-1)
βₙ(V)=0.125*exp(-V/80)
αₘ(V)=0.1*(-V+25)./(exp((-V+25)/10)-1)
βₘ(V)=4*exp(-V/18)
αₕ(V)=0.07*exp(-V/20)
βₕ(V)=1./(exp((-V+30)/10)+1)"""

net=init"""
V=-10*ones(N)
n=0.0003*ones(N)
m=0.0011*ones(N)
h=0.9998*ones(N)"""

stateMonitor"[1]"
net.dt=0.15
@time run!(net,100/net.dt)
using MatlabPlot
mplot(net.VRecord[1,:]')
