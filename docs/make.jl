#   This file is part of Geophysics.jl. It is licensed under the AGPL license
#   Geophysics Copyright (C) 2019 Michael Reed

using Documenter, AbstractTensors, MeasureSystems

makedocs(
    modules = [MeasureSystems,Similitude,UnitSystems],
    doctest = false,
    checkdocs = :warn,
    format = Documenter.HTML(prettyurls = true), #get(ENV, "CI", nothing) == "true"),
    remotes = nothing,
    sitename = "UnitSystems.jl",
    authors = "Michael Reed",
    pages = Any[
        "UnitSystems README" => "index.md",
        "Similitude" => "similitude.md",
        "unitsystems.md",
        "constants.md",
        "convert.md",
        "units.md",
        "Physics" => Any[
            "Constants" => "physics/".*String.([:hyperfine,:lightspeed,:planck,:planckreduced,:electronmass,:molarmass,:boltzmann,:vacuumpermeability,:rationalization,:lorentz,:luminousefficacy,:gravity,:radian,:turn,:spat,:dalton,:protonmass,:planckmass,:gravitation,:gaussgravitation,:einstein,:hartree,:rydberg,:bohr,:electronradius,:avogadro,:molargas,:stefan,:radiationdensity,:vacuumpermittivity,:electrostatic,:magnetostatic,:biotsavart,:elementarycharge,:faraday,:vacuumimpedance,:conductancequantum,:klitzing,:josephson,:magneticfluxquantum,:magneton,:loschmidt,:mechanicalheat,:wienwavelength,:wienfrequency,:sackurtetrode,:eddington,:solarmass,:jupitermass,:earthmass,:gforce,:earthradius,:greatcircle,:nauticalmile,:hubble,:cosmological]).*".md",
            "Angle" => "physics/".*String.([:turn,:radian,:spatian,:gradian,:degree,:arcminute,:arcsecond]).*".md",
            "SolidAngle" => "physics/".*String.([:spat,:steradian,:squaredegree]).*".md",
            "Time" => "physics/".*String.([:second,:minute,:hour,:day,:year]).*".md",
            "Length" => "physics/".*String.([:angstrom,:inch,:foot,:surveyfoot,:yard,:meter,:earthmeter,:mile,:statutemile,:meridianmile,:admiraltymile,:nauticalmile,:lunardistance,:astronomicalunit,:jupiterdistance,:lightyear,:parsec]).*".md",
            "Speed" => "physics/".*String.([:bubnoff,:fpm,:ips,:kmh,:fps,:mph,:ms,:mps]).*".md",
            "Area" => "physics/".*String.([:barn,:hectare,:acre,:surveyacre]).*".md",
            "Volume" => "physics/".*String.([:liter,:gallon,:quart,:pint,:cup,:fluidounce,:teaspoon,:tablespoon]).*".md",
            "Mass" => "physics/".*String.([:gram,:earthgram,:kilogram,:tonne,:ton,:pound,:ounce,:grain,:slug,:slinch,:hyl]).*".md",
            "Force" => "physics/".*String.([:dyne,:newton,:poundal,:poundforce,:kilopond]).*".md",
            "Pressure" => "physics/".*String.([:psi,:pascal,:barye,:bar,:technicalatmosphere,:atmosphere,:inchmercury,:torr]).*".md",
            "Energy" => "physics/".*String.([:erg,:joule,:footpound,:calorie,:kilocalorie,:meancalorie,:earthcalorie,:thermalunit,:gasgallon,:tontnt,:electronvolt]).*".md",
            "Power" => "physics/".*String.([:watt,:horsepowerwatt,:horsepowermetric,:horsepower,:electricalhorsepower,:tonsrefrigeration,:boilerhorsepower]).*".md",
            "Thermodynamic" => "physics/".*String.([:kelvin,:rankine,:celsius,:fahrenheit,:sealevel,:boiling,:mole,:earthmole,:poundmole,:slugmole,:slinchmole,:katal,:amagat]).*".md",
            "Photometric" => "physics/".*String.([:lumen,:candela,:lux,:phot,:footcandle,:nit,:apostilb,:stilb,:lambert,:footlambert,:bril,:talbot,:lumerg]).*".md",
            "Specialized" => "physics/".*String.([:hertz,:apm,:rpm,:kayser,:diopter,:rayleigh,:flick,:gforce,:galileo,:eotvos,:darcy,:poise,:reyn,:stokes,:rayl,:mpge,:langley,:jansky,:solarflux,:curie,:gray,:roentgen]).*".md",
            "Charge" => "physics/".*String.([:coulomb,:earthcoulomb,:abcoulomb,:statcoulomb]).*".md",
            "Current" => "physics/".*String.([:ampere,:abampere,:statampere]).*".md",
            "Electromotive" => "physics/".*String.([:volt,:abvolt,:statvolt]).*".md",
            "Inductance" => "physics/".*String.([:henry,:abhenry,:stathenry]).*".md",
            "Resistance" => "physics/".*String.([:ohm,:abohm,:statohm]).*".md",
            "Conductance" => "physics/".*String.([:siemens,:abmho,:statmho]).*".md",
            "Capacitance" => "physics/".*String.([:farad,:abfarad,:statfarad]).*".md",
            "MagneticFlux" => "physics/".*String.([:weber,:maxwell,:statweber]).*".md",
            "MagneticFluxDensity" => "physics/".*String.([:tesla,:gauss,:stattesla]).*".md",
            "MagneticSpecialized" => "physics/".*String.([:oersted,:gilbert]).*".md",
        "Appendix" => "appendix/".*Any[
            "Definition","Unified",
            "Metric", "SI2019", "SI1976","CODATA", "Conventional",
            "International", "InternationalMean",
            "MetricTurn", "MetricSpatian", "MetricGradian", "MetricDegree",
            "MetricArcminute", "MetricArcsecond",
            "Engineering", "Gravitational", "MTS",
            "EMU", "ESU", "Gauss", "LorentzHeaviside",
            "FPS", "IPS", "British", "English", "Survey",
            "MPH", "KKH", "Nautical", "Meridian",
            "IAU", "IAUE", "IAUJ", "Hubble", "Cosmological",
            "CosmologicalQuantum", "Planck", "PlanckGauss",
            "Stoney", "Hartree", "Rydberg", "Schrodinger", "Electronic",
            "Natural", "NaturalGauss", "QCD", "QCDGauss", "QCDoriginal"
        ].*".md",
        "Ratios" => "ratios/".*Any[
            "MetricSI2019", "SI2019Metric",
            "MetricCODATA", "CODATAMetric", "SI2019CODATA", "CODATASI2019",
            "MetricConventional", "ConventionalMetric",
            "SI2019Conventional", "ConventionalSI2019",
            "MetricInternational", "InternationalMetric",
            "SI2019International", "InternationalSI2019",
            "MetricInternationalMean", "InternationalMeanMetric",
            "SI2019InternationalMean", "InternationalMeanSI2019",
            "MetricEngineering", "EngineeringMetric",
            "MetricGravitational", "GravitationalMetric",
            "MetricEMU", "EMUMetric", "SI2019EMU", "EMUSI2019",
            "MetricESU", "ESUMetric", "SI2019ESU", "ESUSI2019",
            "MetricGauss", "GaussMetric", "SI2019Gauss", "GaussSI2019",
            "MetricLorentzHeaviside", "LorentzHeavisideMetric",
            "SI2019LorentzHeaviside", "LorentzHeavisideSI2019",
            "MetricEnglish", "EnglishMetric", "SI2019English", "EnglishSI2019",
            "MetricBritish", "BritishMetric", "SI2019British", "BritishSI2019",
            "BritishEnglish", "EnglishBritish",
            "MetricIPS", "IPSMetric", "SI2019IPS", "IPSSI2019",
            "IPSBritish", "BritishIPS",
            "MetricFPS", "FPSMetric", "SI2019FPS", "FPSSI2019",
            "FPSEnglish", "EnglishFPS", "FPSBritish", "BritishFPS", "FPSMPH", "MPHFPS",
            "NauticalFPS", "FPSNautical", "NauticalMPH", "MPHNautical",
            "NauticalKKH", "KKHNautical", "NauticalMetric", "MetricNautical",
            "MeridianMetric", "MetricMeridian", "IAUMetric", "MetricIAU",
            "MetricPlanck", "PlanckMetric", "SI2019Planck", "PlanckSI2019",
            "MetricPlanckGauss", "PlanckGaussMetric",
            "SI2019PlanckGauss", "PlanckGaussSI2019",
            "MetricStoney", "StoneyMetric", "SI2019Stoney", "StoneySI2019",
            "MetricHartree", "HartreeMetric", "SI2019Hartree", "HartreeSI2019",
            "MetricRydberg", "RydbergMetric", "SI2019Rydberg", "RydbergSI2019",
            "MetricSchrodinger", "SchrodingerMetric",
            "SI2019Schrodinger", "SchrodingerSI2019",
            "MetricElectronic", "ElectronicMetric",
            "SI2019Electronic", "ElectronicSI2019",
            "MetricNatural", "NaturalMetric", "SI2019Natural", "NaturalSI2019",
            "MetricNaturalGauss", "NaturalGaussMetric",
            "SI2019NaturalGauss", "NaturalGaussSI2019",
            "MetricQCD", "QCDMetric", "SI2019QCD", "QCDSI2019",
            "MetricQCDGauss", "QCDGaussMetric", "SI2019QCDGauss", "QCDGaussSI2019",
            "MetricQCDoriginal", "QCDoriginalMetric",
            "SI2019QCDoriginal", "QCDoriginalSI2019"
        ].*".md"]
        #"References" => "references.md"
        ]
)

#struct MyDeployConfig <: Documenter.DeployConfig end

#Documenter.deploy_folder(cfg::MyDeployConfig; repo, devbranch, push_preview, devurl, kwargs...) = devurl

#Documenter.authentication_method(::MyDeployConfig) = Documenter.SSH

deploydocs(
    repo   = "github.com/chakravala/MeasureSystems.jl.git",
    #deploy_config = MyDeployConfig(),
    target = "build",
    deps = nothing,
    make = nothing
)

# make multiline HTML
# find build -name "*.html" -exec tidy -m -i -q {} \;
