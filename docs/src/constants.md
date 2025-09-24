# Physics Constants

```@contents
Pages = ["similitude.md","unitsystems.md"]
Depth = 1
```
```@contents
Pages = ["constants.md"]
```
```@contents
Pages = ["convert.md","units.md"]
Depth = 1
```

In 2019 the *SI2019* standardization was completed, based on the 7 physics dimensions specific to the *Metric* system.
That is actually an inadequate and insufficient unit system standard, as it is mathematically impossible to unify all historical units with this standard.
In 2020, *Michael Reed* set out to work around that impossibility with a new project called *UnitSystems.jl*, which ended up completely solving the problem with a brand new 11 dimensional *Unified System of Quantities* (USQ) for physics.

The following is a new set of formulas for fundamental physics constants:  [![DOI](https://zenodo.org/badge/317419353.svg)](https://zenodo.org/badge/latestdoi/317419353) [![PDF 2020-2025](https://img.shields.io/badge/PDF-2020--2025-blue.svg)](https://www.dropbox.com/sh/tphh6anw0qwija4/AAACiaXig5djrLVAKLPFmGV-a/Geometric-Algebra?preview=unitsystems.pdf)

```math
\alpha = \frac{\lambda e^2}{4\pi\varepsilon_0\hbar c} = 
\frac{\lambda c\mu_0 (e\alpha_L)^2}{4\pi\hbar} = 
\frac{e^2k_e}{\hbar c} = 
\frac{\lambda e^2}{2\mu_0ch} = 
\frac{\lambda c\mu_0\alpha_L^2}{2R_K} = 
\frac{e^2Z_0}{2h}
```

There exists a deep relationship between the fundamental constants, which also makes them very suitable as a basis for `UnitSystem` dimensional analysis.
All of the formulas on this page are part of the `Test` suite to [guarantee](https://github.com/chakravala/UnitSystems.jl/blob/master/test/runtests.jl) their universal correctness.

```math
\mu_{eu} = \frac{m_e}{m_u}, \qquad
\mu_{pu} = \frac{m_p}{m_u}, \qquad
\mu_{pe} = \frac{m_p}{m_e}, \qquad
\alpha_\text{inv} = \frac{1}{\alpha}, \qquad
\alpha_G = \left(\frac{m_e}{m_P}\right)^2
```

```@docs
Universe
```

## Relativistic Constants

```math
c = \frac1{\alpha_L\sqrt{\mu_0\varepsilon_0}} = \frac{1}{\alpha}\sqrt{E_h\frac{g_0}{m_e}} = \frac{g_0\hbar\alpha}{m_e r_e}  = \frac{e^2k_e}{\hbar\alpha} = \frac{m_e^2G}{\hbar\alpha_G}
```
```@docs
MeasureSystems.lightspeed
```

```math
h = 2\pi\hbar = \frac{2e\alpha_L}{K_J} = \frac{8\alpha}{\lambda c\mu_0K_J^2} = \frac{4\alpha_L^2}{K_J^2R_K}
```
```@docs
MeasureSystems.planck
```

```math
\hbar = \frac{h}{2\pi} = \frac{e\alpha_L}{\pi K_J} = \frac{4\alpha}{\pi\lambda c\mu_0K_J^2} = \frac{2\alpha_L}{\pi K_J^2R_K}
```
```@docs
MeasureSystems.planckreduced
```

```math
m_P = \sqrt{\frac{\hbar c}{G}} = \frac1k\sqrt{\hbar c\frac{m_\odot}{\text{au}^3}} =\frac{m_e}{\sqrt{\alpha_G}} = \frac{2R_\infty hg_0}{c\alpha^2\sqrt{\alpha_G}}
```
```@docs
planckmass
```

```math
k = \frac{1}{m_P}\sqrt{\hbar c\frac{m_\odot}{\text{au}^3}} = \frac{1}{m_e}\sqrt{\hbar c\alpha_G\frac{m_\odot}{\text{au}^3}}
= \sqrt{G\frac{m_\odot}{\text{au}^3}}
= c^2\sqrt{\frac{\kappa m_\odot}{8\pi\text{au}^3}}
```
```@docs
gaussgravitation
```

```math
G = k^2\frac{\text{au}^3}{m_\odot} = \frac{\hbar c}{m_P^2} = \frac{\hbar c\alpha_G}{m_e^2} = \frac{c^3\alpha^4\alpha_G}{8\pi g_0^2 R_\infty^2 h} = \frac{\kappa c^4}{8\pi}
```
```@docs
MeasureSystems.gravitation
```

```math
\kappa = \frac{8\pi G}{c^4} = \frac{8\pi k^2\text{au}^3}{c^4m_\odot} = \frac{8\pi\hbar}{c^3m_P^2} = \frac{8\pi\hbar\alpha_G}{c^3m_e^2} = \frac{\alpha^4\alpha_G}{g_0^2R_\infty^2 h c}
```
```@docs
einstein
```

## Atomic & Nuclear Constants

```math
m_u = \frac{M_u}{N_A} = \frac{m_e}{\mu_{eu}} = \frac{m_p}{\mu_{pu}} = \frac{2R_\infty hg_0}{\mu_{eu}c\alpha^2} = \frac{m_P}{\mu_{eu}}\sqrt{\alpha_G}
```
```@docs
dalton
```

```math
m_p = \mu_{pu} m_u = \mu_{pu}\frac{M_u}{N_A} = \mu_{pe}m_e = \mu_{pe}\frac{2R_\infty hg_0}{c\alpha^2} = m_P\mu_{pe}\sqrt{\alpha_G}
```
```@docs
protonmass
```

```math
m_e = \mu_{eu}m_u = \mu_{eu}\frac{M_u}{N_A} = \frac{m_p}{\mu_{pe}} = \frac{2R_\infty h g_0}{c\alpha^2} = m_P\sqrt{\alpha_G}
```
```@docs
MeasureSystems.electronmass
```

```math
E_h = \frac{m_e}{g_0}(c\alpha)^2 = \frac{\hbar c\alpha}{a_0} = \frac{g_0\hbar^2}{m_ea_0^2} = 2R_\infty hc = \frac{m_P}{g_0}\sqrt{\alpha_G}(c\alpha)^2
```
```@docs
hartree
```

```math
R_\infty = \frac{E_h}{2hc} = \frac{m_e c\alpha^2}{2hg_0} = \frac{\alpha}{4\pi a_0} = \frac{m_e r_e c}{2ha_0g_0} = \frac{\alpha^2m_ec}{4\pi\hbar g_0}  = \frac{m_Pc\alpha^2\sqrt{\alpha_G}}{2hg_0}
```
```@docs
rydberg
```

```math
a_0 = \frac{g_0\hbar}{m_ec\alpha} = \frac{g_0\hbar^2}{k_e m_ee^2} = \frac{r_e}{\alpha^2} = \frac{\alpha}{4\pi R_\infty}
```
```@docs
bohr
```

```math
r_e = g_0\frac{\hbar\alpha}{m_ec} = \alpha^2a_0 = g_0\frac{e^2 k_e}{m_ec^2} = \frac{2hR_\infty g_0a_0}{m_ec} = \frac{\alpha^3}{4\pi R_\infty}
```
```@docs
electronradius
```

```math
\Delta\nu_{\text{Cs}} = \Delta\tilde\nu_{\text{Cs}}c = \frac{\Delta\omega_{\text{Cs}}}{2\pi}  = \frac{c}{\Delta\lambda_{\text{Cs}}} = \frac{\Delta E_{\text{Cs}}}{h}
```
```@docs
hyperfine
```

## Thermodynamic Constants

```math
M_u = m_uN_A = N_A\frac{m_e}{\mu_{eu}} = N_A\frac{m_p}{\mu_{pu}} = N_A\frac{2R_\infty hg_0}{\mu_{eu}c\alpha^2}
```
```@docs
MeasureSystems.molarmass
```

```math
N_A = \frac{R_u}{k_B} = \frac{M_u}{m_u} = M_u\frac{\mu_{eu}}{m_e} = M_u\frac{\mu_{eu}c\alpha^2}{2R_\infty h g_0}
```
```@docs
avogadro
```

```math
k_B = \frac{R_u}{N_A} = m_u\frac{R_u}{M_u} = \frac{m_e R_u}{\mu_{eu}M_u} = \frac{2R_uR_\infty h g_0}{M_u \mu_{eu}c\alpha^2}
```
```@docs
MeasureSystems.boltzmann
```

```math
R_u = k_B N_A = k_B\frac{M_u}{m_u} = k_BM_u\frac{\mu_{eu}}{m_e} = k_BM_u\frac{\mu_{eu}c\alpha^2}{2hR_\infty g_0}
```
```@docs
molargas
```

```math
\frac{p_0}{k_B T_0} = \frac{N_Ap_0}{R_uT_0} = \frac{\mu_{eu}M_up_0}{m_e R_u T_0} = \frac{M_u \mu_{eu}c\alpha^2p_0}{2R_uR_\infty hg_0 T_0}
```
```@docs
loschmidt
```

```math
\frac{S_0}{R_u} = log\left(\frac{\hbar^3}{p_0}\sqrt{\left(\frac{m_u}{2\pi g_0}\right)^3 \left(k_BT_0\right)^5}\right)+\frac{5}{2} = log\left(\frac{m_u^4}{p_0}\left(\frac{\hbar}{\sqrt{2\pi g_0}}\right)^3\sqrt{\frac{R_uT_0}{M_u}}^5\right)+\frac{5}{2}
```
```@docs
sackurtetrode
```

```math
\frac{180 R_uV_{it}^2}{43 k_BN_A\Omega_{it}} = 
\frac{180 k_BM_uV_{it}^2}{43 R_um_u\Omega_{it}} = 
\frac{90 k_BM_u\mu_{eu}c\alpha^2V_{it}^2}{43 hg_0R_uR_\infty\Omega_{it}}
```
```@docs
mechanicalheat
```

```math
\sigma = \frac{2\pi^5 k_B^4}{15h^3c^2} = \frac{\pi^2 k_B^4}{60\hbar^3c^2} = \frac{32\pi^5 h}{15c^6\alpha^8} \left(\frac{g_0R_uR_\infty}{\mu_{eu}M_u}\right)^4
```
```@docs
stefan
```

```math
a = 4\frac{\sigma}{c} = \frac{8\pi^5 k_B^4}{15h^3c^3} = \frac{\pi^2 k_B^4}{15\hbar^3c^3} = \frac{2^7\pi^5 h}{15c^7\alpha^8} \left(\frac{g_0R_uR_\infty}{\mu_{eu}M_u}\right)^4
```
```@docs
radiationdensity
```

```math
b = \frac{hc/k_B}{5+W_0(-5 e^{-5})} = \frac{hcM_u/(m_uR_u)}{5+W_0(-5 e^{-5})} = \frac{M_u \mu_{eu}c^2\alpha^2/(2R_uR_\infty g_0)}{5+W_0(-5 e^{-5})}
```
```@docs
wienwavelength
```

```math
\frac{3+W_0(-3 e^{-3})}{h/k_B} = \frac{3+W_0(-3 e^{-3})}{hM_u/(m_uR_u)} = \frac{3+W_0(-3 e^{-3})}{M_u \mu_{eu}c\alpha^2/(2R_uR_\infty g_0)}
```
```@docs
wienfrequency
```

```math
K_{\text{cd}} = \frac{I_v}{\int_0^\infty \bar{y}(\lambda)\cdot\frac{dI_e}{d\lambda}d\lambda}, \qquad 
\bar{y}\left(\frac{c}{540\times 10^{12}}\right)\cdot I_e = 1
```
```@docs
MeasureSystems.luminousefficacy
```

## Electromagnetic Constants

```math
\lambda = \frac{4\pi\alpha_B}{\mu_0\alpha_L} = 4\pi k_e\varepsilon_0 = Z_0\varepsilon_0c
```
```@docs
MeasureSystems.rationalization
```

```math
\alpha_L = \frac{1}{c\sqrt{\mu_0\varepsilon_0}} = \frac{\alpha_B}{\mu_0\varepsilon_0k_e} = \frac{4\pi \alpha_B}{\lambda\mu_0} = \frac{k_m}{\alpha_B}
```
```@docs
MeasureSystems.lorentz
```

```math
\alpha_B = \mu_0\alpha_L\frac{\lambda}{4\pi} = \alpha_L\mu_0\varepsilon_0k_e = \frac{k_m}{\alpha_L} = \frac{k_e}{c}\sqrt{\mu_0\varepsilon_0}
```
```@docs
biotsavart
```

```math
Z_0 = \mu_0\lambda c\alpha_L^2 = \frac{\lambda}{\varepsilon_0 c} = \lambda\alpha_L\sqrt{\frac{\mu_0}{\varepsilon_0}} = \frac{2h\alpha}{e^2} = 2R_K\alpha
```
```@docs
vacuumimpedance
```

```math
\mu_0 = \frac{1}{\varepsilon_0 (c\alpha_L)^2} = \frac{4\pi k_e}{\lambda (c\alpha_L)^2} = \frac{2h\alpha}{\lambda c(e\alpha_L)^2} = \frac{2R_K\alpha}{\lambda c\alpha_L^2}
```
```@docs
MeasureSystems.vacuumpermeability
```

```math
\varepsilon_0 = \frac{1}{\mu_0(c\alpha_L)^2} = \frac{\lambda}{4\pi k_e} = \frac{\lambda e^2}{2\alpha hc} = \frac{\lambda}{2R_K\alpha c}
```
```@docs
vacuumpermittivity
```

```math
k_e = \frac{\lambda}{4\pi\varepsilon_0} = \frac{\mu_0\lambda (c\alpha_L)^2}{4\pi} = \frac{\alpha \hbar c}{e^2} = \frac{R_K\alpha c}{2\pi} = \frac{\alpha_B}{\alpha_L\mu_0\varepsilon_0} = k_mc^2
```
```@docs
electrostatic
```

```math
k_m = \alpha_L\alpha_B = \mu_0\alpha_L^2\frac{\lambda}{4\pi} = \frac{k_e}{c^2} = \frac{\alpha \hbar}{ce^2} = \frac{R_K\alpha}{2\pi c}
```
```@docs
magnetostatic
```

```math
e = \sqrt{\frac{2h\alpha}{Z_0}} = \frac{2\alpha_L}{K_JR_K} = \sqrt{\frac{h}{R_K}} = \frac{hK_J}{2\alpha_L} = \frac{F}{N_A}
```
```@docs
elementarycharge
```

```math
F = eN_A = N_A\sqrt{\frac{2h\alpha}{Z_0}} = \frac{2N_A\alpha_L}{K_JR_K} = N_A\sqrt{\frac{h}{R_K}} = \frac{hK_JN_A}{2\alpha_L}
```
```@docs
faraday
```

```math
G_0 = \frac{2e^2}{h} = \frac{4\alpha}{Z_0} = \frac{2}{R_K} = \frac{hK_J^2}{2\alpha_L^2} = \frac{2F^2}{hN_A^2}
```
```@docs
conductancequantum
```

```math
R_K = \frac{h}{e^2} = \frac{Z_0}{2\alpha} = \frac{2}{G_0} = \frac{4\alpha_L^2}{hK_J^2} = h\frac{N_A^2}{F^2}
```
```@docs
klitzing
```

```math
K_J = \frac{2e\alpha_L}{h} = \alpha_L\sqrt{\frac{8\alpha}{hZ_0}} = \alpha_L\sqrt{\frac{4}{hR_K}} = \frac{1}{\Phi_0} = \frac{2F\alpha_L}{hN_A}
```
```@docs
josephson
```

```math
\Phi_0 = \frac{h}{2e\alpha_L} = \frac{1}{\alpha_L}\sqrt{\frac{hZ_0}{8\alpha}} = \frac{1}{\alpha_L}\sqrt{\frac{hR_K}{4}} = \frac{1}{K_J} = \frac{hN_A}{2F\alpha_L}
```
```@docs
magneticfluxquantum
```

```math
\mu_B = \frac{e\hbar\alpha_L}{2m_e} = \frac{\hbar\alpha_L^2}{m_eK_JR_K} = \frac{h^2K_J}{8\pi m_e} = \frac{\alpha_L\hbar F}{2m_e N_A} = \frac{ec\alpha^2\alpha_L}{8\pi g_0R_\infty}
```
```@docs
magneton
```

## Astronomical Constants

```@docs
eddington
solarmass
jupitermass
earthmass
lunarmass
gravity
earthradius
greatcircle
gaussianmonth
siderealmonth
synodicmonth
gaussianyear
siderealyear
jovianyear
radarmile
hubble
cosmological
```

## Constants Index

```@index
Pages = ["constants.md","unitsystems.md"]
```

# Wolfram plagiarism timeline

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


