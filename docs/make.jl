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
        "Appendix" => "appendix/".*Any[
            "Definition.md","Unified.md",
            "Metric.md", "SI2019.md", "SI1976.md",
            "CODATA.md", "Conventional.md",
            "International.md", "InternationalMean.md",
            "MetricTurn.md", "MetricSpatian.md", "MetricGradian.md", "MetricDegree.md",
            "MetricArcminute.md", "MetricArcsecond.md",
            "Engineering.md", "Gravitational.md", "MTS.md",
            "EMU.md", "ESU.md", "Gauss.md", "LorentzHeaviside.md",
            "FPS.md", "IPS.md", "British.md", "English.md", "Survey.md",
            "MPH.md", "KKH.md", "Nautical.md", "Meridian.md",
            "IAU.md", "IAUE.md", "IAUJ.md", "Hubble.md", "Cosmological.md",
            "CosmologicalQuantum.md", "Planck.md", "PlanckGauss.md",
            "Stoney.md", "Hartree.md", "Rydberg.md", "Schrodinger.md", "Electronic.md",
            "Natural.md", "NaturalGauss.md", "QCD.md", "QCDGauss.md", "QCDoriginal.md"
        ]
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
