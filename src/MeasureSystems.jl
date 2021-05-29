module MeasureSystems

#   This file is part of MeasureSystems.jl. It is licensed under the MIT license
#   MeasureSystems Copyright (C) 2021 Michael Reed

import Base: @pure
import UnitSystems
import UnitSystems: UnitSystem, Systems, Constants, Physics, Convert
import UnitSystems: Coupling, measure, unit, universe
export UnitSystems, Measure, measure, cache

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

# unit systems

@pure mass(U::UnitSystem,S::UnitSystem) = electronmass(U,S)
@pure electronmass(𝘩,R∞) = αinv^2*R∞*2𝘩/𝘤
@pure electronmass(𝘩,R∞,C::Coupling) = inv(finestructure(C))^2*R∞*2𝘩/𝘤
@pure planckmass(U::UnitSystem,C::Coupling=universe(U)) = electronmass(U,C)/√coupling(C)
@pure planck(U::UnitSystem,C::Coupling=universe(U)) = 2π*planckreduced(U,C)
@pure newton(U::UnitSystem,C::Coupling=universe(U)) = lightspeed(U,C)*planckreduced(U,C)/planckmass(U,C)^2
@pure charge(U::UnitSystem,C::Coupling=universe(U)) = sqrt(2planck(U,C)*finestructure(C)/impedance(U,C))
@pure impedance(U::UnitSystem,C::Coupling=universe(U)) = permeability(U,C)*lightspeed(U,C)*rationalization(U)*lorentz(U)^2

for unit ∈ (:coupling,:finestructure,:electronunit,:protonunit,:protonelectron)
    @eval @pure $unit(C::Coupling) = UnitSystems.$unit(C)
    @eval @pure $unit(U::UnitSystem) = UnitSystems.$unit(universe(U))
end
for unit ∈ (:boltzmann,:planckreduced,:lightspeed,:permeability,:electronmass,:rationalization,:lorentz,:molarmass)
    @eval @pure $unit(U::UnitSystem) = UnitSystems.$unit(U)
end
for unit ∈ (:boltzmann,:planckreduced,:lightspeed,:permeability,:electronmass,:molarmass)
    @eval @pure $unit(U::UnitSystem,C::Coupling) = $unit(U)
end
for unit ∈ Constants
    @eval @pure $unit(U::UnitSystem,S::UnitSystem) = unit($unit(S)/$unit(U))
end
for unit ∈ Convert
    @eval begin
        @pure @inline $unit(v::Real,U::UnitSystem) = $unit(v,U,Metric)
        @pure @inline $unit(v::Real,U::UnitSystem,S::UnitSystem) = (u=$unit(U,S);isone(u) ? v : v/u)
        @pure @inline $unit(v::Real,U::UnitSystem{kB,ħ,𝘤,μ₀,mₑ},S::UnitSystem{kB,ħ,𝘤,μ₀,mₑ}) where {kB,ħ,𝘤,μ₀,mₑ} = v
        @pure @inline $unit(U::UnitSystem{kB,ħ,𝘤,μ₀,mₑ},S::UnitSystem{kB,ħ,𝘤,μ₀,mₑ}) where {kB,ħ,𝘤,μ₀,mₑ} = 1
    end
    if unit ∉ (Constants...,:permittivity,:charge,:magneticflux,:impedance,:conductance)
        @eval @pure @inline $unit(U::UnitSystem) = $unit(U,Metric)
    end
end
for unit ∈ (Systems...,Constants...,Physics...,Convert...)
    unit ∉ (:length,:time) && @eval export $unit
end

# common conversion factors

import UnitSystems: atm,g₀,lbm,slug,ft,ftUS,rankine,kelvin
for CAL ∈ (:cal,:calₜₕ,:cal₄,:cal₁₀,:cal₂₀,:calₘ,:calᵢₜ)
    KCAL = Symbol(:k,CAL)
    @eval import UnitSystems: $CAL, $KCAL
end

# fundamental constants, αinv = (34259-1/4366.8123)/250 # 137.036 exactly?

const mP = measurement("0.00000002176434(24)")
const αinv = measurement("137.035999084(21)")
const μₑᵤ = 1/measurement("1822.888486209(53)")
const μₚᵤ = measurement("1.007276466621(53)")
const R∞ = measurement("10973731.5681601(210)")
const KJ2014 = measurement("483597.8525(30)")*1e9
const RK2014 = measurement("25812.8074555(59)")

import UnitSystems: ΔνCs,Kcd,NA,kB,𝘩,𝘤,𝘦,ħ,Rᵤ,αL,RK1990,KJ1990,ħ1990
const mₑ,μ₀ = electronmass(𝘩,R∞),2𝘩/𝘤/αinv/𝘦^2 # ≈ 4π*(1e-7+5.5e-17), exact charge
const δμ₀,μₚₑ,αG,ħ2014 = μ₀-4π*1e-7,μₚᵤ/μₑᵤ,(mₑ/mP)^2,2/RK2014/KJ2014^2/π
const mₑ1990,mₑ2014 = electronmass(2π*ħ1990,R∞),electronmass(2π*ħ2014,R∞)

# engineering units # Thomson: αL = 1/2

const Universe = Coupling{cache(αG),cache(1/αinv),cache(μₑᵤ),cache(μₚᵤ)}()
const Gauss = UnitSystem{cache(1e10*Rᵤ*mₑ/μₑᵤ),1e7*ħ,100𝘤,1,cache(1000mₑ),4π,0.01/𝘤}()
const LorentzHeaviside = UnitSystem{cache(1e10*Rᵤ*mₑ/μₑᵤ),1e7*ħ,100𝘤,1,cache(1000mₑ),1,0.01/𝘤}()
const Thomson = UnitSystem{cache(1e10*Rᵤ*mₑ/μₑᵤ),1e7*ħ,100𝘤,1,cache(1000mₑ),4π,1/2}()
const Kennelly = UnitSystem{cache(Rᵤ*mₑ/μₑᵤ/0.001),ħ,𝘤,1e-7,cache(mₑ),4π}() # ?
const ESU = UnitSystem{cache(1e10*Rᵤ*mₑ/μₑᵤ),1e7*ħ,100𝘤,(100𝘤)^-2,cache(1000mₑ),4π}()
const ESU2019 = UnitSystem{1e7*kB,1e7*ħ,100𝘤,cache(1e3*μ₀/𝘤^2),cache(1000mₑ)}()
const EMU = UnitSystem{cache(1e10*Rᵤ*mₑ/μₑᵤ),1e7*ħ,100𝘤,1,cache(1000mₑ),4π}()
const EMU2019 = UnitSystem{1e7*kB,1e7*ħ,100𝘤,cache(1e7*μ₀),cache(1000mₑ)}()
const MTS = UnitSystem{cache(1e6*Rᵤ*mₑ/μₑᵤ),1000ħ,𝘤,4π/1e4,cache(mₑ/1000)}()
const Mixed = UnitSystem{cache(Rᵤ*mₑ/μₑᵤ/0.001),ħ,𝘤,cache(μ₀),cache(mₑ)}()
const Metric = UnitSystem{cache(Rᵤ*mₑ/μₑᵤ/0.001),ħ,𝘤,4π*1e-7,cache(mₑ)}()
const SI1976 = UnitSystem{cache(8.31432mₑ/μₑᵤ/0.001),ħ,𝘤,4π*1e-7,cache(mₑ)}()
const SI2019 = UnitSystem{kB,ħ,𝘤,cache(μ₀),cache(mₑ)}()
const CODATA = UnitSystem{cache(Rᵤ*mₑ2014/μₑᵤ/0.001),cache(ħ2014),𝘤,cache(2RK2014/𝘤/αinv),cache(mₑ2014)}()
const Conventional = UnitSystem{cache(Rᵤ*mₑ1990/μₑᵤ/0.001),ħ1990,𝘤,cache(2RK1990/𝘤/αinv),cache(mₑ1990)}()
const English = UnitSystem{kB*rankine/slug/ft^2,ħ/slug/ft^2,𝘤/ft,4π,cache(mₑ/slug)}()
const EnglishUS = UnitSystem{cache(1000Rᵤ*mₑ/μₑᵤ*rankine/slug/ftUS^2),ħ/slug/ftUS^2,𝘤/ftUS,4π,cache(mₑ/slug)}()

# astronomical units

const GMsun = measurement("1.32712440018(9)")*1e20
const GMearth = measurement("3.986004418(8)")*1e14
const GMjupiter = measurement("1.26686534(9)")*1e17

import UnitSystems: au,LD,day,pc,ly
const GG = 𝘤*ħ/mP^2; const mₛ = GMsun/GG; const Jₛ = mₛ*au^2/day^2; export mₛ,Jₛ,au,day
const IAU = UnitSystem{cache(Rᵤ*mₑ/μₑᵤ/0.001/Jₛ),cache(ħ/day/Jₛ),day*𝘤/au,cache(4π*1e-7*day^2/Jₛ),cache(mₑ/mₛ)}()

# aliased & humorous units

const mf = mass(90/lbm,Metric,English); const Jf = mf*(201.168/14day)^2
const FFF = UnitSystem{cache(1000Rᵤ*mₑ/μₑᵤ*rankine/Jf),cache(ħ/14day/Jf),14day*𝘤/201.168,0,cache(mₑ/mf)}()
const units, US, SI, MKS, temp = UnitSystem, UnitSystem, SI2019, Metric, temperature
const CGS, CGS2019, CGSm, CGSe, HLU = Gauss, EMU2019, EMU, ESU, LorentzHeaviside

# natural units

const Planck = UnitSystem{1,1,1,1,cache(√(4π*αG))}()
const PlanckGauss = UnitSystem{1,1,1,4π,cache(√αG)}()
const Stoney = UnitSystem{1,cache(αinv),1,4π,cache(√(αG*αinv))}()
const Hartree = UnitSystem{1,1,cache(αinv),cache(4π/αinv^2),1}()
const Rydberg = UnitSystem{1,1,cache(2αinv),cache(π/αinv^2),1/2}()
const Schrodinger = UnitSystem{1,1,cache(αinv),cache(4π/αinv^2),cache(√(αG*αinv))}()
const Electronic = UnitSystem{1,cache(αinv),1,4π,1}()
const Natural = UnitSystem{1,1,1,1,1}()
const NaturalGauss = UnitSystem{1,1,1,4π,1}()
const QCD = UnitSystem{1,1,1,1,cache(1/μₚₑ)}()
const QCDGauss = UnitSystem{1,1,1,4π,cache(1/μₚₑ)}()
const QCDoriginal = UnitSystem{1,1,1,cache(4π/αinv),cache(1/μₚₑ)}()

# physical constants

@pure electronmass(U::typeof(Planck),C::Coupling) = sqrt(4π*coupling(C))
@pure electronmass(U::typeof(PlanckGauss),C::Coupling) = sqrt(coupling(C))
@pure electronmass(U::UnitSystem{kB,ħ,𝘤,μ₀,cache(√(αG*αinv))},C::Coupling) where {kB,ħ,𝘤,μ₀} = sqrt(coupling(C)/finestructure(C))
@pure electronmass(U::UnitSystem{kB,ħ,𝘤,μ₀,cache(1/μₚₑ)},C::Coupling) where {kB,ħ,𝘤,μ₀} = 1/protonelectron(C)
@pure permeability(U::UnitSystem{kB,ħ,𝘤,cache(4π/αinv^2)},C::Coupling) where {kB,ħ,𝘤} = 4π*finestructure(C)^2
@pure permeability(U::UnitSystem{kB,ħ,𝘤,cache(π/αinv^2)},C::Coupling) where {kB,ħ,𝘤} = π*finestructure(C)^2
@pure lightspeed(U::UnitSystem{kB,ħ,cache(αinv)},C::Coupling) where {kB,ħ} = 1/finestructure(C)
@pure lightspeed(U::UnitSystem{kB,ħ,cache(2αinv)},C::Coupling) where {kB,ħ} = 2/finestructure(C)
@pure planckreduced(U::UnitSystem{kB,cache(αinv)},C::Coupling) where kB = 1/finestructure(C)

@pure electronmass(U::UnitSystem{kB,ħ,𝘤,μ₀,cache(mₑ)},C::Coupling) where {kB,ħ,μ₀} = electronmass(planck(U),R∞,C)
@pure electronmass(U::UnitSystem{kB,ħ,100𝘤,μ₀,cache(1000mₑ)},C::Coupling) where {kB,ħ,μ₀} = 1000electronmass(SI,C)
@pure electronmass(U::UnitSystem{kB,ħ,𝘤,μ₀,cache(mₑ/1000)},C::Coupling) where {kB,ħ,μ₀} = electronmass(SI,C)/1000
@pure electronmass(U::UnitSystem{kB,ħ,𝘤,μ₀,cache(mₑ2014)},C::Coupling) where {kB,ħ,μ₀} = electronmass(planck(U),R∞,C)
@pure electronmass(U::UnitSystem{kB,ħ,𝘤,μ₀,cache(mₑ1990)},C::Coupling) where {kB,ħ,μ₀} = electronmass(planck(U),R∞,C)
@pure electronmass(U::UnitSystem{kB,ħ,𝘤/ftUS,μ₀,cache(mₑ/slug)},C::Coupling) where {kB,ħ,μ₀} = electronmass(SI,C)/slug
@pure permeability(U::UnitSystem{kB,ħ,𝘤,cache(μ₀)},C::Coupling) where {kB,ħ,𝘤} = finestructure(C)*2𝘩/𝘤/𝘦^2
@pure permeability(U::typeof(ESU2019),C::Coupling) = 1e3*permeability(SI,C)/𝘤^2
@pure permeability(U::typeof(EMU2019),C::Coupling) = 1e7*permeability(SI,C)
@pure permeability(U::typeof(CODATA),C::Coupling) = 2RK2014*finestructure(C)/𝘤
@pure permeability(U::typeof(Conventional),C::Coupling) = 2RK1990*finestructure(C)/𝘤

@pure molarmass(U::UnitSystem{kB},C::Coupling=universe(U)) = NA*electronmass(U,C)/electronunit(C)
@pure molarmass(U::UnitSystem{1e7*kB},C::Coupling=universe(U)) = 1000molarmass(SI2019,C)
@pure molarmass(U::UnitSystem{1e3*kB},C::Coupling=universe(U)) = molarmass(SI2019,C)/1000
@pure molarmass(U::UnitSystem{cache(boltzmann(MTS))}) = molarmass(CGS)/1e6
@pure molarmass(U::UnitSystem{cache(boltzmann(CGS))}) = molarmass(Natural)
@pure molarmass(U::UnitSystem{cache(boltzmann(FFF))}) = molarmass(Natural)
@pure molarmass(U::UnitSystem{boltzmann(English)},C::Coupling=universe(U)) = 1000molarmass(SI2019,C)
@pure molarmass(U::UnitSystem{cache(boltzmann(EnglishUS))}) = molarmass(Natural)
@pure molarmass(U::UnitSystem{cache(boltzmann(IAU))}) = 1/1000mₛ

@pure luminousefficacy(U::UnitSystem{1}) = 1
@pure luminousefficacy(U::UnitSystem) = power(Kcd,SI2019,U)

@pure universe(::typeof(FFF)) = Universe
for unit ∈ UnitSystems.Systems
    if unit ∉ (:Natural,:NaturalGauss)
        @eval universe(::typeof($unit)) = Universe
    end
end

const dir = dirname(pathof(UnitSystems))
include("$dir/kinematic.jl")
include("$dir/electromagnetic.jl")
include("$dir/thermodynamic.jl")
include("$dir/physics.jl")
include("$dir/systems.jl")

end # module
