import time
from tawhiri import wind, solver, models

ds = wind.Dataset()
ds.open_dataset("/home/adam/Projects/tawhiri/datasets", 2014, 2, 3, 6)

mods = [models.make_constant_ascent(5.0), models.wind_velocity]
term = [models.make_burst_termination(30000.0)]
f = models.f

t0 = 6.0 * 3600
lat0 = 52.0
lng0 = 0.0
alt0 = 0.0

dt = 60.0

start_time = time.time()
ts, lats, lngs, alts = solver.euler(t0, lat0, lng0, alt0, ds, f, mods, term, dt)
end_time = time.time()

print("Took {}s".format(end_time - start_time))
