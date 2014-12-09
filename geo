#!/usr/bin/env ruby

require 'geocoder'
street = "37 Lincoln Pkwy"
city = "Crystal Lake"
state = "IL"
zip = "60014"

#geocoded_by :address
#after_validation :geocode

#def address
#  [street, city, state, zip].compact.join(', ')
#end

trimmed_address = [street, city, state, zip].compact.join(', ')

geocode_result = Geocoder.search(trimmed_address)
    if geocode_result.first
        coordinates = geocode_result.first.latitude
        #coordinates = geocode_result.first.coordinates.join(", ")
    else
        coordinates = "Not found"
    end

p coordinates
