# UnitSystems.jl

*Physical unit systems (Metric, English, Natural, etc...)*

[![DOI](https://zenodo.org/badge/317419353.svg)](https://zenodo.org/badge/latestdoi/317419353)
[![Docs Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://units.crucialflow.com)
[![Build Status](https://travis-ci.org/chakravala/UnitSystems.jl.svg?branch=master)](https://travis-ci.org/chakravala/UnitSystems.jl)
[![Build status](https://ci.appveyor.com/api/projects/status/r4gmftclfm30ik9n?svg=true)](https://ci.appveyor.com/project/chakravala/unitsystems-jl)
[![Coverage Status](https://coveralls.io/repos/chakravala/UnitSystems.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/chakravala/UnitSystems.jl?branch=master)
[![codecov.io](https://codecov.io/github/chakravala/UnitSystems.jl/coverage.svg?branch=master)](https://codecov.io/github/chakravala/UnitSystems.jl?branch=master)

In aggregate, the `UnitSystem` data generated here constitutes a new universal standardization for dimensional analysis, which generalizes upon previous historical systems up to the 2019 redefinition and unifies them in a common `Universe`.
This enables a more precise and generalized standardization than the 2019 redefinition, which was comparatively limited in scope.
Specified default `UnitSystem` values are to be taken as a newly defined mutually-compatible recommended standard, verified to be consistent and coherent.
A `UnitSystem` can only be useful as a measuring standard if it can be scientifically reproduced, so the data here has been implemented in several important scientific programming languages (initially in the Julia language but also Wolfram language and Rust langauge) as well as presented abstractly in terms of dimensional formulas.

> In fact there is nothing transcendental about dimensions; the ultimate principle is precisely expressible (in Newton's terminology) as one of *similitude*, exact or approximate, to be tested by the rule that mere change in the magnitudes of the ordered scheme of units of measurement that is employed must not affect sensibly the forms of the equations that are the adequate expression of the underlying relations of the problem. (J.L., 1914)

Specifications for dimensional units are in the [UnitSystems.jl](https://github.com/chakravala/UnitSystems.jl) and [Similitude.jl](https://github.com/chakravala/Similitude.jl) and [MeasureSystems.jl](https://github.com/chakravala/MeasureSystems.jl) repositories.
The three packages are designed so that they can be interchanged with compatibility.
On its own `UnitSystems` is the fastest package, while `Similitude` (provides `Quantity` type) and `MeasureSystems` (introduces [Measurements.jl](https://github.com/JuliaPhysics/Measurements.jl) uncertainty) build additional features on top of `UnitSystems` base defintions.
Additionally, in the `UnitSystems` repository there is an equivalent [Wolfram language paclet](https://reference.wolfram.com/language/guide/Paclets) `Kernel` and also an unmaintained Rust `src` implementation.
Defaults are shared: `Metric`, `SI2019`, `CODATA`, `Conventional`, `International`, `InternationalMean`, `MetricTurn`, `MetricGradian`, `MetricDegree`, `MetricArcminute`, `MetricArcsecond`, `Engineering`, `Gravitational`, `FPS`, `IPS`, `British`, `English`, `Survey`, `Gauss`, `LorentzHeaviside`, `EMU`, `ESU`, `IAU`, `IAUE`, `IAUJ`, `Hubble`, `Cosmological`, `CosmologicalQuantum`, `Meridian`, `Nautical`, `MPH`, `KKH`, `MTS`, `FFF`, `Planck`, `PlanckGauss`, `Stoney`, `Hartree`, `Rydberg`, `Schrodinger`, `Electronic`, `Natural`, `NaturalGauss`, `QCD`, `QCDGauss`, `QCDoriginal`.

```Julia
julia> using UnitSystems # or Similitude or MeasureSystems
```

An optional environment variable `ENV["SIMILITUDE"]` induces `UnitSystems.similitude()` to return `true`, giving flexibility for building dependencies whenever it is desirable to toggle usage between `UnitSystems` (default) and `Similitude` (requires environment variable specification). For example, in `MeasureSystems` and `Geophysics` this option is used to increase flexibility with variety in local compilation workflow.

A `UnitSystem` is a consistent set of dimensional values selected to accomodate a particular use case or standardization.
It is possible to convert derived physical quantities from any `UnitSystem` specification into any other using accurate values.
Eleven fundamental constants `kB`, `ħ`, `𝘤`, `μ₀`, `mₑ`, `Mᵤ`, `Kcd`, `θ`, `λ`, `αL`, `g₀` are used to govern a specific unit system consistent scaling.
These are the constants `boltzmann`, `planckreduced`, `lightspeed`, `vacuumpermeability`, `electronmass`, `molarmass`, `luminousefficacy`, `angle`, `rationalization`, `lorentz`, and `gravity`.
Different choices of natural units or physical measurements result in a variety of unit systems for many purposes.

Main documentation is at [https://units.crucialflow.com/unitsystems](https://units.crucialflow.com/unitsystems)

Historically, older electromagnetic unit systems also relied on a `rationalization` constant `λ` and a `lorentz` force proportionality constant `αL`.
In most unit systems these extra constants have a value of `1` unless specified.

```Julia
    UnitSystem{kB, ħ, 𝘤, μ₀, mₑ, Mᵤ, (Kcd, θ, λ, αL, g₀, ...)}
```

Fundamental constants of physics are: `kB` Boltzmann's constant, `ħ` reduced Planck's constant, `𝘤` speed of light, `μ₀` vacuum permeability, `mₑ` electron rest mass, `Mᵤ` molar mass, `Kcd` luminous efficacy, `θ` angle measure, `λ` Gauss rationalization, `αL` Lorentz's constant, and `g₀` gravitational force reference.
Primarily the `Metric` SI unit system is used in addition to the historic `English` engineering unit system.
These constants induce derived values for `avogadro`, `boltzmann`, `molargas`, `planck`, `planckreduced`, `lightspeed`, `planckmass`, `dalton`, `protonmass`, `electronmass`, `newton`, `einstein`, `vacuumpermeability`, `vacuumpermittivity`, `electrostatic`, and
additional constants `molarmass`, `luminousefficacy`, `gravity`, `angle`, `turn`, `spat`, `stefan`, `radiationdensity`, `magnetostatic`, `lorentz`, `biotsavart`, `rationalization`, `vacuumimpedance`, `elementarycharge`, `magneton`, `conductancequantum`, `faraday`, `magneticfluxquantum`, `josephson`, `klitzing`, `hartree`, `rydberg`, `bohr`.

Physics constant documentation is at [https://units.crucialflow.com/constants](https://units.crucialflow.com/constants)

Standardized unit/derived quantities are `hyperfine`, `loschmidt`, `wienwavelength`, `wienfrequency`, `mechanicalheat`, `eddington`, `solarmass`, `jupitermass`, `earthmass`, `lunarmass`, `earthradius`, `greatcircle`, `radarmile`, `hubble`, `cosmological`, `radian`, `steradian`, `degree`, `squaredegree`, `gradian`, `arcminute`, `arcsecond`, `second`, `minute`, `hour`, `day`, `gaussianmonth`, `siderealmonth`, `synodicmonth`, `year`, `gaussianyear`, `siderealyear`, `jovianyear`, `angstrom`, `inch`, `foot`, `surveyfoot`, `yard`, `meter`, `earthmeter`, `mile`, `statutemile`, `meridianmile`, `admiraltymile`, `nauticalmile`, `lunardistance`, `astronomicalunit`, `jupiterdistance`, `lightyear`, `parsec`, `bubnoff`, `ips`, `fps`, `fpm`, `ms`, `kmh`, `mph`, `knot`, `mps`, `barn`, `hectare`, `acre`, `surveyacre`, `liter`, `gallon`, `quart`, `pint`, `cup`, `fluidounce`, `teaspoon`, `tablespoon`, `grain`, `gram`, `earthgram`, `kilogram`, `tonne`, `ton`, `pound`, `ounce`, `slug`, `slinch`, `hyl`, `dyne`, `newton`, `poundal`, `poundforce`, `kilopond`, `psi`, `pascal`, `bar`, `barye`, `technicalatmosphere`, `atmosphere`, `inchmercury`, `torr`, `electronvolt`, `erg`, `joule`, `footpound`, `calorie`, `kilocalorie`, `meancalorie`, `earthcalorie`, `thermalunit`, `gasgallon`, `tontnt`, `watt`, `horsepower`, `horsepowerwatt`, `horsepowermetric`, `electricalhorsepower`, `tonsrefrigeration`, `boilerhorsepower`, `coulomb`, `earthcoulomb`, `ampere`, `volt`, `henry`, `ohm`, `siemens`, `farad`, `weber`, `tesla`, `abcoulomb`, `abampere`, `abvolt`, `abhenry`, `abohm`, `abmho`, `abfarad`, `maxwell`, `gauss`, `oersted`, `gilbert`, `statcoulomb`, `statampere`, `statvolt`, `stathenry`, `statohm`, `statmho`, `statfarad`, `statweber`, `stattesla`, `kelvin`, `rankine`, `celsius`, `fahrenheit`, `sealevel`, `boiling`, `mole`, `earthmole`, `poundmole`, `slugmole`, `slinchmole`, `katal`, `amagat`, `lumen`, `candela`, `lux`, `phot`, `footcandle`, `nit`, `apostilb`, `stilb`, `lambert`, `footlambert`, `bril`, `neper`, `bel`, `decibel`, `hertz`, `apm`, `rpm`, `kayser`, `diopter`, `gforce`, `galileo`, `eotvos`, `darcy`, `poise`, `reyn`, `stokes`, `rayl`, `mpge`, `langley`, `jansky`, `solarflux`, `curie`, `gray`, `roentgen`, `rem`.

Standard physics units are at [https://units.crucialflow.com/units](https://units.crucialflow.com/units)

Additional reference `UnitSystem` variants: `EMU`, `ESU`, `Gauss`, `LorentzHeaviside`, `SI2019`, `SI1976`, `CODATA`, `Conventional`, `International`, `InternationalMean`, `Engineering`, `Gravitational`, `IAU`, `IAUE`, `IAUJ`, `FPS`, `IPS`, `British`, `Survey`, `Hubble`, `Cosmological`, `CosmologicalQuantum`, `Meridian`, `Nautical`, `MPH`, `KKH`, `MTS`, `FFF`; and natural atomic units based on gravitational `coupling` and `finestructure` constant (`Planck`, `PlanckGauss`, `Stoney`, `Hartree`, `Rydberg`, `Schrodinger`, `Electronic`, `Natural`, `NaturalGauss`, `QCD`, `QCDGauss`, and `QCDoriginal`).

Unit conversion documentation is at [https://units.crucialflow.com/convert](https://units.crucialflow.com/convert)

**Derived Unit conversions:**

Mechanics: `angle`, `solidangle`, `time`, `angulartime`, `length`, `angularlength`, `area`, `angulararea`, `volume`, `wavenumber`, `angularwavenumber`, `fuelefficiency`, `numberdensity`, `frequency`, `angularfrequency`, `frequencydrift`, `stagnance`, `speed`, `acceleration`, `jerk`, `snap`, `crackle`, `pop`, `volumeflow`, `etendue`, `photonintensity`, `photonirradiance`, `photonradiance`,
`inertia`, `mass`, `massflow`, `lineardensity`, `areadensity`, `density`, `specificweight`, `specificvolume`, `force`, `specificforce`, `gravityforce`, `pressure`, `compressibility`, `viscosity`, `diffusivity`, `rotationalinertia`, `impulse`, `momentum`, `angularmomentum`, `yank`, `energy`, `specificenergy`, `action`, `fluence`, `power`, `powerdensity`, `irradiance`, `radiance`, `radiantintensity`, `spectralflux`, `spectralexposure`, `soundexposure`, `impedance`, `specificimpedance`, `admittance`, `compliance`, `inertance`;
Electromagnetics: `charge`, `chargedensity`, `linearchargedensity`, `exposure`, `mobility`, `current`, `currentdensity`, `resistance`, `conductance`, `resistivity`, `conductivity`, `capacitance`, `inductance`, `reluctance`, `permeance`, `permittivity`, `permeability`, `susceptibility`, `specificsusceptibility`, `demagnetizingfactor`, `vectorpotential`, `electricpotential`, `magneticpotential`, `electricfield`, `magneticfield`, `electricflux`, `magneticflux`, `electricdisplacement`, `magneticfluxdensity`, `electricdipolemoment`, `magneticdipolemoment`, `electricpolarizability`, `magneticpolarizability`, `magneticmoment`, `specificmagnetization`, `polestrength`;
Thermodynamics: `temperature`, `entropy`, `specificentropy`, `volumeheatcapacity`, `thermalconductivity`, `thermalconductance`, `thermalresistivity`, `thermalresistance`, `thermalexpansion`, `lapserate`,
`molarmass`, `molality`, `mole`, `molarity`, `molarvolume`, `molarentropy`, `molarenergy`, `molarconductivity`, `molarsusceptibility`, `catalysis`, `specificity`, `diffusionflux`,
`luminousflux`, `luminousintensity`, `luminance`, `illuminance`, `luminousenergy`, `luminousexposure`, `luminousefficacy`.

**Generalized dimensionless `Coupling`:**

```Julia
Coupling{αG,α,μₑᵤ,μₚᵤ,ΩΛ}
```
Specification of `Universe` with the dimensionless `Coupling` constants `coupling`, `finestructure`, `electronunit`, `protonunit`, `protonelectron`, and `darkenergydensity`. Alterations to these values can be facilitated and quantified using parametric polymorphism.
Due to the `Coupling` interoperability, the `MeasureSystems` package is made possible to support calculations with `Measurements` having error standard deviations.

```@contents
Pages = ["similitude.md","unitsystems.md","constants.md","convert.md","units.md"]
```

## Appendix

```@contents
Pages = "appendix/".*[
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
].*".md"
Depth = 1
```

## Conversion Ratio

```@contents
Pages = "ratios/".*[
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
].*".md"
Depth = 1
```

Other similar packages include [Similitude.jl](https://github.com/chakravala/Similitude.jl), [MeasureSystems.jl](https://github.com/chakravala/MeasureSystems.jl), [PhysicalConstants.jl](https://github.com/JuliaPhysics/PhysicalConstants.jl), [MathPhysicalConstants.jl](https://github.com/LaGuer/MathPhysicalConstants.jl), [Unitful.jl](https://github.com/PainterQubits/Unitful.jl.git), [UnitfulUS.jl](https://github.com/PainterQubits/UnitfulUS.jl), [UnitfulAstro.jl](https://github.com/JuliaAstro/UnitfulAstro.jl), [UnitfulAtomic.jl](https://github.com/sostock/UnitfulAtomic.jl), [NaturallyUnitful.jl](https://github.com/MasonProtter/NaturallyUnitful.jl), and [UnitfulMoles.jl](https://github.com/rafaqz/UnitfulMoles.jl).
