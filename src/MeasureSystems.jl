module MeasureSystems

#   This file is part of MeasureSystems.jl
#   It is licensed under the MIT license
#   MeasureSystems Copyright (C) 2021 Michael Reed
#       _           _                         _
#      | |         | |                       | |
#   ___| |__   __ _| | ___ __ __ ___   ____ _| | __ _
#  / __| '_ \ / _` | |/ / '__/ _` \ \ / / _` | |/ _` |
# | (__| | | | (_| |   <| | | (_| |\ V / (_| | | (_| |
#  \___|_| |_|\__,_|_|\_\_|  \__,_| \_/ \__,_|_|\__,_|
#
#   https://github.com/chakravala
#   https://crucialflow.com

import Base: @pure, angle
import UnitSystems
import UnitSystems: UnitSystem, Systems, Constants, Physics, Convert, Dimensionless
import UnitSystems: Coupling, measure, unit, universe, cache, Derived, logdb, expdb, dB
export UnitSystems, Measure, measure, cache
const dir = dirname(pathof(UnitSystems))

# measure

using Measurements
struct Measure{N} end
const measure_cache = Measurement{Float64}[]
@pure measure(::Measure{N}) where N = measure_cache[N]
function cache(M::Measurement{Float64})
    N = findfirst(x->x==M,measure_cache)
    if isnothing(N)
        push!(measure_cache,M)
        N = Base.length(measure_cache)
    end
    return Measure{N}()
end
Base.show(io::IO,M::Measure{N}) where N = show(io,measure(M))
Base.one(::Measure) = π
Base.zero(::Measure) = π-π

# unit systems

const usingSimilitude = true #UnitSystems.similitude()

if !usingSimilitude
import UnitSystems: two, three, five, eleven, nineteen, fourtythree
import UnitSystems: golden, eulergamma, tau
@pure mass(U::UnitSystem,S::UnitSystem) = electronmass(U,S)
@pure electronmass(π©,Rβ) = Ξ±inv^2*Rβ*2π©/π€
@pure electronmass(π©,Rβ,C::Coupling) = inv(finestructure(C))^2*Rβ*2π©/π€
@pure planckmass(U::UnitSystem,C::Coupling=universe(U)) = electronmass(U,C)/βcoupling(C)
@pure planck(U::UnitSystem,C::Coupling=universe(U)) = 2Ο*planckreduced(U,C)
@pure gravitation(U::UnitSystem,C::Coupling=universe(U)) = lightspeed(U,C)*planckreduced(U,C)/planckmass(U,C)^2
@pure elementarycharge(U::UnitSystem,C::Coupling=universe(U)) = sqrt(2planck(U)/(vacuumpermeability(U)/finestructure(U))/(lightspeed(U)*rationalization(U)*lorentz(U)^2))

for unit β Dimensionless
    @eval @pure $unit(C::Coupling) = UnitSystems.$unit(C)
    @eval @pure $unit(U::UnitSystem) = UnitSystems.$unit(universe(U))
end
for unit β (:boltzmann,:planckreduced,:lightspeed,:vacuumpermeability,:electronmass,:molarmass)
    @eval @pure $unit(U::UnitSystem,C::Coupling) = $unit(U)
end
for unit β (Constants...,:vacuumpermeability)
    unitβ :planck && @eval @pure $unit(U::UnitSystem) = UnitSystems.$unit(U)
    unitβ :angle && (@eval @pure $unit(U::UnitSystem,S::UnitSystem) = unit($unit(S)/$unit(U)))
end
for unit β Convert
    @eval begin
        @pure @inline $unit(v::Real,U::UnitSystem) = $unit(v,Natural,U)
        @pure @inline $unit(v::Real,U::UnitSystem,S::UnitSystem) = (u=$unit(U,S);isone(u) ? v : v/u)
        @pure @inline $unit(v::Real,U::UnitSystem{kB,Δ§,π€,ΞΌβ,mβ,Mα΅€,extra},S::UnitSystem{kB,Δ§,π€,ΞΌβ,mβ,Mα΅€,extra}) where {kB,Δ§,π€,ΞΌβ,mβ,Mα΅€,extra} = v
    end
    unitβ :angle && (@eval @pure @inline $unit(U::UnitSystem{kB,Δ§,π€,ΞΌβ,mβ,Mα΅€,extra},S::UnitSystem{kB,Δ§,π€,ΞΌβ,mβ,Mα΅€,extra}) where {kB,Δ§,π€,ΞΌβ,mβ,Mα΅€,extra} = π)
    if unit β (Constants...,:permittivity,:angle)
        @eval @pure @inline $unit(U::UnitSystem) = $unit(Natural,U)
    end
end
@pure turn(U::UnitSystem) = tau(U)/angle(U)
@pure solidangle(U::UnitSystem,S::UnitSystem) = unit(angle(U,S)^2)
@pure spat(U::UnitSystem) = two(U)*turn(U)/angle(U)*unit(turn(U)/normal(turn(U)))
end
for unit β (Systems...,Dimensionless...,Constants...,Physics...,Convert...,Derived...)
    unit β (:length,:time) && @eval export $unit
end

# fundamental constants, Ξ±inv = (34259-1/4366.8123)/250 # 137.036 exactly?

if usingSimilitude
export Similitude, π, Unified
import Similitude
import Similitude: Unified, coefprod, promoteint
import Similitude: Group,AbelianGroup,LogGroup,ExpGroup,Quantity,Dimension,Quantities,π,usq
import Similitude: Values,value,vals,basis,valueat,makeint,showgroup,ratio,isq,dims,dimtext
for D β (:F,:M,:L,:T,:Q,:Ξ,:N,:J,:A,:R,:C)
    @eval const $D = Similitude.$D
end
Similitude.makeint(x::MeasureSystems.Measurements.Measurement) = x
@pure function constant(d::Group,C::Coupling=UnitSystems.Universe,dc=d.c); cs =
    UnitSystems.kB^makeint(d.v[1])*
    UnitSystems.NA^makeint(d.v[2])*
    UnitSystems.π©^makeint(d.v[3])*
    UnitSystems.π€^makeint(d.v[4])*
    UnitSystems.π¦^makeint(d.v[5])*
    UnitSystems.Kcd^makeint(d.v[6])*
    UnitSystems.ΞΞ½Cs^makeint(d.v[7])*
    UnitSystems.gβ^makeint(d.v[14])*
    UnitSystems.aβ±Ό^makeint(d.v[15])*
    UnitSystems.ft^makeint(d.v[17])*
    UnitSystems.ftUS^makeint(d.v[18])*
    UnitSystems.lb^makeint(d.v[19])*
    UnitSystems.Tβ^makeint(d.v[20])*
    UnitSystems.atm^makeint(d.v[21])*
    UnitSystems.inHg^makeint(d.v[22])*
    UnitSystems.RK1990^makeint(d.v[23])*
    UnitSystems.KJ1990^makeint(d.v[24])*
    UnitSystems.Ξ©α΅’β^makeint(d.v[28])*
    UnitSystems.Vα΅’β^makeint(d.v[29])*
    UnitSystems.kG^makeint(d.v[30])*
    Base.MathConstants.Ο^makeint(d.v[34])*
    Base.MathConstants.Ξ³^makeint(d.v[35])*
    Base.MathConstants.β―^makeint(d.v[36])*
    (2Ο)^makeint(d.v[37]); is =
    2.0^makeint(d.v[38])*
    3.0^makeint(d.v[39])*
    5.0^makeint(d.v[40])*
    7.0^makeint(d.v[41])*
    11.0^makeint(d.v[42])*
    19.0^makeint(d.v[43])*
    43.0^makeint(d.v[44]); me = 
    abs(d.v[8])+abs(d.v[9])+abs(d.v[10])+abs(d.v[11])+abs(d.v[12])+abs(d.v[13])+abs(d.v[16])+abs(d.v[25])+abs(d.v[26])+abs(d.v[27])+abs(d.v[31])+abs(d.v[32])+abs(d.v[33])
    if iszero(me); return cs*(is*d.c); else; ms = 
    measurement("10973731.5681601(210)")^makeint(d.v[8])* #Rβ
    inv(measurement("137.035999084(21)"))^makeint(d.v[9])* #Ξ±
    inv(measurement("1822.888486209(53)"))^makeint(d.v[10])* #ΞΌβα΅€
    measurement("1.007276466621(53)")^makeint(d.v[11])* #ΞΌβα΅€
    measurement("0.6889(56)")^makeint(d.v[12])* #Ξ©Ξ
    measurement("67.66(42)")^makeint(d.v[13])* #H0
    measurement("149597870700(3)")^makeint(d.v[16])* #au
    measurement("25812.8074555(59)")^makeint(d.v[25])* #RK
    (measurement("483597.8525(30)")*1e9)^makeint(d.v[26])* #KJ
    measurement("8.3144598(48)")^makeint(d.v[27])* #Rα΅€
    measurement("0.00000002176434(24)")^makeint(d.v[31])* #mP
    (measurement("3.986004418(8)")*1e14)^makeint(d.v[32])* #GME
    (measurement("1.26686534(9)")*1e17)^makeint(d.v[33]) #GMJ
    return (cs*(is*d.c))*ms; end
end
const sim = dirname(pathof(Similitude))
include("$sim/constant.jl")
Base.:*(a::Measurements.Measurement,b::Constant{D}) where D = a*constant(D)
Base.:*(a::Constant{D},b::Measurements.Measurement) where D = constant(D)*b
Base.:/(a::Measurements.Measurement,b::Constant{D}) where D = a*inv(b)
Base.:/(a::Constant{D},b::Measurements.Measurement) where D = a*inv(b)
Base.:+(a::Measurements.Measurement,b::Constant{D}) where D = a+constant(D)
Base.:+(a::Constant{D},b::Measurements.Measurement) where D = constant(D)+b
Base.:-(a::Measurements.Measurement,b::Constant{D}) where D = a-constant(D)
Base.:-(a::Constant{D},b::Measurements.Measurement) where D = constant(D)-b
#=Base.:*(a::Measurements.Measurement,b::Similitude.Constant{D}) where D = a*Constant{D}()
Base.:*(a::Similitude.Constant{D},b::Measurements.Measurement) where D = Constant{D}()*b
Base.:/(a::Measurements.Measurement,b::Similitude.Constant{D}) where D = a*inv(b)
Base.:/(a::Similitude.Constant{D},b::Measurements.Measurement) where D = a*inv(b)=#
Base.:*(a::Similitude.Constant{A},b::Constant{B}) where {A,B} = Constant{A*B}()
Base.:*(a::Constant{A},b::Similitude.Constant{B}) where {A,B} = Constant{A*B}()
Base.:/(a::Similitude.Constant{A},b::Constant{B}) where {A,B} = Constant{A/B}()
Base.:/(a::Constant{A},b::Similitude.Constant{B}) where {A,B} = Constant{A/B}()
else
Constant(x) = x
Quantity(x) = Constant(x)
Base.:*(a::Measurements.Measurement,b::UnitSystems.Constant{D}) where D = a*D
Base.:*(a::UnitSystems.Constant{D},b::Measurements.Measurement) where D = D*b
Base.:/(a::Measurements.Measurement,b::UnitSystems.Constant{D}) where D = a*inv(b)
Base.:/(a::UnitSystems.Constant{D},b::Measurements.Measurement) where D = a*inv(b)
Base.:+(a::Measurements.Measurement,b::UnitSystems.Constant{D}) where D = a+D
Base.:+(a::UnitSystems.Constant{D},b::Measurements.Measurement) where D = D+b
Base.:-(a::Measurements.Measurement,b::UnitSystems.Constant{D}) where D = a-D
Base.:-(a::UnitSystems.Constant{D},b::Measurements.Measurement) where D = D-b
const mP = measurement("0.00000002176434(24)")
const Ξ±inv = measurement("137.035999084(21)")
const ΞΌβα΅€ = inv(measurement("1822.888486209(53)"))
const ΞΌβα΅€ = measurement("1.007276466621(53)")
const Rβ = measurement("10973731.5681601(210)")
const KJ2014 = measurement("483597.8525(30)")*1e9
const RK2014 = measurement("25812.8074555(59)")
const Rα΅€2014 = measurement("8.3144598(48)")
#const au = measurement("149597870700(3)")
#const GMβ = measurement("1.32712442099(9)")*1e20#new?
#const GMβ = measurement("1.32712440018(9)")*1e20
const GME = measurement("3.986004418(8)")*1e14
const GMJ = measurement("1.26686534(9)")*1e17
const H0 = measurement("67.66(42)")
const Ξ©Ξ = measurement("0.6889(56)")
const Ξ± = inv(Ξ±inv)
const RK,KJ = RK2014,KJ2014
import UnitSystems: gβ,ft,ftUS,lb,atm,ΞΞ½Cs,Kcd,NA,kB,π©,π€,π¦,Ο,inHg,Tβ,aβ±Ό,Ξ©α΅’β,Vα΅’β,kG,au,seven
import UnitSystems: RK1990,KJ1990,π,π,π,π,π,ππ,ππ,ππ,isquantity
const RK90,KJ90 = RK1990,KJ1990
end

const LD,JD = Constant(384399)*(π*π)^3,Constant(778479)*(π*π)^6
const ΞΌEβΎ = Constant(measurement("81.300568(3)"))

import UnitSystems: GaussSystem, ElectricSystem, EntropySystem, AstronomicalSystem, unitname, normal
include("$dir/initdata.jl")

#const ΞΌβ = 2π©/π€/Ξ±inv/π¦^2 # β 4Ο*(1e-7+5.5e-17), exact charge
const Ξ΄ΞΌβ = ΞΌβ-4Ο*1e-7
export au,day,SI,Quantity,Quantities

if usingSimilitude
for unit β UnitSystems.Convert
    if unit β (:length,:time,:angle,:molarmass,:luminousefficacy)
        @eval const $unit = Similitude.$unit
    end
end
include("$sim/derived.jl")
include("$dir/kinematicdocs.jl")
include("$dir/electromagneticdocs.jl")
include("$dir/thermodynamicdocs.jl")
include("$dir/physicsdocs.jl")
include("$dir/systems.jl")
else
for CAL β (:calββ,:calβ,:calββ,:calββ,:calβ,:calα΅’β)
    KCAL = Symbol(:k,CAL)
    @eval import UnitSystems: $CAL, $KCAL
end
import UnitSystems: convertext, unitext
const dir = dirname(pathof(UnitSystems))
const zetta,zepto = Constant(1e21),Constant(1e-21)
const yotta,yocto = Constant(1e24),Constant(1e-24)
include("$dir/kinematic.jl")
include("$dir/electromagnetic.jl")
include("$dir/thermodynamic.jl")
include("$dir/physics.jl")
include("$dir/systems.jl")
end

# physical constants

@pure electronmass(U::typeof(Planck),C::Coupling) = sqrt(4Ο*coupling(C))
@pure electronmass(U::typeof(PlanckGauss),C::Coupling) = sqrt(coupling(C))
@pure electronmass(U::UnitSystem{kB,Δ§,π€,ΞΌβ,cache(β(Ξ±G*Ξ±inv))},C::Coupling) where {kB,Δ§,π€,ΞΌβ} = sqrt(coupling(C)/finestructure(C))
@pure electronmass(U::UnitSystem{kB,Δ§,π€,ΞΌβ,cache(1/ΞΌββ)},C::Coupling) where {kB,Δ§,π€,ΞΌβ} = 1/protonelectron(C)
@pure vacuumpermeability(U::UnitSystem{kB,Δ§,π€,cache(4Ο/Ξ±inv^2)},C::Coupling) where {kB,Δ§,π€} = 4Ο*finestructure(C)^2
@pure vacuumpermeability(U::UnitSystem{kB,Δ§,π€,cache(Ο/Ξ±inv^2)},C::Coupling) where {kB,Δ§,π€} = Ο*finestructure(C)^2
@pure lightspeed(U::UnitSystem{kB,Δ§,cache(Ξ±inv)},C::Coupling) where {kB,Δ§} = 1/finestructure(C)
@pure lightspeed(U::UnitSystem{kB,Δ§,cache(2Ξ±inv)},C::Coupling) where {kB,Δ§} = 2/finestructure(C)
@pure planckreduced(U::UnitSystem{kB,cache(Ξ±inv)},C::Coupling) where kB = 1/finestructure(C)

@pure electronmass(U::UnitSystem{kB,Δ§,π€,ΞΌβ,cache(mβ)},C::Coupling) where {kB,Δ§,ΞΌβ} = electronmass(planck(U),Rβ,C)
@pure electronmass(U::UnitSystem{kB,Δ§,100π€,ΞΌβ,cache(1000mβ)},C::Coupling) where {kB,Δ§,ΞΌβ} = 1000electronmass(SI,C)
@pure electronmass(U::UnitSystem{kB,Δ§,π€,ΞΌβ,cache(mβ/1000)},C::Coupling) where {kB,Δ§,ΞΌβ} = electronmass(SI,C)/1000
@pure electronmass(U::UnitSystem{kB,Δ§,π€,ΞΌβ,cache(electronmass(CODATA))},C::Coupling) where {kB,Δ§,ΞΌβ} = electronmass(planck(U),Rβ,C)
@pure electronmass(U::UnitSystem{kB,Δ§,π€,ΞΌβ,cache(electronmass(Conventional))},C::Coupling) where {kB,Δ§,ΞΌβ} = electronmass(planck(U),Rβ,C)
@pure electronmass(U::UnitSystem{kB,Δ§,π€/ftUS,ΞΌβ,cache(mβ*ft/lb/gβ)},C::Coupling) where {kB,Δ§,ΞΌβ} = electronmass(SI,C)*ft/lb/gβ
@pure vacuumpermeability(U::UnitSystem{kB,Δ§,π€,cache(ΞΌβ)},C::Coupling) where {kB,Δ§,π€} = finestructure(C)*2π©/π€/π¦^2
@pure vacuumpermeability(U::typeof(CODATA),C::Coupling) = 2RK2014*finestructure(C)/π€
@pure vacuumpermeability(U::typeof(Conventional),C::Coupling) = 2RK1990*finestructure(C)/π€

end # module
