# Standard Units

```@contents
Pages = ["similitude.md","unitsystems.md","constants.md","convert.md"]
Depth = 1
```
```@contents
Pages = ["units.md"]
Depth = 3
```

[![DOI](https://zenodo.org/badge/317419353.svg)](https://zenodo.org/badge/latestdoi/317419353) [![PDF 2020-2025](https://img.shields.io/badge/PDF-2020--2025-blue.svg)](https://www.dropbox.com/sh/tphh6anw0qwija4/AAACiaXig5djrLVAKLPFmGV-a/Geometric-Algebra?preview=unitsystems.pdf)

In 2019 the *SI2019* standardization was completed, based on the 7 physics dimensions specific to the *Metric* system.
That is actually an inadequate and insufficient unit system standard, as it is mathematically impossible to unify all historical units with that standard.
In 2020, *Michael Reed* set out to work around that impossibility with a new project called *UnitSystems.jl*, which ended up completely solving the problem with a brand new 11 dimensional *Unified System of Quantities* (USQ) for physics.

Similar to how SI defines standardized units of `kilogram`, `meter`, `second`, `kelvin`, `coulomb`, `candela`, and `mole`; the following is a comprehensive selection of generated standardized physics units defined by `UnitSystem` defaults useful for scientists and engineers.

## Prefix Units

```@docs
centi
kilo
byte
```

## Mechanics Units

### Angle Units

```@docs
turn
MeasureSystems.radian
spatian
gradian
bradian
degree
arcminute
arcsecond
```

### Solid Angle Units

```@docs
spat
steradian
squaredegree
```

### Time Units

```@docs
second
minute
hour
day
year
```

### Length Units

```@docs
angstrom
inch
foot
surveyfoot
yard
meter
earthmeter
mile
statutemile
meridianmile
admiraltymile
nauticalmile
lunardistance
astronomicalunit
jupiterdistance
lightyear
parsec
```

### Speed Units

```@docs
bubnoff
fpm
ips
kmh
fps
mph
knot
ms
mps
```

### Area Units

```@docs
barn
hectare
acre
surveyacre
```

### Volume Units

```@docs
liter
gallon
quart
pint
cup
fluidounce
teaspoon
tablespoon
```

### Mass Units

```@docs
gram
earthgram
kilogram
tonne
ton
pound
ounce
grain
slug
slinch
hyl
```

### Force Units

```@docs
dyne
newton
poundal
poundforce
kilopond
```

### Pressure Units

```@docs
psi
pascal
barye
bar
technicalatmosphere
atmosphere
inchmercury
torr
```

### Energy Units

```@docs
erg
joule
footpound
calorie
kilocalorie
meancalorie
earthcalorie
thermalunit
gasgallon
tontnt
electronvolt
```

### Power Units

```@docs
watt
horsepowerwatt
horsepowermetric
horsepower
electricalhorsepower
tonsrefrigeration
boilerhorsepower
```

## Electromagnetic Units

### Charge Units
```@docs
coulomb
earthcoulomb
abcoulomb
statcoulomb
```

### Current Units
```@docs
ampere
abampere
statampere
```

### Electromotive Units
```@docs
volt
abvolt
statvolt
```

### Inductance Units
```@docs
henry
abhenry
stathenry
```

### Resistance Units
```@docs
ohm
abohm
statohm
```

### Conductance Units
```@docs
siemens
abmho
statmho
```

### Capacitance Units
```@docs
farad
abfarad
statfarad
```

### Magnetic Flux Units
```@docs
weber
maxwell
statweber
```

### Magnetic Flux Density Units
```@docs
tesla
gauss
stattesla
```

### Magnetic Specialized Units
```@docs
oersted
gilbert
```

## Thermodynamic Units

```@docs
kelvin
rankine
celsius
fahrenheit
sealevel
boiling
mole
earthmole
poundmole
slugmole
slinchmole
katal
amagat
```

## Photometric Units

```@docs
lumen
candela
lux
phot
footcandle
nit
apostilb
stilb
lambert
footlambert
bril
talbot
lumerg
```

## Specialized Units

```@docs
neper
bel
decibel
hertz
apm
rpm
kayser
diopter
rayleigh
flick
gforce
galileo
eotvos
darcy
poise
reyn
stokes
rayl
mpge
langley
jansky
solarflux
curie
gray
roentgen
```

## Units Index

```@index
Pages = ["units.md","unitsystems.md"]
```

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
