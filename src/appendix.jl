
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
const FilteredSystems = filter(x->x≠:FFF,UnitSystems.Systems)
const UnifiedSystems = [:Unified,FilteredSystems...]

const sourceconstants = [:boltzmann => :SI2019, :avogadro => :SI2019, :planck => :SI2019, :lightspeed => :SI2019, :elementarycharge => :SI2019, :luminousefficacy => :SI2019, :hyperfine => :SI2019, :rydberg => :SI2019, :finestructure => :Universe, :electronunit => :Universe, :protonunit => :Universe, :darkenergydensity => :Universe, :hubble => :Metric, :gforce => :Metric, :year => :IAU, :astronomicalunit => :Metric, :foot => :Metric, :surveyfoot => :Metric, :pound => :Metric, :celsius => :Metric, :atmosphere => :Metric, :inchmercury => :Metric, :klitzing => :Conventional, :josephson => :Conventional, :klitzing => :CODATA, :josephson => :CODATA, :molargas => :CODATA, :resistance => :Metric, :electricpotential => :Metric, :gaussgravitation => :IAU, :planckmass => :Metric, :earthmass => :Metric, :jupitermass => :Metric]

quantityjoin(nam::String,str::Values) = Values(nam,str...)
quantityjoincut(nam::String,str::Values{N}) where N = Values(nam,str[count(1,N-1)]...)

textconstant(q::Symbol) = haskey(UnitSystems.textconstants,q) ? UnitSystems.textconstants[q] : haskey(UnitSystems.textderived,q) ? UnitSystems.textderived[q] : haskey(UnitSystems.textquantities,q) ? UnitSystems.textquantities[q] : String(q)

function latexquotients()
    out = Pair{Symbol,Vector{Values{2,String}}}[]
    for U ∈ FilteredSystems
        print(U,", ")
        push!(out,U=>Similitude.latexquotient(eval(U)))
    end
    return out
end

function latexsystems()
    out = Pair{Symbol,Vector{Pair{Symbol,Vector{Values{3,String}}}}}[]
    for U ∈ FilteredSystems
        print(U,", ")
        push!(out,U=>latexunits(U))
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

function printmarkdowndimensions(ld,vals)
    out = [
        markdowndimensions(last(ld[1]),vals),
        markdowndimensions(last(ld[2]),vals),
        markdowndimensions(last(ld[3]),vals),
        markdowndimensions(last(ld[4]),vals),
        markdowndimensions(last(ld[5]),vals),
        markdowndimensions(last(ld[6]),vals)]
    join("\n## ".*String.(first.(ld)).*"\n\n".*out)
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

function markdownquantities2(data::Vector{Values{3,String}},quantity::String="Quantity")
    printmarkdown(data,Values("Quantity","Product","UnitSystem"),Values(":---",":---:",":---"))
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
    convertmarkdown()
    constantmarkdown()
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

function convertdata(U,S)
    nam = map.(textconstant,last.(Dimensions))
    str = map.(Similitude.latexquantity,map.(Similitude.ConvertUnit{U,S},map.(Similitude.evaldim,last.(Dimensions))))
    map.(quantityjoincut,nam,str)
end

function convertmarkdown(U,S)
    dat = join("## ".*String.(first.(Dimensions)).*" Ratios\n\n".*markdownquantities.(convertdata(U,S)).*"\n")
    str = """
# $U -> $S

data derived with [UnitSystems.jl](https://github.com/chakravala/UnitSystems.jl)  [![DOI](https://zenodo.org/badge/317419353.svg)](https://zenodo.org/badge/latestdoi/317419353)

$dat

$(printmarkdowndimensions(latexdimensions((U,S)),Values(Similitude.unitname(normal(U)),Similitude.unitname(normal(S)))))
    """
    writestr("$U$S",str,"md","../docs/src/ratios")
end

function convertmarkdown2(list,U,S)
    u,s = Similitude.unitname(normal(U)),Similitude.unitname(normal(S))
    push!(list,u*s)
    println(u*s)
    convertmarkdown(U,S)
    push!(list,s*u)
    println(s*u)
    convertmarkdown(S,U)
end

function convertmarkdown2(list,U)
    convertmarkdown2(list,Metric,U)
    convertmarkdown2(list,SI2019,U)
end

function convertmarkdown()
    list = String[]
    convertmarkdown2(list,Metric,SI2019)
    convertmarkdown2(list,CODATA)
    convertmarkdown2(list,Conventional)
    convertmarkdown2(list,International)
    convertmarkdown2(list,InternationalMean)
    convertmarkdown2(list,Metric,Engineering)
    convertmarkdown2(list,Metric,Gravitational)
    convertmarkdown2(list,EMU)
    convertmarkdown2(list,ESU)
    convertmarkdown2(list,Gauss)
    convertmarkdown2(list,LorentzHeaviside)
    convertmarkdown2(list,English)
    convertmarkdown2(list,British)
    convertmarkdown2(list,British,English)
    convertmarkdown2(list,IPS)
    convertmarkdown2(list,IPS,British)
    convertmarkdown2(list,FPS)
    convertmarkdown2(list,FPS,English)
    convertmarkdown2(list,FPS,British)
    convertmarkdown2(list,FPS,MPH)
    convertmarkdown2(list,Nautical,FPS)
    convertmarkdown2(list,Nautical,MPH)
    convertmarkdown2(list,Nautical,KKH)
    convertmarkdown2(list,Nautical,Metric)
    convertmarkdown2(list,Meridian,Metric)
    convertmarkdown2(list,IAU,Metric)
    convertmarkdown2(list,Planck)
    convertmarkdown2(list,PlanckGauss)
    convertmarkdown2(list,Stoney)
    convertmarkdown2(list,Hartree)
    convertmarkdown2(list,Rydberg)
    convertmarkdown2(list,Schrodinger)
    convertmarkdown2(list,Electronic)
    convertmarkdown2(list,Natural)
    convertmarkdown2(list,NaturalGauss)
    convertmarkdown2(list,QCD)
    convertmarkdown2(list,QCDGauss)
    convertmarkdown2(list,QCDoriginal)
    return list
end

constantmarkdown() = constantmarkdown.(vcat(last.(StandardUnits)...))
function constantmarkdown(val::Symbol)
    dat = [Similitude.latexquantity(eval(:($val($U)))) for U ∈ FilteredSystems]
    #quantityjoin.(Ref(textconstant(val)),dat)
    D = val≠:sackurtetrode ? dimensions(eval(:($val(Unified)))) : 𝟙
    dim = "\$$(Similitude.latexdimensions(D,Unified))\$"
    usq = "\$$(Similitude.latexdimensions(D,normal(Unified)))\$"
    str = """
# $(textconstant(val)) unit

data derived with [UnitSystems.jl](https://github.com/chakravala/UnitSystems.jl)  [![DOI](https://zenodo.org/badge/317419353.svg)](https://zenodo.org/badge/latestdoi/317419353)

$dim

$usq

$(haskey(eqns,val) ? eqns[val] : "")

$(markdownquantities2(dat))
    """
    writestr(String(val),str,"md","../docs/src/physics")
end

const eqns = Dict([
    :lightspeed => """
```math
c = \\frac1{\\alpha_L\\sqrt{\\mu_0\\varepsilon_0}} = \\frac{1}{\\alpha}\\sqrt{E_h\\frac{g_0}{m_e}} = \\frac{g_0\\hbar\\alpha}{m_e r_e}  = \\frac{e^2k_e}{\\hbar\\alpha} = \\frac{m_e^2G}{\\hbar\\alpha_G}
```
    """,
    :planck => """
```math
h = 2\\pi\\hbar = \\frac{2e\\alpha_L}{K_J} = \\frac{8\\alpha}{\\lambda c\\mu_0K_J^2} = \\frac{4\\alpha_L^2}{K_J^2R_K}
```
    """,
    :planckreduced => """
```math
\\hbar = \\frac{h}{2\\pi} = \\frac{e\\alpha_L}{\\pi K_J} = \\frac{4\\alpha}{\\pi\\lambda c\\mu_0K_J^2} = \\frac{2\\alpha_L}{\\pi K_J^2R_K}
```
    """,
    :planckmass => """
```math
m_P = \\sqrt{\\frac{\\hbar c}{G}} = \\frac{m_e}{\\sqrt{\\alpha_G}} = \\frac{2R_\\infty hg_0}{c\\alpha^2\\sqrt{\\alpha_G}}
```
    """,
    :gaussgravitation => """
```math
k = \\frac{\\sqrt{\\hbar c}}{m_P} = \\frac{\\sqrt{\\hbar c\\alpha_G}}{m_e} = \\frac{\\alpha^2}{2g_0R_\\infty}\\sqrt{\\frac{c^3\\alpha_G}{2\\pi h}} = c^2\\sqrt{\\frac{\\kappa}{8\\pi}}
```
    """,
    :gravitation => """
```math
G = k^2 = \\frac{\\hbar c}{m_P^2} = \\frac{\\hbar c\\alpha_G}{m_e^2} = \\frac{c^3\\alpha^4\\alpha_G}{8\\pi g_0^2 R_\\infty^2 h} = \\frac{\\kappa c^4}{8\\pi}
```
    """,
    :einstein => """
```math
\\kappa = \\frac{8\\pi G}{c^4} = \\frac{8\\pi\\hbar}{c^3m_P^2} = \\frac{8\\pi\\hbar\\alpha_G}{c^3m_e^2} = \\frac{\\alpha^4\\alpha_G}{g_0^2R_\\infty^2 h c}
```
    """,
## Atomic & Nuclear Constants
    :dalton => """
```math
m_u = \\frac{M_u}{N_A} = \\frac{m_e}{\\mu_{eu}} = \\frac{m_p}{\\mu_{pu}} = \\frac{2R_\\infty hg_0}{\\mu_{eu}c\\alpha^2} = \\frac{m_P}{\\mu_{eu}}\\sqrt{\\alpha_G}
```
    """,
    :protonmass => """
```math
m_p = \\mu_{pu} m_u = \\mu_{pu}\\frac{M_u}{N_A} = \\mu_{pe}m_e = \\mu_{pe}\\frac{2R_\\infty hg_0}{c\\alpha^2} = m_P\\mu_{pe}\\sqrt{\\alpha_G}
```
    """,
    :electronmass => """
```math
m_e = \\mu_{eu}m_u = \\mu_{eu}\\frac{M_u}{N_A} = \\frac{m_p}{\\mu_{pe}} = \\frac{2R_\\infty h g_0}{c\\alpha^2} = m_P\\sqrt{\\alpha_G}
```
    """,
    :hartree => """
```math
E_h = \\frac{m_e}{g_0}(c\\alpha)^2 = \\frac{\\hbar c\\alpha}{a_0} = \\frac{g_0\\hbar^2}{m_ea_0^2} = 2R_\\infty hc = \\frac{m_P}{g_0}\\sqrt{\\alpha_G}(c\\alpha)^2
```
    """,
    :rydberg => """
```math
R_\\infty = \\frac{E_h}{2hc} = \\frac{m_e c\\alpha^2}{2hg_0} = \\frac{\\alpha}{4\\pi a_0} = \\frac{m_e r_e c}{2ha_0g_0} = \\frac{\\alpha^2m_ec}{4\\pi\\hbar g_0}  = \\frac{m_Pc\\alpha^2\\sqrt{\\alpha_G}}{2hg_0}
```
    """,
    :bohr => """
```math
a_0 = \\frac{g_0\\hbar}{m_ec\\alpha} = \\frac{g_0\\hbar^2}{k_e m_ee^2} = \\frac{r_e}{\\alpha^2} = \\frac{\\alpha}{4\\pi R_\\infty}
```
    """,
    :electronradius => """
```math
r_e = g_0\\frac{\\hbar\\alpha}{m_ec} = \\alpha^2a_0 = g_0\\frac{e^2 k_e}{m_ec^2} = \\frac{2hR_\\infty g_0a_0}{m_ec} = \\frac{\\alpha^3}{4\\pi R_\\infty}
```
    """,
    :hyperfine => """
```math
\\Delta\\nu_{\\text{Cs}} = \\Delta\\tilde\\nu_{\\text{Cs}}c = \\frac{\\Delta\\omega_{\\text{Cs}}}{2\\pi}  = \\frac{c}{\\Delta\\lambda_{\\text{Cs}}} = \\frac{\\Delta E_{\\text{Cs}}}{h}
```
    """,
## Thermodynamic Constants
    :molarmass => """
```math
M_u = m_uN_A = N_A\\frac{m_e}{\\mu_{eu}} = N_A\\frac{m_p}{\\mu_{pu}} = N_A\\frac{2R_\\infty hg_0}{\\mu_{eu}c\\alpha^2}
```
    """,
    :avogadro => """
```math
N_A = \\frac{R_u}{k_B} = \\frac{M_u}{m_u} = M_u\\frac{\\mu_{eu}}{m_e} = M_u\\frac{\\mu_{eu}c\\alpha^2}{2R_\\infty h g_0}
```
    """,
    :boltzmann => """
```math
k_B = \\frac{R_u}{N_A} = m_u\\frac{R_u}{M_u} = \\frac{m_e R_u}{\\mu_{eu}M_u} = \\frac{2R_uR_\\infty h g_0}{M_u \\mu_{eu}c\\alpha^2}
```
    """,
    :molargas => """
```math
R_u = k_B N_A = k_B\\frac{M_u}{m_u} = k_BM_u\\frac{\\mu_{eu}}{m_e} = k_BM_u\\frac{\\mu_{eu}c\\alpha^2}{2hR_\\infty g_0}
```
    """,
    :loschmidt => """
```math
\\frac{p_0}{k_B T_0} = \\frac{N_Ap_0}{R_uT_0} = \\frac{\\mu_{eu}M_up_0}{m_e R_u T_0} = \\frac{M_u \\mu_{eu}c\\alpha^2p_0}{2R_uR_\\infty hg_0 T_0}
```
    """,
    :sackurtetrode => """
```math
\\frac{S_0}{R_u} = log\\left(\\frac{\\hbar^3}{p_0}\\sqrt{\\left(\\frac{m_u}{2\\pi g_0}\\right)^3 \\left(k_BT_0\\right)^5}\\right)+\\frac{5}{2} = log\\left(\\frac{m_u^4}{p_0}\\left(\\frac{\\hbar}{\\sqrt{2\\pi g_0}}\\right)^3\\sqrt{\\frac{R_uT_0}{M_u}}^5\\right)+\\frac{5}{2}
```
    """,
    :mechanicalheat => """
```math
\\frac{180 R_uV_{it}^2}{43 k_BN_A\\Omega_{it}} =
\\frac{180 k_BM_uV_{it}^2}{43 R_um_u\\Omega_{it}} =
\\frac{90 k_BM_u\\mu_{eu}c\\alpha^2V_{it}^2}{43 hg_0R_uR_\\infty\\Omega_{it}}
```
    """,
    :stefan => """
```math
\\sigma = \\frac{2\\pi^5 k_B^4}{15h^3c^2} = \\frac{\\pi^2 k_B^4}{60\\hbar^3c^2} = \\frac{32\\pi^5 h}{15c^6\\alpha^8} \\left(\\frac{g_0R_uR_\\infty}{\\mu_{eu}M_u}\\right)^4
```
    """,
    :radiationdensity => """
```math
a = 4\\frac{\\sigma}{c} = \\frac{8\\pi^5 k_B^4}{15h^3c^3} = \\frac{\\pi^2 k_B^4}{15\\hbar^3c^3} = \\frac{2^7\\pi^5 h}{15c^7\\alpha^8} \\left(\\frac{g_0R_uR_\\infty}{\\mu_{eu}M_u}\\right)^4
```
    """,
    :wienwavelength => """
```math
b = \\frac{hc/k_B}{5+W_0(-5 e^{-5})} = \\frac{hcM_u/(m_uR_u)}{5+W_0(-5 e^{-5})} = \\frac{M_u \\mu_{eu}c^2\\alpha^2/(2R_uR_\\infty g_0)}{5+W_0(-5 e^{-5})}
```
    """,
    :wienfrequency => """
```math
\\frac{3+W_0(-3 e^{-3})}{h/k_B} = \\frac{3+W_0(-3 e^{-3})}{hM_u/(m_uR_u)} = \\frac{3+W_0(-3 e^{-3})}{M_u \\mu_{eu}c\\alpha^2/(2R_uR_\\infty g_0)}
```
    """,
    :luminousefficacy => """
```math
K_{\\text{cd}} = \\frac{I_v}{\\int_0^\\infty \\bar{y}(\\lambda)\\cdot\\frac{dI_e}{d\\lambda}d\\lambda}, \\qquad 
\\bar{y}\\left(\\frac{c}{540\\times 10^{12}}\\right)\\cdot I_e = 1
```
    """,
## Electromagnetic Constants
    :rationalization => """
```math
\\lambda = \\frac{4\\pi\\alpha_B}{\\mu_0\\alpha_L} = 4\\pi k_e\\varepsilon_0 = Z_0\\varepsilon_0c
```
    """,
    :lorentz => """
```math
\\alpha_L = \\frac{1}{c\\sqrt{\\mu_0\\varepsilon_0}} = \\frac{\\alpha_B}{\\mu_0\\varepsilon_0k_e} = \\frac{4\\pi \\alpha_B}{\\lambda\\mu_0} = \\frac{k_m}{\\alpha_B}
```
    """,
    :biotsavart => """
```math
\\alpha_B = \\mu_0\\alpha_L\\frac{\\lambda}{4\\pi} = \\alpha_L\\mu_0\\varepsilon_0k_e = \\frac{k_m}{\\alpha_L} = \\frac{k_e}{c}\\sqrt{\\mu_0\\varepsilon_0}
```
    """,
    :vacuumimpedance => """
```math
Z_0 = \\mu_0\\lambda c\\alpha_L^2 = \\frac{\\lambda}{\\varepsilon_0 c} = \\lambda\\alpha_L\\sqrt{\\frac{\\mu_0}{\\varepsilon_0}} = \\frac{2h\\alpha}{e^2} = 2R_K\\alpha
```
    """,
    :vacuumpermeability => """
```math
\\mu_0 = \\frac{1}{\\varepsilon_0 (c\\alpha_L)^2} = \\frac{4\\pi k_e}{\\lambda (c\\alpha_L)^2} = \\frac{2h\\alpha}{\\lambda c(e\\alpha_L)^2} = \\frac{2R_K\\alpha}{\\lambda c\\alpha_L^2}
```
    """,
    :vacuumpermittivity => """
```math
\\varepsilon_0 = \\frac{1}{\\mu_0(c\\alpha_L)^2} = \\frac{\\lambda}{4\\pi k_e} = \\frac{\\lambda e^2}{2\\alpha hc} = \\frac{\\lambda}{2R_K\\alpha c}
```
    """,
    :electrostatic => """
```math
k_e = \\frac{\\lambda}{4\\pi\\varepsilon_0} = \\frac{\\mu_0\\lambda (c\\alpha_L)^2}{4\\pi} = \\frac{\\alpha \\hbar c}{e^2} = \\frac{R_K\\alpha c}{2\\pi} = \\frac{\\alpha_B}{\\alpha_L\\mu_0\\varepsilon_0} = k_mc^2
```
    """,
    :magnetostatic => """
```math
k_m = \\alpha_L\\alpha_B = \\mu_0\\alpha_L^2\\frac{\\lambda}{4\\pi} = \\frac{k_e}{c^2} = \\frac{\\alpha \\hbar}{ce^2} = \\frac{R_K\\alpha}{2\\pi c}
```
    """,
    :elementarycharge => """
```math
e = \\sqrt{\\frac{2h\\alpha}{Z_0}} = \\frac{2\\alpha_L}{K_JR_K} = \\sqrt{\\frac{h}{R_K}} = \\frac{hK_J}{2\\alpha_L} = \\frac{F}{N_A}
```
    """,
    :faraday => """
```math
F = eN_A = N_A\\sqrt{\\frac{2h\\alpha}{Z_0}} = \\frac{2N_A\\alpha_L}{K_JR_K} = N_A\\sqrt{\\frac{h}{R_K}} = \\frac{hK_JN_A}{2\\alpha_L}
```
    """,
    :conductancequantum => """
```math
G_0 = \\frac{2e^2}{h} = \\frac{4\\alpha}{Z_0} = \\frac{2}{R_K} = \\frac{hK_J^2}{2\\alpha_L^2} = \\frac{2F^2}{hN_A^2}
```
    """,
    :klitzing => """
```math
R_K = \\frac{h}{e^2} = \\frac{Z_0}{2\\alpha} = \\frac{2}{G_0} = \\frac{4\\alpha_L^2}{hK_J^2} = h\\frac{N_A^2}{F^2}
```
    """,
    :josephson => """
```math
K_J = \\frac{2e\\alpha_L}{h} = \\alpha_L\\sqrt{\\frac{8\\alpha}{hZ_0}} = \\alpha_L\\sqrt{\\frac{4}{hR_K}} = \\frac{1}{\\Phi_0} = \\frac{2F\\alpha_L}{hN_A}
```
    """,
    :magneticfluxquantum => """
```math
\\Phi_0 = \\frac{h}{2e\\alpha_L} = \\frac{1}{\\alpha_L}\\sqrt{\\frac{hZ_0}{8\\alpha}} = \\frac{1}{\\alpha_L}\\sqrt{\\frac{hR_K}{4}} = \\frac{1}{K_J} = \\frac{hN_A}{2F\\alpha_L}
```
    """,
    :magneton => """
```math
\\mu_B = \\frac{e\\hbar\\alpha_L}{2m_e} = \\frac{\\hbar\\alpha_L^2}{m_eK_JR_K} = \\frac{h^2K_J}{8\\pi m_e} = \\frac{\\alpha_L\\hbar F}{2m_e N_A} = \\frac{ec\\alpha^2\\alpha_L}{8\\pi g_0R_\\infty}
```
    """])

# electricdisplacement -> electric flux density
