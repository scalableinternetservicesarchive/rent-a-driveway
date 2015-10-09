$("#search_location_form").submit(function(){
    // get the long and lat from user's input of location
    geocodeAddress($("#location_input").val(), function(result){
        console.log("geocode result = ", result);
        if (result.J){
            $("#longitude").val(result.M);
            $("#latitude").val(result.J);
            // we can do a get request to server here and update the map after that 
        } else {
            alert("Can't find your location");
        }

    });

    return false;

});
