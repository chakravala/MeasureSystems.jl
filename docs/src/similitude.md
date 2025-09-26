# Similitude

*Physical unit system constants (Metric, English, Natural, etc...)* [![PDF 2020-2025](https://img.shields.io/badge/PDF-2020--2025-blue.svg)](https://www.dropbox.com/sh/tphh6anw0qwija4/AAACiaXig5djrLVAKLPFmGV-a/Geometric-Algebra?preview=unitsystems.pdf)

```@contents
Pages = ["unitsystems.md","constants.md"]
Depth = 1
```
```@contents
Pages = ["similitude.md"]
```
```@contents
Pages = ["convert.md","units.md"]
Depth = 1
```

In 2019 the *SI2019* standardization was completed, based on the 7 physics dimensions specific to the *Metric* system.
That is actually an inadequate and insufficient unit system standard, as it is mathematically impossible to unify all historical units with that standard.
In 2020, *Michael Reed* set out to work around that impossibility with a new project called *UnitSystems.jl*, which ended up completely solving the problem with a brand new 11 dimensional *Unified System of Quantities* (USQ) for physics.

In aggregate, the `UnitSystem` data generated here constitutes a new universal standardization for dimensional analysis, which generalizes upon previous historical systems up to the 2019 redefinition and `Unified` in a common `Universe`.
This enables a more precise and generalized standardization than the 2019 redefinition, which was comparatively limited in scope. Specified default `UnitSystem` values are to be taken as a newly defined mutually-compatible recommended standard, verified to be consistent and coherent.
A `UnitSystem` can only be useful as a measuring standard if it can be scientifically reproduced, so the data here has been implemented in several important scientific programming languages (initially in the Julia language but also Wolfram language and Rust language) as well as presented abstractly in terms of dimensional formulas.

> In fact there is nothing transcendental about dimensions; the ultimate principle is precisely expressible (in Newton's terminology) as one of *similitude*, exact or approximate, to be tested by the rule that mere change in the magnitudes of the ordered scheme of units of measurement that is employed must not affect sensibly the forms of the equations that are the adequate expression of the underlying relations of the problem. (J.L., 1914)

Specifications for dimensional units are in the [UnitSystems.jl](https://github.com/chakravala/UnitSystems.jl) and [Similitude.jl](https://github.com/chakravala/Similitude.jl) and [MeasureSystems.jl](https://github.com/chakravala/MeasureSystems.jl) repositories.
The three packages are designed so that they can be interchanged with compatibility.
On its own `UnitSystems` is the fastest package, while `Similitude` (provides `Quantity` type) and `MeasureSystems` (introduces [Measurements.jl](https://github.com/JuliaPhysics/Measurements.jl) uncertainty) build additional features on top of `UnitSystems` base defintions.
Additionally, in the `UnitSystems` repository there is an equivalent Wolfram language paclet `Kernel` and also an unmaintained Rust `src` implementation.
Defaults are shared: `Metric`, `SI2019`, `CODATA`, `Conventional`, `International`, `InternationalMean`, `MetricTurn`, `MetricGradian`, `MetricDegree`, `MetricArcminute`, `MetricArcsecond`, `Engineering`, `Gravitational`, `FPS`, `IPS`, `British`, `English`, `Survey`, `Gauss`, `LorentzHeaviside`, `EMU`, `ESU`, `IAU`, `IAUE`, `IAUJ`, `Hubble`, `Cosmological`, `CosmologicalQuantum`, `Meridian`, `Nautical`, `MPH`, `KKH`, `MTS`, `FFF`, `Planck`, `PlanckGauss`, `Stoney`, `Hartree`, `Rydberg`, `Schrodinger`, `Electronic`, `Natural`, `NaturalGauss`, `QCD`, `QCDGauss`, `QCDoriginal`.

```@docs
UnitSystems.similitude
```

A `UnitSystem` is a consistent set of dimensional values selected to accomodate a particular use case standardization.
It is possible to convert derived physical quantities from any `UnitSystem` specification into any other using accurate values.
Eleven fundamental constants `kB`, `ħ`, `𝘤`, `μ₀`, `mₑ`, `Mᵤ`, `Kcd`, `ϕ`, `λ`, `αL`, `g₀` are used to govern a specific unit system consistent scaling.
These are the constants `boltzmann`, `planckreduced`, `lightspeed`, `vacuumpermeability`, `electronmass`, `molarmass`, `luminousefficacy`, `angle`, `rationalization`, `lorentz`, and `gravity`.
Different choices of natural units or physical measurements result in a variety of unit systems for many purposes.

```math
k_B, \quad \hbar, \quad c, \quad \mu_0, \quad m_e, \quad M_u, \quad K_{cd}, \quad \phi, \quad \lambda, \quad \alpha_L, \quad g_0
```

Historically, older electromagnetic unit systems also relied on a `rationalization` constant `λ` and a `lorentz` force proportionality constant `αL`.
In most unit systems these extra constants have a value of 1 unless specified.

```@docs
UnitSystems.UnitSystem
```

Specification of `Universe` with the dimensionless `Coupling` constants `coupling`, `finestructure`, `electronunit`, `protonunit`, `protonelectron`, and `darkenergydensity`.
Alterations to these values can be facilitated and quantified using parametric polymorphism.
Due to the `Coupling` interoperability, the `MeasureSystems` package is made possible to support calculations with `Measurements` having error standard deviations.

Similar packages [UnitSystems.jl](https://github.com/chakravala/UnitSystems.jl), [Similitude.jl](https://github.com/chakravala/Similitude.jl), [MeasureSystems.jl](https://github.com/chakravala/MeasureSystems.jl), [PhysicalConstants.jl](https://github.com/JuliaPhysics/PhysicalConstants.jl), [MathPhysicalConstants.jl](https://github.com/LaGuer/MathPhysicalConstants.jl), [Unitful.jl](https://github.com/PainterQubits/Unitful.jl.git), [UnitfulUS.jl](https://github.com/PainterQubits/UnitfulUS.jl), [UnitfulAstro.jl](https://github.com/JuliaAstro/UnitfulAstro.jl), [UnitfulAtomic.jl](https://github.com/sostock/UnitfulAtomic.jl), [NaturallyUnitful.jl](https://github.com/MasonProtter/NaturallyUnitful.jl), and [UnitfulMoles.jl](https://github.com/rafaqz/UnitfulMoles.jl).

## Unified System of Quantities (USQ)

In the base `UnitSystems` package, simply `Float64` numbers are used to generate the group of `UnitSystem` constants.
However, in the `Similitude` package, symbols are used to generate an abstract multiplicative `Group`, which is only converted to a `Float64` value where appropriate.

```@docs
MeasureSystems.FieldConstants.Constant
MeasureSystems.two
MeasureSystems.tau
```
Since Julia already exports a $\pi$ symbol as an `Irrational` type, `tau` and $\tau$ is used as exported `Group` element.
It's simply a matter of convenience to use an available symbol for the `Group` when `pi` is already defined by default, and is not an ideological statement about preferring $\tau=2\pi$ over $\pi$ itself.

Inclusion of the golden ratio $\varphi$ and Euler's $\gamma$ is unnecessary and not required for any `UnitSystem`, they are only included as a bonus since the Julia language offers 4 `Irrational` numbers by default.

Furthermore, in `Similitude` there is a dimension type which encodes the dimensional `Group{:USQ}` for the `Quantity` type.
This enables the `Unified` usage of `Group` homomorphisms to transform `Quantity` algebra elements with varying numbers of dimensionless constants.

Originally, the Newtonian group used for `UnitSystems` was derived from `force`, `mass`, `length`, `time` (or `F`, `M`, `L`, `T`).
Although `force` is typically thought of as a derived dimension when the reference `gravity` is taken to be dimensionless, `force` is actually must be considered a base dimension in general engineering `UnitSystem` foundations.
With further development of electricity and magnetism came an interest for an additional dimension called `charge` or `Q`.
When the thermodynamics of `entropy` became further developed, the `temperature` or `Θ` was introduced as another dimension.
In the field of chemistry, it became desirable to introduce another dimension of `molaramount` or `N` as fundamental.
To complete the existing International System of Quantities (ISQ) it is also necessary to consider `luminousflux` or `J` as a visual perception related dimension.
In order to resolve ambiguity with `solidangle` unit conversion, `angle` or `A` is explicitly tracked in the underlying `Group` algebra dimension.
However, this is yet insufficient to fully specify all the historical variations of `UnitSystem`, including the `EMU`, `ESU`, `Gauss` and `LorentzHeavise` specifications.
Therefore, there is also a dimension basis for `rationalization` (denoted `R`) and `lorentz` (denoted by `C⁻¹`).

In combination, all these required base dimension definitions are necessary in order to coherently implement unit conversion for `Quantity` elements.
Since the existing International System of Quantities (ISQ) is an insufficient definition for dimension, a new `Unified` System of Quantities (`USQ`) is being proposed here as composed of `force`, `mass`, `length`, `time`, `charge`, `temperature`, `molaramount`, `luminousflux`, `angle`, `rationalization`, and a `nonstandard` dimension (denoted by `F`, `M`, `L`, `T`, `Q`, `Θ`, `N`, `J`, `A`, `R`, `C`).

```@docs
Similitude.USQ
Quantity
Similitude.ConvertUnit
```

Converting a `Quantity` to another `UnitSystem` is enabled as function call, so any `Quantity` is a function returning its value in any `UnitSystem`
```julia
(myquantity::Quantity)(U::UnitSystem) # myquantity(U)
```
For example, to convert 1 Joule from `Metric` to `English`
```julia
julia> Metric(1,energy)(English)
g₀⁻¹ft⁻¹lb⁻¹ = 0.7375621492772653 [lbf⋅ft] English
```

The new `Unified` System of Quantities proposed here is a convenient way of specifying `UnitSystem` definitions.
As proposed by `Planck` (both a person and his proposed `UnitSystem`), specification of the dimensionless `boltzmann`, `planckreduced`, and `lightspeed` is of immense interest in the syntactic grammar of `UnitSystem` definitions.
In fact, it turns out that these are the `Natural` units of `entropy`, `angularmomentum` and `speed` induced by the `UnitSystem`.

For electromagnetism, there have been several proposed base definitions for extension.
Recently with the `SI2019` redefinition, it was proposed that `elementarycharge` is to be taken as a base definition for electromagnetic units.
This is a mistake, as `elementarycharge` is actually not the `Natural` unit of charge induced by the `UnitSystem`, therefore making it unsuitable as fundamental constant for any `UnitSystem`.
Meanwhile, `vacuumpermeability` exactly corresponds to the `Natural` unit of `permeability` induced by the `UnitSystem`, making it suitable as a base definition for the electromagnetic unit extension.

Much simpler to understand is that `electronmass` is the `Natural` unit of `mass` induced by the `UnitSystem`. Molecular chemistry units are then defined by the `Natural` unit of `molarmass` induced by the `UnitSytem` physics.
Specification of `luminousefficacy` is a `Natural` unit of human perception induced by the `UnitSystem`.
Altered `angle` scaling is defined by the `Natural` unit of `radian` induced by the `UnitSystem`.
Additionally, for the `Gauss` and `LorentzHeaviside` electromagnetic `UnitSystem` definitions, there is an induced `Natural` unit of `rationalization` and a `nonstandard` unit named `lorentz`. Finally, the `gravityforce` specifies the reference `Natural` unit of `gravity` induced by the `UnitSystem`.

Therefore, for the sake of `Natural` units, instead of defining a `UnitSystem` in terms of the `USQ` dimensions the following are used: `boltzmann`, `planckreduced`, `lightspeed`, `vacuumpermeability`, `electronmass`, `molarmass`, `luminousefficacy`, `angle`, `rationalization`, `lorentz`, `gravityforce` (or `entropy`, `angularmomentum`, `speed`, `permeability`, `mass`, `molarmass`, `luminousefficacy`, `angle`, `rationalization`, and the `nonstandard` one).
The isomorphism between the newly deefined Unified System of Quantities (USQ) and these 11 fundamental constants used for the new `UnitSystem` definition is what connects base dimensions with fundamental `Natural` units.

```@docs
Similitude.Unified
MeasureSystems.@unitgroup
Similitude.@unitdim
```

## Default UnitSystems

By default, this package provides a modern unified re-interpretation of various historical unit systems which were previously incompatible.
In order to make each `UnitSystem` consistently compatible with each other, a few convenience assumptions are made.
Specifically, it is assumed that all default modern unit systems must share the same common `Universe` of dimensionless constants, which can be modified optionally.
The fundamental philosophy is to fully characterize nuances among `UnitSystem` instances by means of dimensional constants.
As a result, all the defaults are ideal modern variants of these historical unit systems based on a common underlying `Universe`, which are completely consistent and compatible with each other.
These default `UnitSystem` values are to be taken as a newly defined mutually-compatible recommended standard, verified to be consistent and coherent.

```@index
Pages = ["unitsystems.md"]
```

## Metric SI Unit Systems

In the Systeme International d'Unites (the SI units) the `UnitSystem` constants are derived from the most accurate possible physical measurements and a few exactly defined constants.
Exact values are the `avogadro` number, `boltzmann` constant, `planck` constant, `lightspeed` definition, and elementary `charge` definition.

```math
N_A = 6.02214076\times10^{23}, \qquad k_B = 1.380649\times10^{-23},
```
```math
h = 6.62607015\times10^{-34}, \quad c = 299792458, \quad e = 1.602176634\times10^{-19}
```
```julia
julia> NA # avogadro
NA = 6.02214076 × 10²³

julia> kB # boltzmann
kB = 1.380649 × 10⁻²³

julia> 𝘩 # planck
𝘩 = 6.62607015 × 10⁻³⁴

julia> 𝘤 # lightspeed
𝘤 = 2.99792458 × 10⁸

julia> 𝘦 # charge
𝘦 = 1.602176634 × 10⁻¹⁹
```
Physical measured values with uncertainty are electron to proton mass ratio `μₑᵤ`, proton to atomic mass ratio `μₚᵤ`, inverted fine structure constant `αinv`, the Rydberg `R∞` constant, and the Planck mass `mP`.

```math
\mu_{eu} = \frac{m_e}{m_u}\approx\frac{1}{1822.9}, \quad \mu_{pu} = \frac{m_p}{m_u}\approx 1.00727647, \quad \alpha \approx \frac{1}{137.036},
```
```math
R_\infty \approx 1.097373\times10^7, \qquad m_P \approx 2.176434\times10^{-8},
```
```julia
julia> ħ # planckreduced
𝘩⋅τ⁻¹ = 1.0545718176461565×10⁻³⁴

julia> μ₀ # vacuumpermeability
𝘩⋅𝘤⁻¹𝘦⁻²α⋅2 = 1.25663706212(19) × 10⁻⁶

julia> mₑ # electronmass
𝘩⋅𝘤⁻¹R∞⋅α⁻²2 = 9.1093837016(28) × 10⁻³¹

julia> Mᵤ # molarmass
NA⋅𝘩⋅𝘤⁻¹R∞⋅α⁻²μₑᵤ⁻¹2 = 0.00099999999966(31)

julia> μₚₑ # protonelectron
μₑᵤ⁻¹μₚᵤ = 1836.15267343(11)
```

Additional reference values include the ground state `hyperfine` structure transition frequency of caesium-133 `ΔνCs` and `luminousefficacy` of monochromatic radiation `Kcd` of 540 THz.

```julia
julia> ΔνCs # hyperfine
ΔνCs = 9.19263177×10⁹

julia> Kcd # luminousefficacy
Kcd = 683.01969009009
```

As result, there are variants based on the original `molarmass` constant and Gaussian `permeability` along with the 2019 redefined exact values.
The main difference between the two is determined by $M_u$ and $\mu_0$ offset.

```math
(M_u,\mu_0,R_u,g_0,h,c,R_\infty,\alpha,\mu_{eu}) \quad \mapsto \qquad \qquad \qquad \qquad \qquad
```
```math
\quad \widetilde{m_e} = \frac{2R_\infty \widetilde h}{c\alpha^2}, \quad \widetilde{k_B} = \frac{R_u\widetilde{m_e}}{\mu_{eu}M_u}\frac{1}{g_0}, \quad \widetilde{K_{cd}} = 683 \frac{555.016}{555}\left(\frac{m_e}{\widetilde{m_e}}\right)^2\frac{\widetilde h}{h}g_0
```

Construction of `UnitSystem` instances based on specifying the the constants `molarmass`, the `vacuumpermeability`, and the `molargas` along with some other options is facilitated by `MetricSystem`.
This construction method helps characterize the differences between several derived unit systems.

```@docs
MeasureSystems.MetricSystem
```

The `ConventionalSystem` constructor then builds on `MetricSystem`.
Other derived `UnitSystem` instances such as `British` or `English` or `IAU` are derived from existing `Metric` specifications generated by `MetricSystem`.
The constructor `MetricSystem` incorporates several standard common numerical values and exposes variable arguments which can be substituted for customization, yielding the capability to generate historical variations having a common `Universe`.
Derivative constructors are `EntropySystem`, `ElectricSystem`, `GaussSystem`, `RankineSystem`, `AstronomicalSystem`.

Historically, the `josephson` and `klitzing` constants have been used to define `Conventional` (based on 1990) and `CODATA` (based on 2014) variants.

```math
(R_K,K_J,M_u,R_u,h,c,\alpha) \quad \mapsto \qquad \qquad \qquad \qquad \qquad \qquad
```
```math
\widetilde{\mu_0} = \frac{2R_K\alpha}{c}, \widetilde{h} = \frac{4}{R_KK_J^2}, \widetilde{m_e} = \frac{2R_\infty \widetilde h}{c\alpha^2}, \widetilde{k_B} = \frac{\widetilde{m_e} R_u}{\mu_{eu}M_u}, \widetilde{K_{cd}} = 683\frac{555.016\times 4}{555R_KK_J^2\widetilde h}
```

```@docs
MeasureSystems.ConventionalSystem
```

Originally, the "practical" units where specified by `resistance` and `electricpotential` with electrical calibration equipment.

```math
(\Omega, V), \quad \mapsto k_B\frac{\Omega}{V^2}, \quad h\frac{\Omega}{V^2}, \quad c\frac{1}{1}, \quad \mu_0\frac{\Omega}{V^2}, \quad m_e\frac{\Omega}{V^2}, \quad M_u\frac{\Omega}{V^2}, \quad K_{cd}\frac{V^2}{\Omega}
```

```@docs
UnitSystems.ElectricSystem
```

## Electromagnetic CGS Systems

Alternatives to the SI unit system are the centimetre-gram-second variants, where the constants are rescaled with `centi*meter` and `milli` kilogram units along with introduction of additional `rationalization` and `lorentz` constants or electromagnetic units.

```math
(\mu_0,\lambda,\alpha_L,t,l,m,g_0) \quad \mapsto \qquad \qquad \qquad \qquad \qquad
```
```math
k_B\frac{t^2}{ml^2g_0}, \quad h\frac{t}{ml^2g_0}, \quad c\frac{t}{l}, \quad \mu_0, \quad \frac{m_e}{m}, \quad \frac{M_u}{m}, \quad K_{cd}\frac{ml^2g_0}{t^3}, \quad \lambda, \quad \alpha_L
```

There are multiple choices of elctromagnetic units for these variants based on electromagnetic units, electrostatic units, Gaussian non-rationalized units, and Lorentz-Heaviside rationalized units.

```@docs
UnitSystems.GaussSystem
```

## Modified (Entropy) Unit Systems

Most other un-natural unit systems are derived from the construction above by rescaling `time`, `length`, `mass`, `temperature`, and `gravity`; which results in modified entropy constants:

```math
(t,l,m,T,g_0) \quad \mapsto \qquad \qquad \qquad \qquad \qquad \qquad
```
```math
k_B\frac{t^2T}{ml^2g_0}, \quad h\frac{t}{ml^2g_0}, \quad c\frac{t}{l}, \quad \mu_0\frac{1}{mlg_0}, \quad m_e\frac{1}{m}, \quad M_u\frac{1}{m}, \quad K_{cd}\frac{ml^2g_0}{t^3}
```

```@docs
UnitSystems.EntropySystem
```

Examples of this type include `Nautical`, `Meridian`, `Gravitational`, `MTS`, `KKH`, `MPH`, `IAU`, `IAUE`, `IAUJ`, `Hubble`, `Cosmological`, `CosmologicalQuantum`.
Most other constructors for `UnitSystem` derivations are based on internally calling `EntropySystem`, such as `AstronomicalSystem`, `ElectricSystem`, `GaussSystem`, and `RankineSystem`.
This means that `EntropySystem` also constructs the examples listed for those constructors.


## Foot-Pound-Second-Rankine

In Britain and the United States an `English` system of engineering units was commonly used with $T=5/9$ for Rankine scaling of modified `entropy`.

```math
(t,l,m,g_0) \quad \text{where }t=1 \quad \mapsto \qquad \qquad \qquad \qquad \qquad
```
```math
k_B\frac59\frac{t^2}{ml^2g_0}, \quad h\frac{t}{ml^2g_0}, \quad c\frac{t}{l}, \quad \mu_0\frac{1}{mlg_0}, \quad m_e\frac{1}{m}, \quad M_u10^3, \quad K_{cd}\frac{ml^2g_0}{t^3}
```

```@docs
MeasureSystems.RankineSystem
```

## Astronomical Unit Systems

The International Astronomical Union (IAU) units are based on the solar mass, distance from the sun to the earth, and the length of a terrestrial day.

```@docs
UnitSystems.AstronomicalSystem
```

## Natural Unit Systems

With the introduction of the `planckmass` a set of natural atomic unit systems can be derived in terms of the gravitational coupling constant.

```math
\alpha_G = \left(\frac{m_e}{m_P}\right)^2, \quad \widetilde{k_B} = 1, \quad (\widetilde{M_u} = 1, \quad \widetilde\lambda = 1, \quad \widetilde{\alpha_L} = 1)
```

```julia
julia> αG # (mₑ/mP)^2
𝘩²𝘤⁻²R∞²α⁻⁴mP⁻²2² = 1.751810(39)×10⁻⁴⁵
```

Some of the notable variants include

```julia
Planck       ::UnitSystem{1,1,1,1,√(4π*αG)}
PlanckGauss  ::UnitSystem{1,1,1,4π,√αG}
Stoney       ::UnitSystem{1,1/α,1,4π,√(αG/α)}
Hartree      ::UnitSystem{1,1,1/α,4π*α^2,1}
Rydberg      ::UnitSystem{1,1,2/,π*α^2,1/2}
Schrodinger  ::UnitSystem{1,1,1/α,4π*α^2,√(αG/α)}
Electronic   ::UnitSystem{1,1/α,1,4π,1}
Natural      ::UnitSystem{1,1,1,1,1}
NaturalGauss ::UnitSystem{1,1,1,4π,1}
QCD          ::UnitSystem{1,1,1,1,1/μₚₑ}
QCDGauss     ::UnitSystem{1,1,1,4π,1/μₚₑ}
QCDoriginal  ::UnitSystem{1,1,1,4π*α,1/μₚₑ}
```

The following is a new set of formulas for fundamental physics constants: [![PDF 2020-2025](https://img.shields.io/badge/PDF-2020--2025-blue.svg)](https://www.dropbox.com/sh/tphh6anw0qwija4/AAACiaXig5djrLVAKLPFmGV-a/Geometric-Algebra?preview=unitsystems.pdf)

```math
\alpha = \frac{\lambda e^2}{4\pi\varepsilon_0\hbar c} = 
\frac{\lambda c\mu_0 (e\alpha_L)^2}{4\pi\hbar} = 
\frac{e^2k_e}{\hbar c} = 
\frac{\lambda e^2}{2\mu_0ch} = 
\frac{\lambda c\mu_0\alpha_L^2}{2R_K} = 
\frac{e^2Z_0}{2h}
```
```math
\mu_{eu} = \frac{m_e}{m_u}, \qquad
\mu_{pu} = \frac{m_p}{m_u}, \qquad
\mu_{pe} = \frac{m_p}{m_e}, \qquad
\alpha_\text{inv} = \frac{1}{\alpha}, \qquad
\alpha_G = \left(\frac{m_e}{m_P}\right)^2
```

There exists a deep relationship between the fundamental constants, which also makes them very suitable as a basis for `UnitSystem` dimensional analysis.
All of the formulas on this page are part of the `Test` suite to [guarantee](https://github.com/chakravala/UnitSystems.jl/blob/master/test/runtests.jl) their universal correctness.

`lightspeed`: Speed of light in a vacuum $c$ for massless particles ($LT^{-1}$)
```math
c = \frac1{\alpha_L\sqrt{\mu_0\varepsilon_0}} = \frac{1}{\alpha}\sqrt{E_h\frac{g_0}{m_e}} = \frac{g_0\hbar\alpha}{m_e r_e}  = \frac{e^2k_e}{\hbar\alpha} = \frac{m_e^2G}{\hbar\alpha_G}
```

`planck`: Planck constant $h$ is energy per electromagnetic frequency ($FLT$)
```math
h = 2\pi\hbar = \frac{2e\alpha_L}{K_J} = \frac{8\alpha}{\lambda c\mu_0K_J^2} = \frac{4\alpha_L^2}{K_J^2R_K}
```

`planckreduced`: Reduced Planck constant $\hbar$ is Planck per radian ($FLTA^{-1}$)
```math
\hbar = \frac{h}{2\pi} = \frac{e\alpha_L}{\pi K_J} = \frac{4\alpha}{\pi\lambda c\mu_0K_J^2} = \frac{2\alpha_L}{\pi K_J^2R_K}
```

`planckmass`: Planck mass factor `mP` from gravitational coupling `αG` ($M$)
```math
m_P = \sqrt{\frac{\hbar c}{G}} = \frac1k\sqrt{\hbar c\frac{m_\odot}{\text{au}^3}} =\frac{m_e}{\sqrt{\alpha_G}} = \frac{2R_\infty hg_0}{c\alpha^2\sqrt{\alpha_G}}
```

`gaussgravitation`: Gauss gravitational constant $k$ of Newton's law ($T^{-1}A$)
```math
k = \frac{1}{m_P}\sqrt{\hbar c\frac{m_\odot}{\text{au}^3}} = \frac{1}{m_e}\sqrt{\hbar c\alpha_G\frac{m_\odot}{\text{au}^3}}
= \sqrt{G\frac{m_\odot}{\text{au}^3}}
= c^2\sqrt{\frac{\kappa m_\odot}{8\pi\text{au}^3}}
```

`gravitation`: Universal gravitation constant $G$ of Newton's law ($FM^{-2}L^2$)
```math
G = k^2\frac{\text{au}^3}{m_\odot} = \frac{\hbar c}{m_P^2} = \frac{\hbar c\alpha_G}{m_e^2} = \frac{c^3\alpha^4\alpha_G}{8\pi g_0^2 R_\infty^2 h} = \frac{\kappa c^4}{8\pi}
```

`einstein`: Einstein's gravitation constant of field equations ($FM^{-2}L^{-2}T^4$)
```math
\kappa = \frac{8\pi G}{c^4} = \frac{8\pi k^2\text{au}^3}{c^4m_\odot} = \frac{8\pi\hbar}{c^3m_P^2} = \frac{8\pi\hbar\alpha_G}{c^3m_e^2} = \frac{\alpha^4\alpha_G}{g_0^2R_\infty^2 h c}
```

## Atomic & Nuclear Constants

`dalton`: Atomic mass unit `Da` of $\frac{1}{12}$ of the $C_{12}$ carbon-12 atom's mass ($M$)
```math
m_u = \frac{M_u}{N_A} = \frac{m_e}{\mu_{eu}} = \frac{m_p}{\mu_{pu}} = \frac{2R_\infty hg_0}{\mu_{eu}c\alpha^2} = \frac{m_P}{\mu_{eu}}\sqrt{\alpha_G}
```

`protonmass`: Proton mass `mₚ` of particle with $+e$ elementary charge ($M$)
```math
m_p = \mu_{pu} m_u = \mu_{pu}\frac{M_u}{N_A} = \mu_{pe}m_e = \mu_{pe}\frac{2R_\infty hg_0}{c\alpha^2} = m_P\mu_{pe}\sqrt{\alpha_G}
```

`electronmass`: Electron rest mass `mₑ` of particle with $-e$ charge ($M$).
```math
m_e = \mu_{eu}m_u = \mu_{eu}\frac{M_u}{N_A} = \frac{m_p}{\mu_{pe}} = \frac{2R_\infty h g_0}{c\alpha^2} = m_P\sqrt{\alpha_G}
```

`hartree`: Electric potential energy `Eₕ` of ground state hydrogen atom ($FL$)
```math
E_h = \frac{m_e}{g_0}(c\alpha)^2 = \frac{\hbar c\alpha}{a_0} = \frac{g_0\hbar^2}{m_ea_0^2} = 2R_\infty hc = \frac{m_P}{g_0}\sqrt{\alpha_G}(c\alpha)^2
```

`rydberg`: Rydberg constant `R∞` is lowest energy photon capable of ionizing atom at ground state and is the most precise known measurement ($L^{-1}$)
```math
R_\infty = \frac{E_h}{2hc} = \frac{m_e c\alpha^2}{2hg_0} = \frac{\alpha}{4\pi a_0} = \frac{m_e r_e c}{2ha_0g_0} = \frac{\alpha^2m_ec}{4\pi\hbar g_0}  = \frac{m_Pc\alpha^2\sqrt{\alpha_G}}{2hg_0}
```

`bohr`: Bohr radius of the hydrogen atom in its ground state `a₀` ($LA^{-1}$)
```math
a_0 = \frac{g_0\hbar}{m_ec\alpha} = \frac{g_0\hbar^2}{k_e m_ee^2} = \frac{r_e}{\alpha^2} = \frac{\alpha}{4\pi R_\infty}
```

`electronradius`: Classic Lorentz radius or Thomson scatter length ($LA^{-1}$)
```math
r_e = g_0\frac{\hbar\alpha}{m_ec} = \alpha^2a_0 = g_0\frac{e^2 k_e}{m_ec^2} = \frac{2hR_\infty g_0a_0}{m_ec} = \frac{\alpha^3}{4\pi R_\infty}
```

`hyperfine`: Ground transition frequency `ΔνCs` of caesium-133 atom ($T^{-1}$)
```math
\Delta\nu_{\text{Cs}} = \Delta\tilde\nu_{\text{Cs}}c = \frac{\Delta\omega_{\text{Cs}}}{2\pi}  = \frac{c}{\Delta\lambda_{\text{Cs}}} = \frac{\Delta E_{\text{Cs}}}{h}
```

## Thermodynamic Constants

`molarmass`: Molar mass `Mᵤ` is ratio of `molarmass` and relative mass ($MN^{-1}$)
```math
M_u = m_uN_A = N_A\frac{m_e}{\mu_{eu}} = N_A\frac{m_p}{\mu_{pu}} = N_A\frac{2R_\infty hg_0}{\mu_{eu}c\alpha^2}
```

`avogadro`: `NA` is `molarmass(x)/dalton(x)` atom count in 12g of $C_{12}$ ($N^{-1}$)
```math
N_A = \frac{R_u}{k_B} = \frac{M_u}{m_u} = M_u\frac{\mu_{eu}}{m_e} = M_u\frac{\mu_{eu}c\alpha^2}{2R_\infty h g_0}
```

`boltzmann`: `kB` is `entropy` of a unit count microstate permutation ($FL\Theta^{-1}$)
```math
k_B = \frac{R_u}{N_A} = m_u\frac{R_u}{M_u} = \frac{m_e R_u}{\mu_{eu}M_u} = \frac{2R_uR_\infty h g_0}{M_u \mu_{eu}c\alpha^2}
```

`molargas`: Universal gas `Rᵤ` factors `gasconstant*molarmass` ($FL\Theta^{-1}N^{-1}$)
```math
R_u = k_B N_A = k_B\frac{M_u}{m_u} = k_BM_u\frac{\mu_{eu}}{m_e} = k_BM_u\frac{\mu_{eu}c\alpha^2}{2hR_\infty g_0}
```

`loschmidt`: Molecule count (number density) of unit vol. ideal gas ($L^{-3}$)
```math
\frac{p_0}{k_B T_0} = \frac{N_Ap_0}{R_uT_0} = \frac{\mu_{eu}M_up_0}{m_e R_u T_0} = \frac{M_u \mu_{eu}c\alpha^2p_0}{2R_uR_\infty hg_0 T_0}
```

`sackurtetrode`: Ideal gas entropy density for `P`, `T`, atomic mass `m` (**1**).
```math
\frac{S_0}{R_u} = \log\left(\frac{\hbar^3}{p_0}\sqrt{\left(\frac{m_u}{2\pi g_0}\right)^3 \left(k_BT_0\right)^5}\right)+\frac{5}{2} = \log\left(\frac{m_u^4}{p_0}\left(\frac{\hbar}{\sqrt{2\pi g_0}}\right)^3\sqrt{\frac{R_uT_0}{M_u}}^5\right)+\frac{5}{2}
```

`mechanicalheat`: Heat to raise 1 `mass` unit of water by 1 `temperature` unit, 
kB⋅NA⋅Ωᵢₜ⋅Vᵢₜ⁻²2⁻²3⁻²5⁻¹43 = 1.9859050081929637
`mechanicalheat` per `molaramount` per `temperature` units to define (steam) calorie ($FL$)
```math
\frac{180 R_uV_{it}^2}{43 k_BN_A\Omega_{it}} = 
\frac{180 k_BM_uV_{it}^2}{43 R_um_u\Omega_{it}} = 
\frac{90 k_BM_u\mu_{eu}c\alpha^2V_{it}^2}{43 hg_0R_uR_\infty\Omega_{it}}
```

`stefan`: Stefan-Boltzmann unit $\sigma$ of black body radiation ($FL^{-1}T^{-1}\Theta^{-4}$)
```math
\sigma = \frac{2\pi^5 k_B^4}{15h^3c^2} = \frac{\pi^2 k_B^4}{60\hbar^3c^2} = \frac{32\pi^5 h}{15c^6\alpha^8} \left(\frac{g_0R_uR_\infty}{\mu_{eu}M_u}\right)^4
```

`radiationdensity`: Raditation density of black body radiation ($FL^{-2}\Theta^{-4}$)
```math
a = 4\frac{\sigma}{c} = \frac{8\pi^5 k_B^4}{15h^3c^3} = \frac{\pi^2 k_B^4}{15\hbar^3c^3} = \frac{2^7\pi^5 h}{15c^7\alpha^8} \left(\frac{g_0R_uR_\infty}{\mu_{eu}M_u}\right)^4
```

`wienwavelength`: Displacement law based on Lambert $W_0$ evaluation ($L\Theta$)
```math
b = \frac{hc/k_B}{5+W_0(-5 e^{-5})} = \frac{hcM_u/(m_uR_u)}{5+W_0(-5 e^{-5})} = \frac{M_u \mu_{eu}c^2\alpha^2/(2R_uR_\infty g_0)}{5+W_0(-5 e^{-5})}
```

`wienfrequency`: Radiation law based on Lambert $W_0$ evaluation ($T^{-1}\Theta^{-1}$)
```math
\frac{3+W_0(-3 e^{-3})}{h/k_B} = \frac{3+W_0(-3 e^{-3})}{hM_u/(m_uR_u)} = \frac{3+W_0(-3 e^{-3})}{M_u \mu_{eu}c\alpha^2/(2R_uR_\infty g_0)}
```

`luminousefficacy`: Monochromatic radiation `Kcd` of 540 THz ($F^{-1}L^{-1}TJ$)
```math
K_{\text{cd}} = \frac{I_v}{\int_0^\infty \bar{y}(\lambda)\cdot\frac{dI_e}{d\lambda}d\lambda}, \qquad
\bar{y}\left(\frac{c}{540\times 10^{12}}\right)\cdot I_e = 1
```

## Electromagnetic Constants

`rationalization`: Constant of magnetization and polarization density ($R$)
```math
\lambda = \frac{4\pi\alpha_B}{\mu_0\alpha_L} = 4\pi k_e\varepsilon_0 = Z_0\varepsilon_0c
```

`lorentz`: Electromagnetic proportionality `αL` for Lorentz's law force ($C^{-1}$)
```math
\alpha_L = \frac{1}{c\sqrt{\mu_0\varepsilon_0}} = \frac{\alpha_B}{\mu_0\varepsilon_0k_e} = \frac{4\pi \alpha_B}{\lambda\mu_0} = \frac{k_m}{\alpha_B}
```

`biotsavart`: Magnetostatic proportion `αB` for Biot-Savart's law ($FT^2Q^{-2}C$)
```math
\alpha_B = \mu_0\alpha_L\frac{\lambda}{4\pi} = \alpha_L\mu_0\varepsilon_0k_e = \frac{k_m}{\alpha_L} = \frac{k_e}{c}\sqrt{\mu_0\varepsilon_0}
```

`vacuumpermeability`: Magnetic permeability of vacuum ($FT^2Q^{-2}R^{-1}C^2$)
```math
\mu_0 = \frac{1}{\varepsilon_0 (c\alpha_L)^2} = \frac{4\pi k_e}{\lambda (c\alpha_L)^2} = \frac{2h\alpha}{\lambda c(e\alpha_L)^2} = \frac{2R_K\alpha}{\lambda c\alpha_L^2}
```

`vacuumpermittivity`: Dielectric permittivity of vacuum ($F^{-1}L^{-2}Q^2R$)
```math
\varepsilon_0 = \frac{1}{\mu_0(c\alpha_L)^2} = \frac{\lambda}{4\pi k_e} = \frac{\lambda e^2}{2\alpha hc} = \frac{\lambda}{2R_K\alpha c}
```

`vacuumimpedance`: Free space `Z₀` ratio of electric-magnetic field ($FLTQ^{-2}$)
```math
Z_0 = \mu_0\lambda c\alpha_L^2 = \frac{\lambda}{\varepsilon_0 c} = \lambda\alpha_L\sqrt{\frac{\mu_0}{\varepsilon_0}} = \frac{2h\alpha}{e^2} = 2R_K\alpha
```

`electrostatic`: Electrostatic scalar `kₑ` for Coulomb's law force ($FL^2Q^{-2}$)
```math
k_e = \frac{\lambda}{4\pi\varepsilon_0} = \frac{\mu_0\lambda (c\alpha_L)^2}{4\pi} = \frac{\alpha \hbar c}{e^2} = \frac{R_K\alpha c}{2\pi} = \frac{\alpha_B}{\alpha_L\mu_0\varepsilon_0} = k_mc^2
```

`magnetostatic`: Magnetic proportion `kₘ` for Ampere's law force ($FT^2Q^{-2}$)
```math
k_m = \alpha_L\alpha_B = \mu_0\alpha_L^2\frac{\lambda}{4\pi} = \frac{k_e}{c^2} = \frac{\alpha \hbar}{ce^2} = \frac{R_K\alpha}{2\pi c}
```

`elementarycharge`: Quantized elementary charge $e$ of proton/electron ($Q$)
```math
e = \sqrt{\frac{2h\alpha}{Z_0}} = \frac{2\alpha_L}{K_JR_K} = \sqrt{\frac{h}{R_K}} = \frac{hK_J}{2\alpha_L} = \frac{F}{N_A}
```

`faraday`: Charge per electron mole $\mathfrak F$ based on elementary charge ($QN^{-1}$)
```math
F = eN_A = N_A\sqrt{\frac{2h\alpha}{Z_0}} = \frac{2N_A\alpha_L}{K_JR_K} = N_A\sqrt{\frac{h}{R_K}} = \frac{hK_JN_A}{2\alpha_L}
```

`conductancequantum`: quantized electric conductance unit ($F^{-1}L^{-1}T^{-1}Q^2$)
```math
G_0 = \frac{2e^2}{h} = \frac{4\alpha}{Z_0} = \frac{2}{R_K} = \frac{hK_J^2}{2\alpha_L^2} = \frac{2F^2}{hN_A^2}
```

`klitzing`: Quantized Hall resistance `RK` ($FLTQ^{-2}$)
```math
R_K = \frac{h}{e^2} = \frac{Z_0}{2\alpha} = \frac{2}{G_0} = \frac{4\alpha_L^2}{hK_J^2} = h\frac{N_A^2}{F^2}
```

`josephson`: potential difference to irradiation frequency ($F^{-1}L^{-1}T^{-1}QC^{-1}$)
```math
K_J = \frac{2e\alpha_L}{h} = \alpha_L\sqrt{\frac{8\alpha}{hZ_0}} = \alpha_L\sqrt{\frac{4}{hR_K}} = \frac{1}{\Phi_0} = \frac{2F\alpha_L}{hN_A}
```

`magneticfluxquantum`:  Magnetic flux quantum $\Phi_0$ ($FLTQ^{-1}C$)
```math
\Phi_0 = \frac{h}{2e\alpha_L} = \frac{1}{\alpha_L}\sqrt{\frac{hZ_0}{8\alpha}} = \frac{1}{\alpha_L}\sqrt{\frac{hR_K}{4}} = \frac{1}{K_J} = \frac{hN_A}{2F\alpha_L}
```

`magneton`: Bohr's electron magnetic moment unit ($FM^{-1}LTQA^{-1}C^{-1}$)
```math
\mu_B = \frac{e\hbar\alpha_L}{2m_e} = \frac{\hbar\alpha_L^2}{m_eK_JR_K} = \frac{h^2K_J}{8\pi m_e} = \frac{\alpha_L\hbar F}{2m_e N_A} = \frac{ec\alpha^2\alpha_L}{8\pi g_0R_\infty}
```

[Astronomical Constants](https://units.crucialflow.com/constants/#Astronomical-Constants)

[Dimensionless Coupling Constants](https://units.crucialflow.com/constants/#MeasureSystems.Universe)

# UnitSystems.jl and the Unified System of Quantities

The 11 dimensional operators necessary for standardizing the *Unified System of Quantities* have never been discussed/researched until the *UnitSystems.jl* project specified them to completely unify all historical unit systems.

The *only* person who can be fully credited for the discovery of these new 11 dimensional operators for the *Unified System of Quantities* (USQ) is *Michael Reed*, the researcher who was the first in history to investigate these operators to unify all historical unit systems to standardize the specification.

Discovering the fact that 11 dimensions are necessary and what the actual representation of the operators are is an extremely difficult task, requiring extensive knowledge of all the historical unit systems specified in *UnitSystems.jl*.
Since the discovery has been made, any other future application of these 11 dimensional operators is an application of *Michael Reed*'s *Unified System of Quantities* (USQ).
Not only are the new 11 dimensional operators necessary for complete unification, it's also necessary to extend the fundamental formuals involving the fundamental constants of physics, which has been presented in terms of an 11 dimensional physics system as part of this project for the first time in history.
This includes relations necessary for Maxwell's equations, chemistry, and thermodynamics based on the new 11 dimensional physics system.

Let $U$ be unit systems with its corresponding 11 dimensional physics operator representation $\rho$.
Two units $A,B$ are equivalent physics dimensions in `U::UnitSystem` if and only if $U(A)=U(B)$ when $U$ is applied on $A,B$ as an 11 dimensional physics operator and representation $\rho(U)$ has a nullspace.
This leads to the creation of an equivalence relation $\sim$ on $U$ which can be denoted with $A\sim B$, forming the equivalence classes $U/$$\sim$.
In package *Similitude.jl*, the convenient syntax `U/~` computes these equivalence classes.

Maxwell unit is $[\text{Mx}]$ and equivalent to `charge` $[Q]$, `electricflux` $[FL^{2}Q^{-1}]$, `magneticflux` $[FLTQ^{-1}C]$, or `polestrength` $[LT^{-1}QA^{-1}C^{-1}]$ in `Gauss`:
```julia
julia> Gauss(charge)
M¹ᐟ²L³ᐟ²T⁻¹

julia> Gauss(electricflux)
M¹ᐟ²L³ᐟ²T⁻¹

julia> Gauss(magneticflux)
M¹ᐟ²L³ᐟ²T⁻¹

julia> Gauss(polestrength)
M¹ᐟ²L³ᐟ²T⁻¹
```
However, in the `Metric` system none are equivalent:
```julia
julia> Metric(charge)
Q

julia> Metric(electricflux)
ML³T⁻²Q⁻¹

julia> Metric(magneticflux)
ML²T⁻¹Q⁻¹

julia> Metric(polestrength)
LT⁻¹Q
```
Now try out `Gauss/~` and `Metric/~` for all standardized equivalence classes.

In particular, the reason why it is mathematically impossible to create a mathametically consistent `UnitSystem` with only 7 physics dimensions (as in the `SI2019` standard) is because these 7 dimensions are only a subspace of the full 11 dimensions necessary.
The impossibility problem comes from the fact that there is a 4 dimensional nullspace in operator representation for this `Metric` system.
To work around this core issue, in the `UnitSystems` standard with *Michael Reed*'s *Unified System of Quantities* (USQ) the core problem is solved by always relying un an underlying 11 dimensional physics representation, which has enough dimensions to characterize the relative nullspace of all the historical unit systems.
Figuring out this 11 dimensional physics space required extensive research and development to discover the fundamental relations which maintain the correct physics constants under all historical unit systems.
This problem was entirely solved and documented in public for the first time in history by *Michael Reed* in this project.

The eleven dimensional operator corresponding to the `Unified` system is isomorphism of any `UnitSystem` with the *Unified System of Quantities* USQ

| Unified | F | M | L | T | Q | $\Theta$ | N | J | A | R | C |
| :---: | :---: | :---: | :---: | :--: | :---: | :---: | :---: | :---: | :---: | :---: | :---:|
| $\text{k}_\text{B}$ | 0 | 0 | 0 | 0 | 0 | -1 | 0 | 0 | 0 | 0 | 0 |
| $\hbar$ | -1 | 0 | 1 | 1 | 1/2 | 0 | 0 | -1 | 0 | 0 | 0 |
| $\text{c}$ | 3 | 0 | -1 | -2 | -1/2 | 2 | 0 | 4 | 0 | 0 | 0 |
| $\mu_0$ | 0 | 0 | 0 | 0 | -1/2 | 0 | 0 | 0 | 0 | 0 | 0 |
| $\text{m}_\text{e}$ | 2 | 1 | -1 | -1 | 0 | 1 | 1 | 2 | 0 | 0 | 0 |
| $\text{M}_\text{u}$ | 0 | 0 | 0 | 0 | 0 | 0 | -1 | 0 | 0 | 0 | 0 |
| $\text{K}_{cd}$ | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 |
| $\phi$ | -1 | 0 | 1 | 1 | 1/2 | 0 | 0 | -1 | 1 | 0 | 0 |
| $\lambda$ | 0 | 0 | 0 | 0 | -1/2 | 0 | 0 | 0 | 0 | 1 | 0 |
| $\alpha_\text{L}$ | 0 | 0 | 0 | 0 | -1 | 0 | 0 | 0 | 0 | 0 | -1 |
| $\text{g}_0$ | -2 | 0 | 1 | 1 | 0 | -1 | 0 | -2 | 0 | 0 | 0 |

Any other project relying on these 11 dimensional fundamental constants of physics from the *Unified System of Quantities* (USQ) is then essentially referencing *Michael Reed*'s work, or in the case of Wolfram Research they are doing plagiarism, as explained in the Wolfram plagiarism timeline.

| Metric | $\text{N}$ | $\text{kg}$ | $\text{m}$ | $\text{s}$ | $\text{C}$ | $\text{K}$ | $\text{mol}$ | $\text{cd}$ | 1 | 1 | 1 |
| :---: | :---: | :---: | :---: | :--: | :---: | :---: | :---: | :---: | :---: | :---: | :---:|
| F | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| M |1 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| L | 1 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| T | -2 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Q | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 |
| $\Theta$ | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 |
| N | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 |
| J | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 |
| A | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| R | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| C | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |

| Engineering | $\text{kgf}$ | $\text{kg}$ | $\text{m}$ | $\text{s}$ | $\text{C}$ | $\text{K}$ | $\text{mol}$ | $\text{cd}$ | $\text{rad}$ | 1 | 1 |
| :---: | :---: | :---: | :---: | :--: | :---: | :---: | :---: | :---: | :---: | :---: | :---:|
| F | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| M | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| L | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| T | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Q | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 |
| $\Theta$ | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 |
| N | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 |
| J | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 |
| A | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 |
| R | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| C | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |

| Gravitational | $\text{kgf}$ | $\text{hyl}$ | $\text{m}$ | $\text{s}$ | $\text{C}$ | $\text{K}$ | $\text{mol}$ | $\text{cd}$ | 1 | 1 | 1 |
| :---: | :---: | :---: | :---: | :--: | :---: | :---: | :---: | :---: | :---: | :---: | :---:|
| F | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| M | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| L | 0 | -1 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| T | 0 | 2 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Q | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 |
| $\Theta$ | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 |
| N | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 |
| J | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 |
| A | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| R | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| C | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |

| Gauss | $\text{dyn}$ | $\text{g}$ | $\text{cm}$ | $\text{s}$ | $\text{Mx}$ | $\text{K}$ | $\text{mol}$ | $\text{cd}$ | 1 | 1 | $\text{cm}\cdot\text{s}^{-1}$ |
| :---: | :---: | :---: | :---: | :--: | :---: | :---: | :---: | :---: | :---: | :---: | :---:|
| F | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| M | 1 | 1 | 0 | 0 | 1/2 | 0 | 0 | 0 | 0 | 0 | 0 |
| L | 1 | 0 | 1 | 0 | 3/2 | 0 | 0 | 0 | 0 | 0 | 1 |
| T | -2 | 0 | 0 | 1 | -1 | 0 | 0 | 0 | 0 | 0 | -1 |
| Q | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| $\Theta$ | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 |
| N | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 |
| J | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 |
| A | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| R | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| C | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |

| EMU | $\text{dyn}$ | $\text{g}$ | $\text{cm}$ | $\text{s}$ | $\text{g}^{1/2}\text{cm}^{1/2}$ | $\text{K}$ | $\text{mol}$ | $\text{cd}$ | 1 | 1 | 1 |
| :---: | :---: | :---: | :---: | :--: | :---: | :---: | :---: | :---: | :---: | :---: | :---:|
| F | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| M | 1 | 1 | 0 | 0 | 1/2 | 0 | 0 | 0 | 0 | 0 | 0 |
| L | 1 | 0 | 1 | 0 | 1/2 | 0 | 0 | 0 | 0 | 0 | 0 |
| T | -2 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Q | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| $\Theta$ | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 |
| N | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 |
| J | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 |
| A | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| R | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| C | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |

| ESU | $\text{dyn}$ | $\text{g}$ | $\text{cm}$ | $\text{s}$ | $\text{g}^{1/2}\text{cm}^{3/2}\text{s}^{-1}$ | $\text{K}$ | $\text{mol}$ | $\text{cd}$ | 1 | 1 | 1 |
| :---: | :---: | :---: | :---: | :--: | :---: | :---: | :---: | :---: | :---: | :---: | :---:|
| F | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| M | 1 | 1 | 0 | 0 | 1/2 | 0 | 0 | 0 | 0 | 0 | 0 |
| L | 1 | 0 | 1 | 0 | 3/2 | 0 | 0 | 0 | 0 | 0 | 0 |
| T | -2 | 0 | 0 | 1 | -1 | 0 | 0 | 0 | 0 | 0 | 0 |
| Q | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| $\Theta$ | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 |
| N | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 |
| J | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 |
| A | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| R | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| C | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |

| Planck | $\text{M}^2$ | M | $\text{M}^{-1}$ | $\text{M}^{-1}$ | 1 | M | M | $\text{M}^2$ | 1 | 1 | 1 |
| :---: | :---: | :---: | :---: | :--: | :---: | :---: | :---: | :---: | :---: | :---: | :---:|
| F | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| M | 2 | 1 | -1 | -1 | 0 | 1 | 1 | 2 | 0 | 0 | 0 |
| L | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| T | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Q | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| $\Theta$ | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| N | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| J | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| A | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| R | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| C | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |


| PlanckGauss | $\text{m}_P^2$ | $\text{m}_P$ | $\text{m}_P^{-1}$ | $\text{m}_P^{-1}$ | $e_n$ | $\text{m}_P$ | $\text{m}_P$ | $\text{m}_P^2$ | 1 | 1 | 1 |
| :---: | :---: | :---: | :---: | :--: | :---: | :---: | :---: | :---: | :---: | :---: | :---:|
| F | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| M | 2 | 1 | -1 | -1 | 0 | 1 | 1 | 2 | 0 | 0 | 0 |
| L | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| T | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Q | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 |
| $\Theta$ | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| N | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| J | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| A | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| R | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| C | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |


Null operator `Natural` $= 0$ in its operator representation:

| Natural | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 |
| :---: | :---: | :---: | :---: | :--: | :---: | :---: | :---: | :---: | :---: | :---: | :---:|
| F | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| M | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| L | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| T | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Q | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| $\Theta$ | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| N | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| J | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| A | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| R | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| C | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |


| NaturalGauss | 1 | 1 | 1 | 1 | $e_n$ | 1 | 1 | 1 | 1 | 1 | 1 |
| :---: | :---: | :---: | :---: | :--: | :---: | :---: | :---: | :---: | :---: | :---: | :---:|
| F | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| M | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| L | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| T | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Q | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 |
| $\Theta$ | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| N | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| J | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| A | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| R | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| C | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |

| Hartree | $\text{a}_0^{-3}$ | 1 | $\text{a}_0$ | $\text{a}_0^2$ | $e$ | $\text{a}_0^{-2}$ | 1 | $\text{a}_0^{-4}$ | 1 | 1 | 1 |
| :---: | :---: | :---: | :---: | :--: | :---: | :---: | :---: | :---: | :---: | :---: | :---:|
| F | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| M | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| L | -3 | 0 | 1 | 2 | 0 | -2 | 0 | -4 | 0 | 0 | 0 |
| T | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Q | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 |
| $\Theta$ | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| N | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| J | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| A | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| R | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| C | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |

| QCDoriginal | $\text{m}_p^2$ | $\text{m}_p$ | $\text{m}_p^{-1}$ | $\text{m}_p^{-1}$ | $e$ | $\text{m}_p$ | $\text{m}_p$ | $\text{m}_p^2$ | 1 | 1 | 1 |
| :---: | :---: | :---: | :---: | :--: | :---: | :---: | :---: | :---: | :---: | :---: | :---:|
| F | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| M | 2 | 1 | -1 | -1 | 0 | 1 | 1 | 2 | 0 | 0 | 0 |
| L | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| T | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Q | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 |
| $\Theta$ | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| N | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| J | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| A | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| R | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| C | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |

| Rydberg | $\text{MLT}^{-2}$ | M | L | T | Q | $\text{T}^{-1}$ | M | $\text{T}^2$ | 1 | 1 | 1 |
| :---: | :---: | :---: | :---: | :--: | :---: | :---: | :---: | :---: | :---: | :---: | :---:|
| F | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| M | 1 | 1 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 |
| L | 1 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| T | -2 | 0 | 0 | 1 | 0 | -1 | 0 | 2 | 0 | 0 | 0 |
| Q | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 |
| $\Theta$ | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| N | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| J | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| A | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| R | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| C | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |

| Stoney | $\text{MT}^{-1}$ | M | T | T | Q | M | M | J | 1 | 1 | 1 |
| :---: | :---: | :---: | :---: | :--: | :---: | :---: | :---: | :---: | :---: | :---: | :---:|
| F | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| M | 1 | 1 | 0 | 0 | 0 | 1 | 1 | 0 | 0 | 0 | 0 |
| L | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| T | -1 | 0 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Q | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 |
| $\Theta$ | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| N | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| J | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 |
| A | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| R | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| C | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |

| Electronic | $\text{T}^{-1}$ | 1 | T | T | Q | 1 | 1 | $\text{T}^{-1}$ | 1 | 1 | 1 |
| :---: | :---: | :---: | :---: | :--: | :---: | :---: | :---: | :---: | :---: | :---: | :---:|
| F | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| M | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| L | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| T | -1 | 0 | 1 | 1 | 0 | 0 | 0 | -1 | 0 | 0 | 0 |
| Q | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 |
| $\Theta$ | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| N | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| J | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| A | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| R | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| C | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |


| Cosmological | $\text{MT}^{-1}$ | M | T | T | Q | M | M | J | 1 | 1 | 1 |
| :---: | :---: | :---: | :---: | :--: | :---: | :---: | :---: | :---: | :---: | :---: | :---:|
| F | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| M | 1 | 1 | 0 | 0 | 0 | 1 | 1 | 0 | 0 | 0 | 0 |
| L | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| T | -1 | 0 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Q | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 |
| $\Theta$ | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| N | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| J | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 |
| A | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| R | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| C | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |


| CosmologicalQuantum | $\text{M}^2$ | M | $\text{M}^{-1}$ | $\text{M}^{-1}$ | $\text{e}_n$ | M | M | $\text{M}^2$ | 1 | 1 | 1 |
| :---: | :---: | :---: | :---: | :--: | :---: | :---: | :---: | :---: | :---: | :---: | :---:|
| F | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| M | 2 | 1 | -1 | -1 | 0 | 1 | 1 | 2 | 0 | 0 | 0 |
| L | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| T | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Q | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 |
| $\Theta$ | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| N | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| J | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| A | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| R | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| C | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |

| MetricDegree | $\text{N}$ | $\text{kg}$ | $\text{m}$ | $\text{s}$ | $\text{C}$ | $\text{K}$ | $\text{mol}$ | $\text{cd}$ | $\text{deg}$ | 1 | 1 |
| :---: | :---: | :---: | :---: | :--: | :---: | :---: | :---: | :---: | :---: | :---: | :---:|
| F | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| M | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| L | 1 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| T | -2 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| Q | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 |
| $\Theta$ | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 |
| N | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 0 |
| J | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 | 0 |
| A | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 0 |
| R | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| C | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |

*Michael Reed*'s contribution to mathematical physics can be recognized as this new 11 dimensional operator formalism, enabling complete unification of all historical unit systems with the *Unified System of Quantities* (USQ).
In particular, the equivalence classes of physics dimensions in any historical `UnitSystem` are now fully characterized by the nullspace of the 11 dimensional physics operator representation, as it was first systematically researched and documented by this project, accessible with `U/~` syntax.

In particular, the "dimensionless" physics dimensions in any historical unit system are in the nullspace of such an operator representation.
These `Group` elements are considered "dimensionless" when operator representation is applied, but the underlying representation is in an 11 dimensional vector space which enables the unification of all historical unit systems.
The source of the problem is that these operators are not isomorphisms, which means that the nullspace is an unavoidable aspect to solve the problem.
The only way to work around this problem is to use this new formalism based on 11 dimensional physics pioneered by *Michael Reed*'s sytem.

This means that the `Natural` unit system appears to users to work with all dimensionless quantities, but here it uses a new underlying 11 dimensional vector space to enable unit conversion to any other historical unit system.
This problem is mathematically impossible to solve by formalism of 7 dimensional physics unit system standardized with SI2019, only with *Michael Reed*'s new contribution has this problem been solved completely.


One of the new unit systems created by *Michael Reed* is the modern ideal `Meridian` system defined by France's original `earthmeter` definition, with a corresponding `earthgram`, `earthcalorie`, and `earthcoulomb` units.

[Meridian UnitSystem](https://units.crucialflow.com/unitsystems/#MeasureSystems.Meridian)

## Wolfram plagiarism timeline

Timeline of *UnitSystems.jl* registration and *Wolfram Research* plagiarism:

- *2019*: The **SI2019** standard is formalized with a primitive SI only unit-system based on 7 physics dimensions (massive collaboration).
- *2020*: Registered **DOI 10.5281/zenodo.7145479**, **UnitSystems.jl**
- *2021*: Discused with *Ted Corcovilos* about what the unsolved and nuanced issues are with defining physics units, which I then solved by independently creating the never before seen 11 dimensional *Unified System of Quantities* (USQ) for physics, which was standardized in detail and completely handcrafted by myself alone.
- *2021*: Wolfram Research invited me to their Summer School, where everyone was hinting at the fact I would be hired there.
- *2022*: Wolfram Research interviewed and then hired me, with an explicit interest in my *UnitSystems.jl* work from lead developers. They requested that I present them my independently discovered *UnitSystems.jl* results in the Wolfram Language to make a comparison with their existing system. While I was shortly an employee at Wolfram, I indeed directly handed them my newly discovered Unified System of Quantities. My work was already independently complete and prepared ready to incorporate into their stack. They acknowledged that  their system was old and outdated compared to mine, as they only implemented a Metric and Imperial unit system, and neither of these was up to the standard of my *UnitSystems.jl* standard. However, they told me that I would not be allowed to work on this project further because they didn't want to upgrade their systems. Instead, they did the software equivalent of placing me in a backroom shed to mop the floors. After 6 months they ended the contract and it turned out they lied to me on the job application about what my role would be (they said I would be part of the core team with Jonathan Gorard, but this was a blatant lie).
- *2023-2025*: Wolfram keeps inviting me to their Winter/Summer schools to help mentor people, but I declined because I am too busy making progress in my research (why directly help mentor my competitors, who made it clear that they don't want to actually support my work); their use of social environments feels predatory.
- *2025*: Wolfram bribes Memes of Destruction at Wolfram Summer School to take my fully prepared work and use it to boost the Wolfram brand on social media, presenting my completed project with AI generated text as if it was Wolfram's idea, without crediting that I was the person who directly handed them the completed project years earlier (but without AI generated text they added).

Did Wolfam think that they can pluck low hanging fruits from my garden to build their brand on social media? My only goal here is to show that these low hanging fruit Wolfram plucked, these fruits came from my public garden and were not grown or developed by them from scratch, it's my solo-project.

Academic institutions should be direclty investing in my research instead of funding and enabling Wolfram Research to systematically gangstalk me with an army of employees.
I can feel the presence of Wolfram looking over my shoulder and monitoring my every step.
There seems to be an entire economy of people being paid to monitor and surveil me, while I struggle to survive with my resources.
Stephen Wolfram never seemed to care about earning my respect.
Every time I interacted with him, he was only focused on talking about himself and that was the only topic.

It's fascinating to me how unaware Stephen Wolfram is of the fact that people perceive him as textbook specimen of ultra-narcissism.
This is because he is entirely surrounded by people with a salary depending on how much they inflate Stephen Wolfram's ego, which completely divorces these people from the reality of doing actual scientific research.
Wolfram's premise seems to be that they can use gangstalking to target open source developers like me to data-mine our work, enabled by funding granted from academic institutions who don't check for Wolfram's plagiarism violations.

Combining the ultra-narcissism of Wolfram with the economic incentive to target open source developers with gangstalking by an army of employees, it becomes highly uncomfortable knowing that these people are incentivized to gangstalk me for the rest of my life with smear campaigns and so on.

I urge academic institutions to quit enabling and sponsoring Stephen Wolfram's systematic gangstalking of individuals like me. He shouldn't be rewarded for plucking fruit from my public gardens, which I handcrafted. % by myself. Wolfram's goal seems to be taking the fruit of my work in a cowardly and uncollaborative way.
Wolfram does not acknowledge that my science research is what's boosting their brand in the social media campaign funding Memes of Destruction.

Julia Computing are no better stewards, they are also unehtical people, but at least their product is open source and therefore a solid foundation.
My work on *UnitSystems.jl* and the entire process of creating the new 11 dimensional *Unified System of Quantities* (USQ) was all done entirely in public on GitHub and each release registered with several scientific websites.
This is only one of my side projects, the mainstream of my research is my differential geometric algebra software development, *Grassmann.jl* and *Cartan.jl*, and various related work at the cutting edge of science, making me a bigger target for Wolfram's gangstalking.
Wolfram is now constantly being observed in attempting to keep up with my research by systematically gangstalking me in a hush-hush way, not acknowledging me.
With shady business practices, I have to wonder what other fraud is being commited.

It appears that Wolfram tends to resort to plagiarism of other people's works by data mining other people's creativity through employment, ghostwriters, summer schools, shady business practices, identity theft, bribes.

The incentive behind this systematic gangstalking appears to be this: instead of working with me directly, they all wish to ostracize, isolate, and erase me.
Their eventual goal is replacing me and then retroactively claiming credit for my past achievements to boost their brands.
Ironically, the temptation (to incorrectly eat the fruit of my labor like this) will be their downfall, as this choice is accompanied by firm evidence of plagiarism.
Plagiarism is considered a violation of academic standards by the academic institutions funding Wolfram Research.
My projects are effectively ego-traps, which will trigger the downfall of an ultra-narcissit ego if incorrectly consumed.
I know the academic institutions don't acknowledge me either, so all I can do is to permanently add the Wolfram plagiarism disclaimer to the original sources.

Having a quick 0-60 speed in pathological lying is not necessarily a sign of high intelligence in long term thinking.
Rather, it's an indicator of a complete lack of long term thinking, demonstrating optimization toward the short term illusions of success, which falls apart upon any scrutiny.

If Wolfram does not want to be perceived as confirmed plagiarist, then Wolfram must acknowledge *Michael Reed* as the original creator of the new *Unified System of Quantities* (USQ), which is the underlying foundation for the completed research project I handed them (and they padded with AI generated text).
Wolfram is well known for the claims that LLMs will replace writing code and text, so we have to assume the foundations of their work rests in AI generated text, on top of my presented complete project foundation.
The LLMs and AI models all know about my *UnitSystems.jl* work and mine was the only reference work in existence which completed this type of work.
Therefore, if using AI or LLM generated text to manipulate my unique project, this is effectively transforming the original source data which was ingested from my work using my own knowledge embedded in the LLMs.
Wolfram is regurgitating the fruits of my labor without acknowledging that I directly handed this to them as a completed project.

Memes of Destruction self proclaims to not be an expert on the topic and publicly discloses the paid sponsorship from Wolfram for the social media campaign, at least this is some transparency.

*-- Michael Reed's audience reaction to Wolfram's plagiarism*

This preface was written in 2025, the *UnitSystems.jl* Appendix has been documented on my website and registered as Julia package since 2020.

Core *UnitSystems.jl}* standard was last updated in 2022, while *Similitude.jl* and *MeasureSystems.jl* have received minor software design updates since.

## UnitSystem Index

```@index
Pages = ["unitsystems.md"]
```
