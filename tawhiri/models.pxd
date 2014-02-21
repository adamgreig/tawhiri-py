ctypedef struct ModelState:
    double lat
    double lng
    double alt

cdef class ConstantAscent:
    cdef double ascent_rate
    cpdef public ModelState get(self, double, double, double, double, object)

cdef class WindVelocity:
    cdef object pressure_heights
    cpdef public ModelState get(self, double, double, double, double, object)

cdef class BurstTermination:
    cdef double burst_altitude
    cpdef public int get(self, double, double, double, double)

cdef ModelState f(double, double, double, double, object, object)
