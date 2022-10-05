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

using FieldConstants, FieldAlgebra
import FieldAlgebra: coef, coefprod, factorize, showgroup, product, makeint, measure
import FieldAlgebra: AbstractModule, AbelianGroup, Group, LogGroup, ExpGroup
import FieldAlgebra: value, isonezero, islog, base, Variables
import Base: @pure, angle
import UnitSystems
import UnitSystems: UnitSystem, Systems, Constants, Physics, Convert, Dimensionless
import UnitSystems: Coupling, measure, unit, universe, cache, Derived, logdb, expdb, dB
export UnitSystems, Measure, measure, cache, Constant
const dir = dirname(pathof(UnitSystems))

macro group(args...)
    FieldAlgebra.group(args...)
end

# measure

using Measurements
struct Measure{N} <: Real end
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
Base.one(::Measure) = 𝟏
Base.zero(::Measure) = 𝟏-𝟏
FieldConstants.Constant(N::Measurement) = Constant{cache(N)}()
Base.inv(M::Measure) = cache(inv(measure(M)))
Base.sqrt(M::Measure) = cache(inv(measure(M)))

Base.:*(a::Number,b::Measure) = cache(a*measure(b))
Base.:*(a::Measure,b::Number) = cache(measure(a)*b)
Base.:/(a::Number,b::Measure) = cache(a/measure(b))
Base.:/(a::Measure,b::Number) = cache(measure(a)/b)
Base.:+(a::Number,b::Measure) = cache(a+measure(b))
Base.:+(a::Measure,b::Number) = cache(measure(a)-b)
Base.:+(a::Measurement,b::Measure) = cache(a+measure(b))
Base.:+(a::Measure,b::Measurement) = cache(measure(a)-b)
Base.:-(a::Number,b::Measure) = cache(a-measure(b))
Base.:-(a::Measure,b::Number) = cache(measure(a)-b)

# unit systems

const usingSimilitude = true #UnitSystems.similitude()

if !usingSimilitude
import UnitSystems: two, three, five, eleven, nineteen, fourtythree
import UnitSystems: golden, eulergamma, tau
@pure mass(U::UnitSystem,S::UnitSystem) = electronmass(U,S)
@pure electronmass(𝘩,R∞) = αinv^2*R∞*2𝘩/𝘤
@pure electronmass(𝘩,R∞,C::Coupling) = inv(finestructure(C))^2*R∞*2𝘩/𝘤
@pure planckmass(U::UnitSystem,C::Coupling=universe(U)) = electronmass(U,C)/√coupling(C)
@pure planck(U::UnitSystem,C::Coupling=universe(U)) = 2π*planckreduced(U,C)
@pure gravitation(U::UnitSystem,C::Coupling=universe(U)) = lightspeed(U,C)*planckreduced(U,C)/planckmass(U,C)^2
@pure elementarycharge(U::UnitSystem,C::Coupling=universe(U)) = sqrt(2planck(U)/(vacuumpermeability(U)/finestructure(U))/(lightspeed(U)*rationalization(U)*lorentz(U)^2))

for unit ∈ Dimensionless
    @eval @pure $unit(C::Coupling) = UnitSystems.$unit(C)
    @eval @pure $unit(U::UnitSystem) = UnitSystems.$unit(universe(U))
end
for unit ∈ (:boltzmann,:planckreduced,:lightspeed,:vacuumpermeability,:electronmass,:molarmass)
    @eval @pure $unit(U::UnitSystem,C::Coupling) = $unit(U)
end
for unit ∈ (Constants...,:vacuumpermeability)
    unit≠:planck && @eval @pure $unit(U::UnitSystem) = UnitSystems.$unit(U)
    unit≠:angle && (@eval @pure $unit(U::UnitSystem,S::UnitSystem) = unit($unit(S)/$unit(U)))
end
for unit ∈ Convert
    @eval begin
        @pure @inline $unit(v::Real,U::UnitSystem) = $unit(v,Natural,U)
        @pure @inline $unit(v::Real,U::UnitSystem,S::UnitSystem) = (u=$unit(U,S);isone(u) ? v : v/u)
        @pure @inline $unit(v::Real,U::UnitSystem{kB,ħ,𝘤,μ₀,mₑ,Mᵤ,extra},S::UnitSystem{kB,ħ,𝘤,μ₀,mₑ,Mᵤ,extra}) where {kB,ħ,𝘤,μ₀,mₑ,Mᵤ,extra} = v
    end
    unit≠:angle && (@eval @pure @inline $unit(U::UnitSystem{kB,ħ,𝘤,μ₀,mₑ,Mᵤ,extra},S::UnitSystem{kB,ħ,𝘤,μ₀,mₑ,Mᵤ,extra}) where {kB,ħ,𝘤,μ₀,mₑ,Mᵤ,extra} = 𝟏)
    if unit ∉ (Constants...,:permittivity,:angle)
        @eval @pure @inline $unit(U::UnitSystem) = $unit(Natural,U)
    end
end
@pure turn(U::UnitSystem) = tau(U)/angle(U)
@pure solidangle(U::UnitSystem,S::UnitSystem) = unit(angle(U,S)^2)
@pure spat(U::UnitSystem) = two(U)*turn(U)/angle(U)*unit(turn(U)/normal(turn(U)))
end
for unit ∈ (Systems...,Dimensionless...,Constants...,Physics...,Convert...,Derived...)
    unit ∉ (:length,:time) && @eval export $unit
end

# fundamental constants, αinv = (34259-1/4366.8123)/250 # 137.036 exactly?

if usingSimilitude
export Similitude, 𝟙, Unified
import Similitude
import Similitude: Unified, coefprod, promoteint, USQ
import Similitude: Group,AbelianGroup,LogGroup,ExpGroup,Quantity,Dimension,Quantities,𝟙,usq
import Similitude: Values,value,vals,basis,valueat,showgroup,ratio,isq,dims,dimtext
import FieldAlgebra: makeint, product
for D ∈ (:F,:M,:L,:T,:Q,:Θ,:N,:J,:A,:R,:C)
    @eval const $D = Similitude.$D
end
FieldAlgebra.makeint(x::MeasureSystems.Measurements.Measurement) = x
FieldAlgebra.promoteint(x::Measure) = x
@group Measures begin
    kB = UnitSystems.kB
    NA = UnitSystems.NA
    𝘩 = UnitSystems.𝘩
    𝘤 = UnitSystems.𝘤
    𝘦 = UnitSystems.𝘦
    Kcd = UnitSystems.Kcd
    ΔνCs = UnitSystems.ΔνCs
    R∞ ≈ measurement("10973731.5681601(210)")
    α ≈ inv(measurement("137.035999084(21)"))
    μₑᵤ ≈ inv(measurement("1822.888486209(53)"))
    μₚᵤ ≈ measurement("1.007276466621(53)")
    ΩΛ ≈ measurement("0.6889(56)")
    H0 ≈ measurement("67.66(42)")
    g₀ = UnitSystems.g₀
    aⱼ = UnitSystems.aⱼ
    au ≈ measurement("149597870700(3)")
    ft = UnitSystems.ft
    ftUS = UnitSystems.ftUS
    lb = UnitSystems.lb
    T₀ = UnitSystems.T₀
    atm = UnitSystems.atm
    inHg = UnitSystems.inHg
    RK90 = UnitSystems.RK1990
    KJ90 = UnitSystems.KJ1990
    RK ≈ measurement("25812.8074555(59)")
    KJ ≈ measurement("483597.8525(30)")*1e9
    Rᵤ2014 ≈ measurement("8.3144598(48)")
    Ωᵢₜ = UnitSystems.Ωᵢₜ
    Vᵢₜ = UnitSystems.Vᵢₜ
    kG = UnitSystems.kG
    mP ≈ measurement("0.00000002176434(24)")
    GME ≈ measurement("3.986004418(8)")*1e14
    GMJ ≈ measurement("1.26686534(9)")*1e17
    φ = Base.MathConstants.φ
    γ = Base.MathConstants.γ
    ℯ = Base.MathConstants.ℯ
    τ ≡ 2π
    2 = 2
    3 = 3
    5 = 5
    7 = 7
    11 = 11
    19 = 19
    43 = 43
end
Base.show(io::IO,x::Group{:Measures}) = showgroup(io,x,basis,'𝟏')
phys(j,k=vals) = Constant(valueat(j,k,:Measures))
const sim = dirname(pathof(Similitude))
include("$sim/constant.jl")
Base.:*(a::Measure,b::Group{G,T,S,N}) where {G,T,S,N} = FieldAlgebra.times(factorize(a,Val(G)),b)
Base.:*(a::Group{G,T,S,N},b::Measure) where {G,T,S,N} = FieldAlgebra.times(a,factorize(b,Val(G)))
Base.:/(a::Measure,b::Group{G,T,S,N}) where {G,T,S,N} = a*inv(b)
Base.:/(a::Group{G,T,S,N},b::Measure) where {G,T,S,N} = a*inv(b)
Base.:+(a::Measure,b::Group{:Measures,T,S,N}) where {T,S,N} = a+FieldAlgebra.product(b)
Base.:+(a::Group{:Measures,T,S,N},b::Measure) where {T,S,N} = FieldAlgebra.product(a)+b
Base.:*(a::Group{:Measures},b::Group{:USQ}) = Group(b.v,a*b.c,Val(:USQ))
Base.:*(a::Group{:USQ},b::Group{:Measures}) = Group(a.v,a.c*b,Val(:USQ))
Base.:/(a::Group{:Measures},b::Group{:USQ}) = a*inv(b)
Base.:/(a::Group{:USQ},b::Group{:Measures}) = a*inv(b)
Base.:+(a::Group{:Measures,T,S,N} where {T,S},b::Group{:Measures,T,S,N} where {T,S}) where N = product(a)+product(b)
Base.:+(a::Number,b::Group{:Measures,T,S,N} where {T,S}) where N = a+product(b)
Base.:+(a::Group{:Measures,T,S,N} where {T,S},b::Number) where N = product(a)+b
Base.:+(a::Constant,b::Group{:Measures,T,S,N} where {T,S}) where N = a+product(b)
Base.:+(a::Group{:Measures,T,S,N} where {T,S},b::Constant) where N = product(a)+b
Base.:-(a::Group{:Measures,T,S,N} where {T,S},b::Group{:Measures,T,S,N} where {T,S}) where N = product(a)-product(b)
Base.:-(a::Number,b::Group{:Measures,T,S,N} where {T,S}) where N = a-product(b)
Base.:-(a::Group{:Measures,T,S,N} where {T,S},b::Number) where N = product(a)-b
Base.:-(a::Constant,b::Group{:Measures,T,S,N} where {T,S}) where N = a-product(b)
Base.:-(a::Group{:Measures,T,S,N} where {T,S},b::Constant) where N = product(a)-b
Base.:*(a::Group{:Constants,T,S,N} where {T,S},b::Group{:Measures,T,S,N} where {T,S}) where N = Group(a.v+b.v,coefprod(coef(a),coef(b)),Val(:Measures))
Base.:*(a::Group{:Measures,T,S,N} where {T,S},b::Group{:Constants,T,S,N} where {T,S}) where N = Group(a.v+b.v,coefprod(coef(a),coef(b)),Val(:Measures))
Base.:/(a::Group{:Constants,T,S,N} where {T,S},b::Group{:Measures,T,S,N} where {T,S}) where N = Group(a.v-b.v,coefprod(coef(a),coef(b)),Val(:Measures))
Base.:/(a::Group{:Measures,T,S,N} where {T,S},b::Group{:Constants,T,S,N} where {T,S}) where N = Group(a.v-b.v,coefprod(coef(a),coef(b)),Val(:Measures))
#Base.:+(a::Group{:Constants,T,S,N} where {T,S},b::Group{:Measures,T,S,N} where {T,S}) where {N,G} = Group(a.v+b.v,coefprod(coef(a),coef(b)),Val(G))
#Base.:+(a::Group{:Measures,T,S,N} where {T,S},b::Group{:Constants,T,S,N} where {T,S}) where N = Group(a.v+b.v,coefprod(coef(a),coef(b)),Val(:Measures))
#Base.:-(a::Group{:Constants,T,S,N} where {T,S},b::Group{:Measures,T,S,N} where {T,S}) where {N,G} = Group(a.v+b.v,coefprod(coef(a),coef(b)),Val(G))
#Base.:-(a::Group{:Measures,T,S,N} where {T,S},b::Group{:Constants,T,S,N} where {T,S}) where N = Group(a.v+b.v,coefprod(coef(a),coef(b)),Val(:Measures))
Base.:*(a::Measurements.Measurement,b::Constant{D}) where D = a*D
Base.:*(a::Constant{D},b::Measurements.Measurement) where D = D*b
Base.:/(a::Measurements.Measurement,b::Constant{D}) where D = a*inv(b)
Base.:/(a::Constant{D},b::Measurements.Measurement) where D = a*inv(b)
Base.:+(a::Measurements.Measurement,b::Constant{D}) where D = a+D
Base.:+(a::Constant{D},b::Measurements.Measurement) where D = D+b
Base.:-(a::Measurements.Measurement,b::Constant{D}) where D = a-D
Base.:-(a::Constant{D},b::Measurements.Measurement) where D = D-b
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
const αinv = measurement("137.035999084(21)")
const μₑᵤ = inv(measurement("1822.888486209(53)"))
const μₚᵤ = measurement("1.007276466621(53)")
const R∞ = measurement("10973731.5681601(210)")
const KJ2014 = measurement("483597.8525(30)")*1e9
const RK2014 = measurement("25812.8074555(59)")
const Rᵤ2014 = measurement("8.3144598(48)")
#const au = measurement("149597870700(3)")
#const GM☉ = measurement("1.32712442099(9)")*1e20#new?
#const GM☉ = measurement("1.32712440018(9)")*1e20
const GME = measurement("3.986004418(8)")*1e14
const GMJ = measurement("1.26686534(9)")*1e17
const H0 = measurement("67.66(42)")
const ΩΛ = measurement("0.6889(56)")
const α = inv(αinv)
const RK,KJ = RK2014,KJ2014
import UnitSystems: g₀,ft,ftUS,lb,atm,ΔνCs,Kcd,NA,kB,𝘩,𝘤,𝘦,τ,inHg,T₀,aⱼ,Ωᵢₜ,Vᵢₜ,kG,au,seven
import UnitSystems: RK1990,KJ1990,𝟏,𝟐,𝟑,𝟓,𝟕,𝟏𝟏,𝟏𝟗,𝟒𝟑,isquantity
const RK90,KJ90 = RK1990,KJ1990
end

const LD,JD = Constant(384399)*(𝟐*𝟓)^3,Constant(778479)*(𝟐*𝟓)^6
const μE☾ = Constant(measurement("81.300568(3)"))

import UnitSystems: GaussSystem, ElectricSystem, EntropySystem, AstronomicalSystem, unitname, normal
include("$dir/initdata.jl")

#const μ₀ = 2𝘩/𝘤/αinv/𝘦^2 # ≈ 4π*(1e-7+5.5e-17), exact charge
const δμ₀ = μ₀-4π*1e-7
export au,day,SI,Quantity,Quantities

if usingSimilitude
for unit ∈ UnitSystems.Convert
    if unit ∉ (:length,:time,:angle,:molarmass,:luminousefficacy)
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
for CAL ∈ (:calₜₕ,:cal₄,:cal₁₀,:cal₂₀,:calₘ,:calᵢₜ)
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

@pure electronmass(U::typeof(Planck),C::Coupling) = sqrt(4π*coupling(C))
@pure electronmass(U::typeof(PlanckGauss),C::Coupling) = sqrt(coupling(C))
@pure electronmass(U::UnitSystem{kB,ħ,𝘤,μ₀,cache(√(αG*αinv))},C::Coupling) where {kB,ħ,𝘤,μ₀} = sqrt(coupling(C)/finestructure(C))
@pure electronmass(U::UnitSystem{kB,ħ,𝘤,μ₀,cache(1/μₚₑ)},C::Coupling) where {kB,ħ,𝘤,μ₀} = 1/protonelectron(C)
@pure vacuumpermeability(U::UnitSystem{kB,ħ,𝘤,cache(4π/αinv^2)},C::Coupling) where {kB,ħ,𝘤} = 4π*finestructure(C)^2
@pure vacuumpermeability(U::UnitSystem{kB,ħ,𝘤,cache(π/αinv^2)},C::Coupling) where {kB,ħ,𝘤} = π*finestructure(C)^2
@pure lightspeed(U::UnitSystem{kB,ħ,cache(αinv)},C::Coupling) where {kB,ħ} = 1/finestructure(C)
@pure lightspeed(U::UnitSystem{kB,ħ,cache(2αinv)},C::Coupling) where {kB,ħ} = 2/finestructure(C)
@pure planckreduced(U::UnitSystem{kB,cache(αinv)},C::Coupling) where kB = 1/finestructure(C)

@pure electronmass(U::UnitSystem{kB,ħ,𝘤,μ₀,cache(mₑ)},C::Coupling) where {kB,ħ,μ₀} = electronmass(planck(U),R∞,C)
@pure electronmass(U::UnitSystem{kB,ħ,100𝘤,μ₀,cache(1000mₑ)},C::Coupling) where {kB,ħ,μ₀} = 1000electronmass(SI,C)
@pure electronmass(U::UnitSystem{kB,ħ,𝘤,μ₀,cache(mₑ/1000)},C::Coupling) where {kB,ħ,μ₀} = electronmass(SI,C)/1000
@pure electronmass(U::UnitSystem{kB,ħ,𝘤,μ₀,cache(electronmass(CODATA))},C::Coupling) where {kB,ħ,μ₀} = electronmass(planck(U),R∞,C)
@pure electronmass(U::UnitSystem{kB,ħ,𝘤,μ₀,cache(electronmass(Conventional))},C::Coupling) where {kB,ħ,μ₀} = electronmass(planck(U),R∞,C)
@pure electronmass(U::UnitSystem{kB,ħ,𝘤/ftUS,μ₀,cache(mₑ*ft/lb/g₀)},C::Coupling) where {kB,ħ,μ₀} = electronmass(SI,C)*ft/lb/g₀
@pure vacuumpermeability(U::UnitSystem{kB,ħ,𝘤,cache(μ₀)},C::Coupling) where {kB,ħ,𝘤} = finestructure(C)*2𝘩/𝘤/𝘦^2
@pure vacuumpermeability(U::typeof(CODATA),C::Coupling) = 2RK2014*finestructure(C)/𝘤
@pure vacuumpermeability(U::typeof(Conventional),C::Coupling) = 2RK1990*finestructure(C)/𝘤

end # module
