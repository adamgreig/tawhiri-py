import time
from tawhiri import predict

t0 = 6.0 * 3600
lat0 = 52.0
lng0 = 0.0
alt0 = 0.0
ascent = 5.0
burst = 30000.0
dt = 1.0

start_t = time.time()
ts, lats, lngs, alts = predict.simple(t0, lat0, lng0, alt0, ascent, burst, dt)
end_t = time.time()
for idx, t in enumerate(ts):
    print(t, lats[idx], lngs[idx], alts[idx])
print("Took {}s".format(end_t - start_t))
