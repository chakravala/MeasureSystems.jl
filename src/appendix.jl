
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

const FilteredUnits = copy(StandardUnits)
FilteredUnits[1] = first(FilteredUnits[1]) => filter(x->x≠:sackurtetrode,last(FilteredUnits[1]))

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
latexunits(U::typeof(Unified)) = latexunits(U,FilteredUnits)
function latexunits(U::UnitSystem,StandardUnits=StandardUnits)
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

latexdimensions2(u::Tuple) = first.(Dimensions) .=> latexdimensions2.(Ref(u),last.(Dimensions))
function latexdimensions2(u::Tuple,dims); U = (Unified,u...)
    nam = textconstant.(dims)
    str = Similitude.latexdimensions.(Similitude.evaldim.(dims),Ref(U))
    quantityjoin.(nam,Values.(str))
end
function latexdimensions2()
    [:Kinematic => latexdimensions2((Metric,normal(Unified)),[UnitSystems.Kinematic...]),
        :Mechanical => latexdimensions2((Metric,British,normal(Unified)),[UnitSystems.Mechanical...]),
        :Electromagnetic => latexdimensions2((Metric,EMU,ESU,normal(Unified)),[UnitSystems.Electromagnetic...]),
        :Thermodynamic => latexdimensions2((Metric,British,normal(Unified)),[UnitSystems.Thermodynamic...]),
        :Molar => latexdimensions2((Metric,British,normal(Unified)),[UnitSystems.Molar...]),
        :Photometric => latexdimensions2((Metric,British,normal(Unified)),[UnitSystems.Photometric...])]
end

function printmarkdowndimensions()
    ld = latexdimensions()
    out = [
        markdowndimensions(last(ld[1]),Values("Metric","British","English","Gauss")),
        markdowndimensions(last(ld[2]),Values("Metric","British","English","Gauss")),
        markdowndimensions(last(ld[3]),Values("Metric","EMU","ESU","Gauss")),
        markdowndimensions(last(ld[4]),Values("Metric","British","English","Gauss")),
        markdowndimensions(last(ld[5]),Values("Metric","British","English")),
        markdowndimensions(last(ld[6]),Values("Metric","British","English","Gauss"))]
    join("\n## ".*String.(first.(ld)).*"\n\n".*out)
end

function printmarkdowndimensions2()
    ld = latexdimensions2()
    out = [
        markdowndimensions(last(ld[1]),Values("Metric","Product")),
        markdowndimensions(last(ld[2]),Values("Metric","British","Product")),
        markdowndimensions(last(ld[3]),Values("Metric","EMU","ESU","Product")),
        markdowndimensions(last(ld[4]),Values("Metric","British","Product")),
        markdowndimensions(last(ld[5]),Values("Metric","British","Product")),
        markdowndimensions(last(ld[6]),Values("Metric","British","Product"))]
    join("\n## ".*String.(first.(ld)).*"\n\n".*out)
end

function printtexdimensions()
    ld = latexdimensions()
    out = [
        texdimensions(last(ld[1]),Values("Metric","British","English","Gauss")),
        texdimensions(last(ld[2]),Values("Metric","British","English","Gauss")),
        texdimensions(last(ld[3]),Values("Metric","EMU","ESU","Gauss")),
        texdimensions(last(ld[4]),Values("Metric","British","English","Gauss")),
        texdimensions(last(ld[5]),Values("Metric","British","English")),
        texdimensions(last(ld[6]),Values("Metric","British","English","Gauss"))]
    join("\n".*String.(first.(ld)).*"\n\n".*out)
end

function printtexdimensions2()
    ld = latexdimensions2()
    out = [
        texdimensions(last(ld[1]),Values("Metric","Product")),
        texdimensions(last(ld[2]),Values("Metric","British","Product")),
        texdimensions(last(ld[3]),Values("Metric","EMU","ESU","Product")),
        texdimensions(last(ld[4]),Values("Metric","British","Product")),
        texdimensions(last(ld[5]),Values("Metric","British","Product")),
        texdimensions(last(ld[6]),Values("Metric","British","Product"))]
    join("\n".*String.(first.(ld)).*"\n\n".*out)
end

function markdownquantities(data::Vector{Pair{Symbol,Vector{Values{N,String}}}} where N)
    join(join.(markdownquantities.(data)))
end
function markdownquantities(data::Vector{Pair{Symbol,Vector{Values{N,String}}}} where N,str::String)
    join(join.(markdownquantities.(data,Ref(str))))
end
function markdownquantities(data::Pair{Symbol,Vector{Values{N,String}}} where N,str::String=String(first(data)))
    "\n## $(String(first(data))) Units\n\n".*markdownquantities(last(data),str)
end
function markdownquantities(data::Vector{Values{2,String}},quantity::String="Quantity")
    printmarkdown(data,Values(quantity,"Equivalent Dimensions"),Values(":---:",":---"))
end
function markdownquantities(data::Vector{Values{3,String}},quantity::String="Quantity")
    printmarkdown(data,Values("Name",quantity,"Product"),Values("---:",":---",":---:"),quantity=="Unified")
end
function markdownquantities(data::Vector{Values{4,String}},quantity::String="Quantity")
    printmarkdown(data,Values("Name","Quantity","Product","UnitSystem"),Values("---:",":---",":---:",":---"))
end
function markdowndimensions(data::Vector{Values{N,String}},systems::Values{M}) where {N,M}
    printmarkdown(data,Values("","Unified",systems...),Values("---:",":---",[":---:" for i ∈ systems]...))
end

function printmarkdown(data::Vector{Values{N,String}},title::Values{N,String},format::Values{N,String},st::Bool=false) where N
    io = IOBuffer()
    printmarkdown(io,title)
    printmarkdown(io,format)
    printmarkdown(io,data,st)
    String(take!(io))
end

function printmarkdown(io::IO,data::Values{N,String}) where N
    print(io,"|")
    for i ∈ count(1,N)
        @inbounds print(io," ",data[i]," |")
    end
    print(io,"\n")
end
function printmarkdown(io::IO,data::Vector{Values{N,String}},st::Bool=false) where N
    if st
        for i ∈ 1:length(data)
            dat = data[i]
            dat[1]≠"Sackur-Tetrode" && printmarkdown(io,dat)
        end
    else
        for i ∈ 1:length(data)
            printmarkdown(io,data[i])
        end
    end
end

function texquantities(data::Vector{Pair{Symbol,Vector{Values{N,String}}}} where N)
    join(join.(texquantities.(data)))
end
function texquantities(data::Vector{Pair{Symbol,Vector{Values{N,String}}}} where N,str)
    join(join.(texquantities.(data,Ref(str))))
end
function texquantities(data::Pair{Symbol,Vector{Values{N,String}}} where N,str::String=String(first(data)))
    "\n$(String(first(data))) Units\n\n".*texquantities(last(data),str)
end
function texquantities(data::Vector{Values{2,String}},quantity="Quantity")
    printtex(data,Values(quantity,"Equivalent Dimensions"),Values("c","l"))
end
function texquantities(data::Vector{Values{3,String}},quantity="Quantity")
    printtex(data,Values("Name",quantity,"Product"),Values("r","l","c"))
end
function texquantities(data::Vector{Values{4,String}},quantity="Quantity")
    printtex(data,Values("Name","Quantity","Product","UnitSystem"),Values("r","l","c","l"))
end
function texdimensions(data::Vector{Values{N,String}},systems::Values{M}) where {N,M}
    printtex(data,Values("","Unified",systems...),Values("r","l",["c" for i ∈ systems]...))
end

function printtex(data::Vector{Values{N,String}},title::Values{N,String},format::Values{N,String}) where N
    io = IOBuffer()
    print(io,"\\begin{tabular}{$(join(format))}\n")
    printtex(io,title)
    print(io," \\\\\n\\hline\n")
    printtex(io,data)
    print(io,"\n\\end{tabular}\n")
    String(take!(io))
end

function printtex(io::IO,data::Values{N,String}) where N
    for i ∈ count(1,N)
        @inbounds print(io,data[i])
        i≠N && print(io," & ")
    end
end
function printtex(io::IO,data::Vector{Values{N,String}},st=false) where N
    l = length(data)
    if st
        for i ∈ 1:l
            dat = data[i]
            if dat[1]≠"Sackur-Tetrode"
                printtex(io,data[i])
                i≠l && print(io," \\\\\n")
            end
        end
    else
        for i ∈ 1:l
            printtex(io,data[i])
            i≠l && print(io," \\\\\n")
        end
    end
end

function markdownsystem()
    markdownunits()
    markdownunified()
    ls = latexsystems()
    lq = latexquotients()
    for i ∈ 1:length(ls)
        markdownsystem(ls[i],lq[i])
    end
end
function markdownsystem(ls,lq)
    str = """
# $(first(lq))

\$ $(MeasureSystems.dimlistlatex(eval(first(lq)))) \$

data derived with [UnitSystems.jl](https://github.com/chakravala/UnitSystems.jl)  [![DOI](https://zenodo.org/badge/317419353.svg)](https://zenodo.org/badge/latestdoi/317419353)

$(markdownquantities(last(ls),String(first(lq))))

## Equivalent dimensional quantities

$(markdownquantities(last(lq),String(first(lq))))
    """
    writestr(first(lq),str,"md","../docs/src/appendix")
end
function markdownunified()
    str = """
# Unified

data derived with [UnitSystems.jl](https://github.com/chakravala/UnitSystems.jl) [![DOI](https://zenodo.org/badge/317419353.svg)](https://zenodo.org/badge/latestdoi/317419353)

$(printmarkdowndimensions2())

$(markdownquantities(latexunits(Unified),"Unified"))
    """
    writestr(:Unified,str,"md","../docs/src/appendix")
end


function markdownunits()
    str = """
# Definition

data derived with [UnitSystems.jl](https://github.com/chakravala/UnitSystems.jl)  [![DOI](https://zenodo.org/badge/317419353.svg)](https://zenodo.org/badge/latestdoi/317419353)

$(markdownquantities(latexunits()))

$(printmarkdowndimensions())
    """
    writestr(:Definition,str,"md","../docs/src/appendix")
end

function texsystem()
    texunits()
    texunified()
    ls = latexsystems()
    lq = latexquotients()
    for i ∈ 1:length(ls)
        texsystem(ls[i],lq[i])
    end
end
function texsystem(ls,lq)
    str = """
$(first(lq)) : \$ $(MeasureSystems.dimlistlatex(eval(first(lq)))) \$

$(texquantities(last(ls)))

Equivalent dimensional quantities

$(texquantities(last(lq)))
    """
    writestr(first(lq),str,"tex")
end
function texunified()
    str = """
$(printtexdimensions2())

$(texquantities(latexunits(Unified),"Unified"))
    """
    writestr(:Unified,str,"tex")
end


function texunits()
    str = """
Definition

$(texquantities(latexunits()))

$(printtexdimensions())
    """
    writestr(:Definition,str,"tex")
end

function writestr(name,str,ext,pre=ext)
    open(joinpath(pre,"$name.$ext"),"w") do f
        write(f,str)
    end
    return str
end

# electricdisplacement -> electric flux density
