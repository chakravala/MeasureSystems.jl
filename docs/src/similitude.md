# Similitude

*Physical unit system constants (Metric, English, Natural, etc...)*

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

## Multiplicative Group

In the base `UnitSystems` package, simply `Float64` numbers are used to generate the group of `UnitSystem` constants.
However, in the `Similitude` package, instead `Constant` numbers are used to generate an abstract multiplicative `Group`, which is only converted to a `Float64` value at compile time where appropriate.

```@docs
MeasureSystems.FieldConstants.Constant
MeasureSystems.two
MeasureSystems.tau
```

Furthermore, in `Similitude` there is a dimension type which encodes the dimensional `Group{:USQ}` for the `Quantity` type.
This enables the `Unified` usage of `Group` homomorphisms to transform `Quantity` algebra elements with varying numbers of dimensionless constants.

Originally, the Newtonian group used for `UnitSystems` would be made up of `force`, `mass`, `length`, `time` (or `F`, `M`, `L`, `T`).
Although `force` is typically thought of as a derived dimension when the reference `gravity` is taken to be dimensionless, `force` is actually considered a base dimension in general engineering `UnitSystem` foundations.
With the development of electricity and magnetism came an interest for an additional dimension called `charge` or `Q`.
When the thermodynamics of `entropy` became further developed, the `temperature` or `Θ` was introduced as another dimension.
In the field of chemistry, it became desirable to introduce another dimension of `molaramount` or `N` as fundamental.
To complete the existing International System of Quantities (ISQ) it is also necessary to consider `luminousflux` or `J` as a visual perception related dimension.
In order to resolve ambiguity with `solidangle` unit conversion, `angle` or `A` is explicitly tracked in the underlying dimension and `Group`.
However, this is yet insufficient to fully specify all the historical variations of `UnitSystem`, including the `EMU`, `ESU`, `Gauss` and `LorentzHeavise` specifications.
Therefore, there is also a dimension basis for `rationalization` (denoted `R`) and `lorentz` (denoted by `C⁻¹`).

In combination, all these required base dimension definitions are necessary in order to coherently implement unit conversion for `Quantity` elements.
Since the existing International System of Quantities (ISQ) is an insufficient definition for dimension, a new `Unified` System of Quantities (`USQ`) is being proposed here as composed of `force`, `mass`, `length`, `time`, `charge`, `temperature`, `molaramount`, `luminousflux`, `angle`, `rationalization`, and a `nonstandard` dimension (denoted by `F`, `M`, `L`, `T`, `Q`, `Θ`, `N`, `J`, `A`, `R`, `C`).

```@docs
Similitude.USQ
Quantity
Similitude.ConvertUnit
```

## Unified System of Quantities (USQ)

The new `Unified` System of Quantities proposed here is a convenient way of specifying `UnitSystem` definitions.
As proposed by `Planck` (both a person and his proposed `UnitSystem`), specification of the dimensionless `boltzmann`, `planckreduced`, and `lightspeed` is of immense interest in the syntactic grammar of `UnitSystem` definitions.
In fact, it turns out that these are the `Natural` units of `entropy`, `angularmomentum` and `speed` induced by the `UnitSystem`.

For electromagnetism, there have been several proposed base definitions for extension.
Recently with the `SI2019` redefinition, it was proposed that `elementarycharge` is to be taken as a base definition for electromagnetic units.
Yet, this is a mistake as `elementarycharge` is not the `Natural` unit of charge induced by the `UnitSystem`, making it unsuitable as fundamental `Constant` for any `UnitSystem`.
Meanwhile, `vacuumpermeability` exactly corresponds to the `Natural` unit of `permeability` induced by the `UnitSystem`, making it suitable as a base definition for the electromagnetic unit extension.

Much simpler to understand is that `electronmass` is the `Natural` unit of `mass` induced by the `UnitSystem`. Molecular chemistry units are then defined by the `Natural` unit of `molarmass` induced by the `UnitSytem`.
Specification of `luminousefficacy` is a `Natural` unit of human perception induced by the `UnitSystem`.
Altered `angle` scaling is defined by the `Natural` unit of `radian` induced by the `UnitSystem`.
Additionally, for the `Gauss` and `LorentzHeaviside` electromagnetic `UnitSystem` definitions, there is an induced `Natural` unit of `rationalization` and a `nonstandard` unit named `lorentz`. Finally, the `gravityforce` specifies the reference `Natural` unit of `gravity` induced by the `UnitSystem`.

Therefore, for the sake of `Natural` units, instead of defining a `UnitSystem` in terms of the `USQ` dimensions the following are used: `boltzmann`, `planckreduced`, `lightspeed`, `vacuumpermeability`, `electronmass`, `molarmass`, `luminousefficacy`, `angle`, `rationalization`, `lorentz`, `gravityforce` (or `entropy`, `angularmomentum`, `speed`, `permeability`, `mass`, `molarmass`, `luminousefficacy`, `angle`, `rationalization`, and the `nonstandard` one).

```@docs
Similitude.Unified
MeasureSystems.@unitgroup
Similitude.@unitdim
```

## Default UnitSystems

By default, this package provides a modern unified re-interpretation of various historical unit systems which were previously incompatible.
In order to make each `UnitSystem` consistently compatible with each other, a few convenience assumptions are made.
Specifically, it is assumed that all default modern unit systems share the same common `Universe` of dimensionless constants, although this can be optionally changed.
Therefore, the philosophy is to characterize differences among `UnitSystem` instances by means of dimensional constants.
As a result, all the defaults are ideal modern variants of these historical unit systems based on a common underlying `Universe`, which are completely consistent and compatible with each other.
These default `UnitSystem` values are to be taken as a newly defined mutually-compatible recommended standard, verified to be consistent and coherent.

```@index
Pages = ["unitsystems.md"]
```

## Metric SI Unit Systems

In the Systeme International d'Unites (the SI units) the `UnitSystem` constants are derived from the most accurate possible physical measurements and a few exactly defined constants.
Exact values are the `avogadro` number, `boltzmann` constant, `planck` constant, `lightspeed` definition, and elementary `charge` definition.

```math
N_A = 6.02214076e23, k_B = 1.380649e-23, h = 6.62607015e-34, c = 299792458, e = 1.602176634e-19
```
```julia
julia> NA # avogadro
NA = 6.02214076e23

julia> kB # boltzmann
kB = 1.380649e-23

julia> 𝘩 # planck
𝘩 = 6.62607015e-34

julia> 𝘤 # lightspeed
𝘤 = 2.99792458e8

julia> 𝘦 # charge
𝘦 = 1.602176634e-19
```
Physical measured values with uncertainty are electron to proton mass ratio `μₑᵤ`, proton to atomic mass ratio `μₚᵤ`, inverted fine structure constant `αinv`, the Rydberg `R∞` constant, and the Planck mass `mP`.

```math
\mu_{eu} = \frac{m_e}{m_u}\approx\frac{1}{1822.9}, \mu_{pu} = \frac{m_p}{m_u}\approx 1.00727647, \alpha \approx \frac{1}{137.036}, R_\infty \approx 1.097373e7, m_P \approx 2.176434e-8,
```
```julia
julia> ħ # planckreduced
𝘩*τ⁻¹ = 1.0545718176461565e-34

julia> μ₀ # vacuumpermeability
𝘩*𝘤⁻¹𝘦⁻²α*2 = 1.25663706212e-6 ± 1.9e-16

julia> mₑ # electronmass
𝘩*𝘤⁻¹R∞*α⁻²2 = 9.1093837016e-31 ± 2.8e-40

julia> Mᵤ # molarmass
𝘩*𝘤⁻¹NA*R∞*α⁻²μₑᵤ⁻¹2 = 0.00099999999966 ± 3.1e-13

julia> μₚₑ # protonelectron
μₑᵤ⁻¹μₚᵤ = 1836.15267343 ± 1.1e-7
```

Additional reference values include the ground state `hyperfine` structure transition frequency of caesium-133 `ΔνCs` and `luminousefficacy` of monochromatic radiation `Kcd` of 540 THz.

```julia
julia> ΔνCs # hyperfine
ΔνCs = 9.19263177e9

julia> Kcd # luminousefficacy
Kcd = 683.01969009009
```

As result, there are variants based on the original `molarmass` constant and Gaussian `permeability` along with the 2019 redefined exact values.
The main difference between the two is determined by $M_u$ and $\mu_0$ offset.

```math
(M_u,\mu_0,R_u,g_0,h,c,R_\infty,\alpha,\mu_{eu}) \quad \mapsto \quad m_e = \frac{2R\infty h}{c\alpha^2}, \quad k_B = \frac{m_e}{R_u}{\mu_{eu}g_0M_u}, \quad K_{cd} = 683 \frac{555.016\tilde h}{555h}
```

Construction of `UnitSystem` instances based on specifying the the constants `molarmass`, the `vacuumpermeability`, and the `molargas` along with some other options is facilitated by `MetricSystem`.
This construction helps characterize the differences between

```@docs
MeasureSystems.MetricSystem
```

Historically, the `josephson` and `klitzing` constants have been used to define `Conventional` and `CODATA` variants.

```math
(R_K,K_J), \quad \mapsto \quad \mu_0 = \frac{2R_K\alpha}{c}, \quad h = \frac{4}{R_KK_J^2}, \quad m_e = \frac{2R_\infty h}{c\alpha^2}, \quad k_B = \frac{m_e R_u}{\mu_{eu}M_u}, \quad K_{cd} = 683\frac{555.016\times 4}{555R_KK_J^2h}
```

```@docs
MeasureSystems.ConventionalSystem
```

Originally, the practical units where specified by `resistance` and `electricpotential`.

```math
(\Omega, V), \quad \mapsto k_B\frac{\Omega}{V^2}, \quad h\frac{\Omega}{V^2}, \quad c\frac{1}{1}, quad \mu_0\frac{\Omega}{V^2}, \quad m_e\frac{\Omega}{V^2}, \quad M_u\frac{\Omega}{V^2}, \quad K_{cd}\frac{V^2}{\Omega}
```

```@docs
UnitSystems.ElectricSystem
```

## Electromagnetic CGS Systems

Alternatives to the SI unit system are the centimetre-gram-second variants, where the constants are rescaled with `centi*meter` and `milli` kilogram units along with introduction of additional `rationalization` and `lorentz` constants or electromagnetic units.

```math
(\mu_0,\lambda,\alpha_L,t,l,m,g_0) \quad \mapsto \quad \frac{k_Bt^2}{ml^2g_0}, \quad \frac{ht}{ml^2g_0}, \quad c\frac{t}{l}, \quad \mu_0, \quad \frac{m_e}{m}, \quad \frac{M_u}{m}, \quad K_{cd}\frac{ml^2g_0}{t^3}, \quad \lambda, \quad \alpha_L
```

There are multiple choices of elctromagnetic units for these variants based on electromagnetic units, electrostatic units, Gaussian non-rationalized units, and Lorentz-Heaviside rationalized units.

```@docs
UnitSystems.GaussSystem
```

## Modified (Entropy) Unit Systems

Most other un-natural unit systems are derived from the construction above by rescaling `time`, `length`, `mass`, `temperature`, and `gravity`; which results in modified entropy constants:

```math
(t,l,m,T,g_0) \quad \mapsto \quad k_B\frac{t^2T}{ml^2g_0}, \quad h\frac{t}{ml^2g_0}, \quad c\frac{t}{l}, \quad \mu_0\frac{1}{mlg_0}, \quad m_e\frac{1}{m}, \quad M_u\frac{1}{m}, \quad K_{cd}\frac{ml^2g_0}{t^3}
```

```@docs
UnitSystems.EntropySystem
```


## Foot-Pound-Second-Rankine

In Britain and the United States an `English` system of engineering units was commonly used.

```math
(t,l,m,g_0) \quad \mapsto \quad k_B\frac{5t^2}{9ml^2g_0}, \quad h\frac{t}{ml^2g_0}, \quad c\frac{t}{l}, \quad \mu_0\frac{1}{mlg_0}, \quad m_e\frac{1}{m}, \quad M_u10^3, \quad K_{cd}\frac{ml^2g_0}{t^3}
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
\alpha_G = \left(\frac{m_e}{m_P}\right)^2, \quad \tilde k_B = 1, \quad (\tilde M_u = 1, \quad \tilde \lambda = 1, \quad \tilde\alpha_L = 1)
```

```julia
julia> αG # (mₑ/mP)^2
𝘩²𝘤⁻²mP⁻²R∞²α⁻⁴2² = 1.75181e-45 ± 3.9e-50
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

## UnitSystem Index

```@index
Pages = ["unitsystems.md"]
```
