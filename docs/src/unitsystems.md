# The UnitSystem

*Physical unit system constants (Metric, English, Natural, etc...)*

```@contents
Pages = ["similitude.md"]
Depth = 1
```
```@contents
Pages = ["unitsystems.md"]
```
```@contents
Pages = ["constants.md","convert.md","units.md"]
Depth = 1
```

By default, `UnitSystems` provides a modern unified re-interpretation of various historical unit systems which were previously incompatible.
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

Construction of `UnitSystem` instances based on specifying the the constants `molarmass`, the `vacuumpermeability`, and the `molargas` along with some other options is facilitated by `MetricSystem`.
This construction helps characterize the differences between 

```@docs
Metric
SI2019
SI1976
Engineering
```

Additional `Metric` variants with angle scaling include `MetricTurn`, `MetricSpatian`, `MetricGradian`, `MetricDegree`, `MetricArcminute`, `MetricArcsecond`.

Historically, the `josephson` and `klitzing` constants have been used to define `Conventional` and `CODATA` variants.

```@docs
Conventional
CODATA
```

Originally, the practical units where specified by `resistance` and `electricpotential`.

```@docs
International
InternationalMean
```

## Electromagnetic CGS Systems

Alternatives to the SI unit system are the centimetre-gram-second variants, where the constants are rescaled with `centi*meter` and `milli` kilogram units along with introduction of additional `rationalization` and `lorentz` constants or electromagnetic units.

```@docs
EMU
ESU
Gauss
LorentzHeaviside
```
There are multiple choices of elctromagnetic units for these variants based on electromagnetic units, electrostatic units, Gaussian non-rationalized units, and Lorentz-Heaviside rationalized units.
Note that `CGS` is an alias for the `Gauss` system.

## Modified (Entropy) Unit Systems

Most other un-natural unit systems are derived from the construction above by rescaling `time`, `length`, `mass`, `temperature`, and `gravity`; which results in modified entropy constants:

```@docs
Gravitational
MTS
KKH
MPH
Nautical
Meridian
```

## Foot-Pound-Second-Rankine

In Britain and the United States an `English` system of engineering units was commonly used.

```@docs
FPS
IPS
British
English
Survey
FFF
```

## Astronomical Unit Systems

The International Astronomical Union (IAU) units are based on the solar mass, distance from the sun to the earth, and the length of a terrestrial day.

```@docs
IAU
IAUE
IAUJ
Hubble
Cosmological
CosmologicalQuantum
```

## Natural Unit Systems

With the introduction of the `planckmass` a set of natural atomic unit systems can be derived in terms of the gravitational coupling constant.

```math
\alpha_G = \left(\frac{m_e}{m_P}\right)^2, \qquad \tilde k_B = 1, \qquad (\tilde M_u = 1, \quad \tilde \lambda = 1, \quad \tilde\alpha_L = 1)
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

```math
\tilde k_B = 1, \qquad \tilde\hbar = 1, \qquad \tilde c = 1, \qquad \tilde\mu_0 = 1, \qquad \tilde m_e = \sqrt{4\pi\alpha_G}
```
```@docs
Planck
```

```math
\tilde k_B = 1, \qquad \tilde\hbar = 1, \qquad \tilde c = 1, \qquad \tilde\mu_0 = 4\pi, \qquad \tilde m_e = \sqrt{4\pi\alpha_G}
```
```@docs
PlanckGauss
```

```math
\tilde k_B = 1, \qquad \tilde\hbar = \frac{1}{\alpha}, \qquad \tilde c = 1, \qquad \tilde\mu_0 = 4\pi, \qquad \tilde m_e = \sqrt{\frac{\alpha_G}{\alpha}}
```
```@docs
Stoney
```

```math
\tilde k_B = 1, \qquad \tilde\hbar = 1, \qquad \tilde c = \frac{1}{\alpha}, \qquad \tilde\mu_0 = 4\pi\alpha^2, \qquad \tilde m_e = 1
```
```@docs
Hartree
```

```math
\tilde k_B = 1, \qquad \tilde\hbar = 1, \qquad \tilde c = \frac{2}{\alpha}, \qquad \tilde\mu_0 = \pi\alpha^2, \qquad \tilde m_e = \frac{1}{2}
```
```@docs
Rydberg
```

```math
\tilde k_B = 1, \qquad \tilde\hbar = 1, \qquad \tilde c = \frac{1}{\alpha}, \qquad \tilde\mu_0 = 4\pi\alpha^2, \qquad \tilde m_e = \sqrt{\frac{\alpha_G}{\alpha}}
```
```@docs
Schrodinger
```

```math
\tilde k_B = 1, \qquad \tilde\hbar = \frac{1}{\alpha}, \qquad \tilde c = 1, \qquad \tilde\mu_0 = 4\pi, \qquad \tilde m_e = 1
```
```@docs
Electronic
```

```math
\tilde k_B = 1, \qquad \tilde\hbar = 1, \qquad \tilde c = 1, \qquad \tilde\mu_0 = 1, \qquad \tilde m_e = 1
```
```@docs
Natural
```

```math
\tilde k_B = 1, \qquad \tilde\hbar = 1, \qquad \tilde c = 1, \qquad \tilde\mu_0 = 4\pi, \qquad \tilde m_e = 1
```
```@docs
NaturalGauss
```

```math
\tilde k_B = 1, \qquad \tilde\hbar = 1, \qquad \tilde c = 1, \qquad \tilde\mu_0 = 1, \qquad \tilde m_e = \frac{1}{\mu_{pe}} = \frac{m_e}{m_p}
```
```@docs
QCD
```

```math
\tilde k_B = 1, \qquad \tilde\hbar = 1, \qquad \tilde c = 1, \qquad \tilde\mu_0 = 4\pi, \qquad \tilde m_e = \frac{1}{\mu_{pe}} = \frac{m_e}{m_p}
```
```@docs
QCDGauss
```

```math
\tilde k_B = 1, \qquad \tilde\hbar = 1, \qquad \tilde c = 1, \qquad \tilde\mu_0 = 4\pi\alpha, \qquad \tilde m_e = \frac{1}{\mu_{pe}} = \frac{m_e}{m_p}
```
```@docs
QCDoriginal
```

## UnitSystem Index

```@index
Pages = ["unitsystems.md"]
```
