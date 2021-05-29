using MeasureSystems, Test

@test 1000molarmass(SI2019) == molarmass(EMU2019)
@test luminousefficacy(SI2019)/1e7 ≈ luminousefficacy(EMU2019)
