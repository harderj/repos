
ArrayList vehicles;


void setup(){
  
  
  vehicles = new ArrayList();
  
  vehicles.add( new Boat() );
  vehicles.add( new Truck() );
  vehicles.add( new Ferry() );
}


void draw(){

  for( int i=0; i<vehicles.size(); i++ ){
    iVehicle vehicle = (iVehicle) vehicles.get(i);
    vehicle.move();
  }
}



