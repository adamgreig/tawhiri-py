from libc.math cimport cos, M_PI
from wind cimport WindSpeed


cdef double _PI_180 = M_PI / 180.0
cdef double _180_PI = 180.0 / M_PI

cdef class ConstantAscent:
    def __init__(self, ascent_rate):
        self.ascent_rate = ascent_rate
    cpdef public ModelState get(self, double t, double lat, double lng,
                               double alt, object dataset):
        cdef ModelState ret
        ret.lat = ret.lng = 0.0
        ret.alt = self.ascent_rate
        return ret


cdef class WindVelocity:
    def __init__(self, t, lat, lng, dataset):
        self.pressure_heights = dataset.get_pressure_heights(t/3600.0, lat, lng)
    cpdef public ModelState get(self, double t, double lat, double lng,
                               double alt, object dataset):
        cdef ModelState ret
        cdef double R
        cdef WindSpeed s
        s = dataset.get_wind(t / 3600.0, alt, lat, lng, self.pressure_heights)
        R = 6371009 + alt
        ret.lat = _180_PI * s.v / R
        ret.lng = _180_PI * s.u / (R * cos(lat * _PI_180))
        ret.alt = 0.0
        return ret


cdef class BurstTermination:
    def __init__(self, burst_altitude):
        self.burst_altitude = burst_altitude
    cpdef public int get(self, double t, double lat, double lng, double alt):
        if alt >= self.burst_altitude:
            return 1
        else:
            return 0


cdef ModelState f(double t, double lat, double lng, double alt, object dataset,
                  object models):
    cdef int i
    cdef ModelState ret, chunk
    chunks = [model.get(t, lat, lng, alt, dataset) for model in models]
    ret.lat = 0.0
    ret.lng = 0.0
    ret.alt = 0.0
    for c in chunks:
        chunk = c
        ret.lat += chunk.lat
        ret.lng += chunk.lng
        ret.alt += chunk.alt
    return ret
