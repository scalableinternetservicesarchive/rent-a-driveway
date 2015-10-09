function geocodeAddress(geocoder, address, callback) {
  geocoder.geocode({'address': address}, function(results, status) {
    if (status === google.maps.GeocoderStatus.OK) {
        callback (results[0].geometry.location);
    } else {
        callback ({});
    }
  });
}
