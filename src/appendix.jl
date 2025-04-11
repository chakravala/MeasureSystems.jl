
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

using MeasureSystems, FieldAlgebra, StaticVectors

# Standard Units

const StandardUnits = [
    :Constants => [:hyperfine,:lightspeed,:planck,:planckreduced,:electronmass,:molarmass,:boltzmann,:vacuumpermeability,:rationalization,:lorentz,:luminousefficacy,:gravity,:radian,:turn,:spat,:dalton,:protonmass,:planckmass,:gravitation,:gaussgravitation,:einstein,:hartree,:rydberg,:bohr,:electronradius,:avogadro,:molargas,:stefan,:radiationdensity,:vacuumpermittivity,:electrostatic,:magnetostatic,:biotsavart,:elementarycharge,:faraday,:vacuumimpedance,:conductancequantum,:klitzing,:josephson,:magneticfluxquantum,:magneton,:loschmidt,:mechanicalheat,:wienwavelength,:wienfrequency,:sackurtetrode,:eddington,:solarmass,:jupitermass,:earthmass,:gforce,:earthradius,:greatcircle,:nauticalmile,:hubble,:cosmological],
    :Angle => [:turn,:radian,:spatian,:gradian,:degree,:arcminute,:arcsecond],
    :SolidAngle => [:spat,:steradian,:squaredegree],
    :Time => [:second,:minute,:hour,:day,:year],
    :Length => [:angstrom,:inch,:foot,:surveyfoot,:yard,:meter,:earthmeter,:mile,:statutemile,:meridianmile,:admiraltymile,:nauticalmile,:lunardistance,:astronomicalunit,:jupiterdistance,:lightyear,:parsec],
    :Speed => [:bubnoff,:fpm,:ips,:kmh,:fps,:mph,:ms,:mps],
    :Area => [:barn,:hectare,:acre,:surveyacre],
    :Volume => [:liter,:gallon,:quart,:pint,:cup,:fluidounce,:teaspoon,:tablespoon],
    :Mass => [:gram,:earthgram,:kilogram,:tonne,:ton,:pound,:ounce,:grain,:slug,:slinch,:hyl],
    :Force => [:dyne,:newton,:poundal,:poundforce,:kilopond],
    :Pressure => [:psi,:pascal,:barye,:bar,:technicalatmosphere,:atmosphere,:inchmercury,:torr],
    :Energy => [:erg,:joule,:footpound,:calorie,:kilocalorie,:meancalorie,:earthcalorie,:thermalunit,:gasgallon,:tontnt,:electronvolt],
    :Power => [:watt,:horsepowerwatt,:horsepowermetric,:horsepower,:electricalhorsepower,:tonsrefrigeration,:boilerhorsepower],
    :Thermodynamic => [:kelvin,:rankine,:celsius,:fahrenheit,:sealevel,:boiling,:mole,:earthmole,:poundmole,:slugmole,:slinchmole,:katal,:amagat],
    :Photometric => [:lumen,:candela,:lux,:phot,:footcandle,:nit,:apostilb,:stilb,:lambert,:footlambert,:bril,:talbot,:lumerg],
    :Specialized => [:hertz,:apm,:rpm,:kayser,:diopter,:rayleigh,:flick,:gforce,:galileo,:eotvos,:darcy,:poise,:reyn,:stokes,:rayl,:mpge,:langley,:jansky,:solarflux,:curie,:gray,:roentgen],
    :Charge => [:coulomb,:earthcoulomb,:abcoulomb,:statcoulomb],
    :Current => [:ampere,:abampere,:statampere],
    :Electromotive => [:volt,:abvolt,:statvolt],
    :Inductance => [:henry,:abhenry,:stathenry],
    :Resistance => [:ohm,:abohm,:statohm],
    :Conductance => [:siemens,:abmho,:statmho],
    :Capacitance => [:farad,:abfarad,:statfarad],
    :MagneticFlux => [:weber,:maxwell,:statweber],
    :MagneticFluxDensity => [:tesla,:gauss,:stattesla],
    :MagneticSpecialized => [:oersted,:gilbert]]

const sourceconstants = [:boltzmann => :SI2019, :avogadro => :SI2019, :planck => :SI2019, :lightspeed => :SI2019, :elementarycharge => :SI2019, :luminousefficacy => :SI2019, :hyperfine => :SI2019, :rydberg => :SI2019, :finestructure => :Universe, :electronunit => :Universe, :protonunit => :Universe, :darkenergydensity => :Universe, :hubble => :Metric, :gforce => :Metric, :year => :IAU, :astronomicalunit => :Metric, :foot => :Metric, :surveyfoot => :Metric, :pound => :Metric, :celsius => :Metric, :atmosphere => :Metric, :inchmercury => :Metric, :klitzing => :Conventional, :josephson => :Conventional, :klitzing => :CODATA, :josephson => :CODATA, :molargas => :CODATA, :resistance => :Metric, :electricpotential => :Metric, :gaussgravitation => :IAU, :planckmass => :Metric, :earthmass => :Metric, :jupitermass => :Metric]

quantityjoin(nam::String,str::Values) = Values(nam,str...)
quantityjoincut(nam::String,str::Values{N}) where N = Values(nam,str[count(1,N-1)]...)

textconstant(q::Symbol) = haskey(UnitSystems.textconstants,q) ? UnitSystems.textconstants[q] : haskey(UnitSystems.textderived,q) ? UnitSystems.textderived[q] : haskey(UnitSystems.textquantities,q) ? UnitSystems.textquantities[q] : String(q)

function latexquotients()
    out = Pair{Symbol,Vector{Values{2,String}}}[]
    for U ∈ UnitSystems.Systems
        U ∉ (:FFF,) && (print(U,", "); push!(out,U=>Similitude.latexquotient(eval(U))))
    end
    return out
end

function latexsystems()
    out = Pair{Symbol,Vector{Pair{Symbol,Vector{Values{3,String}}}}}[]
    for U ∈ UnitSystems.Systems
        U ∉ (:FFF,) && (print(U,", "); push!(out,U=>latexunits(U)))
    end
    return out
end

latexunits(U::Symbol) = latexunits(eval(U))
function latexunits(U::UnitSystem)
    nam = map.(textconstant,last.(StandardUnits))
    str = map.(Similitude.latexquantity,map.(x->eval(x)(U),last.(StandardUnits)))
    first.(StandardUnits) .=> map.(quantityjoincut,nam,str)
end

function latexunits()
    nam = map.(textconstant,last.(StandardUnits[2:end]))
    str = map.(Similitude.latexquantity,map.(eval,last.(StandardUnits[2:end])))
    out = first.(StandardUnits[2:end]) .=> map.(quantityjoin,nam,str)
    sc = [first(sc)∈(:resistance,:electricpotential) ? eval(first(sc))(International,Metric) : eval(first(sc))(eval(last(sc))) for sc ∈ sourceconstants]
    pushfirst!(out,:Constants => quantityjoin.(vcat(textconstant.(first.(sourceconstants)),["golden ratio","Euler-Mascheroni","Euler","turn","two","three","five","seven","eleven","nineteen","fourty three"]),Similitude.latexquantity.(vcat(sc,[golden,eulergamma,MeasureSystems.phys(36),turn.v,two,three,five,seven,eleven,nineteen,fourtythree]))))
    return out
end

const Dimensions = [:Kinematic => [UnitSystems.Kinematic...], :Mechanical => [UnitSystems.Mechanical...], :Electromagnetic => [UnitSystems.Electromagnetic...], :Thermodynamic => [UnitSystems.Thermodynamic...], :Molar => [UnitSystems.Molar...], :Photometric => [UnitSystems.Photometric...]]

latexdimensions(u::Tuple) = first.(Dimensions) .=> latexdimensions.(Ref(u),last.(Dimensions))
function latexdimensions(u::Tuple,dims); U = (Unified,normal.(u)...)
    nam = textconstant.(dims)
    str = Similitude.latexdimensions.(Similitude.evaldim.(dims),Ref(U))
    quantityjoin.(nam,Values.(str))
end
function latexdimensions()
    [:Kinematic => latexdimensions((Metric,British,English,Gauss),[UnitSystems.Kinematic...]),
        :Mechanical => latexdimensions((Metric,British,English,Gauss),[UnitSystems.Mechanical...]),
        :Electromagnetic => latexdimensions((Metric,EMU,ESU,Gauss),[UnitSystems.Electromagnetic...]),
        :Thermodynamic => latexdimensions((Metric,British,English,Gauss),[UnitSystems.Thermodynamic...]),
        :Molar => latexdimensions((Metric,British,English),[UnitSystems.Molar...]),
        :Photometric => latexdimensions((Metric,British,English,Gauss),[UnitSystems.Photometric...])]
end
