// google maps custom routines for SCAMIT
markersArray = new Array();
var map;
function showOverlays() {
  for (n in markersArray) {
    markersArray[n].setMap(map);
  } 
}


function initialize() {

   var my_center = new google.maps.LatLng(32.5949, -117.245 );
   var mapOptions = {
     zoom: 6,
     center: my_center,
     mapTypeId: google.maps.MapTypeId.SATELLITE
   };
    
 map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);

 }
 

