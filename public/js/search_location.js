var geocoder = new google.maps.Geocoder();
var resultsMap = new google.maps.Map(document.getElementById('map'), {
    zoom: 15,
    center: {lat: 34.068921, lng: -118.445181}
});

$("#search_location_form").submit(function(){
    // get the long and lat from user's input of location
    geocodeAddress(geocoder, $("#location_input").val(), function(result){
        if (result.J){
            $("#longitude").val(result.M);
            $("#latitude").val(result.J);
            // center the map at this location
            resultsMap.setCenter(result);
            // we can do a get request to server here and update the map after that 
            $.get("/get_listings", { latitude: result.J, longitude: result.M, start_time: $("#start_time").val(), end_time: $("#end_time").val()})
                .done(function(data){
                    for (var i = 0; i < data.length; i++){
                        new google.maps.Marker({position: {lat: data[i].latitude, lng: data[i].longitude}, map: resultsMap}); 
                    };
                });
           
          
        } else {
            alert("Can't find your location");
        }

    });

    return false;

});
