from tawhiri cimport models
from tawhiri import wind, solver

def simple(t, lat, lng, alt, ascent, burst, dt):
    ds = wind.Dataset()
    ds.open_dataset("/home/adam/Projects/tawhiri/datasets", 2014, 2, 3, 6)
    ascent = models.ConstantAscent(ascent)
    velocity = models.WindVelocity(t, lat, lng, ds)
    burst = models.BurstTermination(burst)
    mods = [ascent, velocity]
    term = [burst]
    return solver.euler(t, lat, lng, alt, ds, mods, term, dt)
