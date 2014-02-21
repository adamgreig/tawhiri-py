from array import array
from tawhiri.models cimport f, ModelState

def euler(double t, double lat, double lng, double alt, object dataset,
          object models, object terminators, double dt):
    ts = array('d', (t,))
    lats = array('d', (lat,))
    lngs = array('d', (lng,))
    alts = array('d', (alt,))
    while not any(term.get(t, lat, lng, alt) for term in terminators):
        t += dt
        df = f(t, lat, lng, alt, dataset, models)
        lat += df.lat * dt
        lng += df.lng * dt
        alt += df.alt * dt
        ts.append(t)
        lats.append(lat)
        lngs.append(lng)
        alts.append(alt)

    return ts, lats, lngs, alts
