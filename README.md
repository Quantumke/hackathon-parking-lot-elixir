##Parking Lot

Task: implement a parking lot system using the grid below


##### PARKING LOT STRUCTURE
<b> H </b> - Handicap lot <br>
<b>C </b>- Car lot <br>
<b>M</b> - Handicap lot<br>
<b>T</b> - Truck lot

*| *| *
------------- | -------------|----
H1  | H2 | H3
CA  | C2 | C3
M1 | M2 | M3
T1  |  | 


- A vehicle can only be parked at the designated zone e.g car on car lot (c1-c3) <br/>
- Once a vehicle is parked the spot cannot be used until the car is moved<br/>
- One all the spaces are filled the system should return "no more spaces available"

###How to run

1. Clone repository
2. `iex parking_lot.exs`
3. `{:ok, pid} = GenServerService.start_link`
#### vehicles can be (car,handicap,motor_cycle,truck)
4. `ParkingLot.find_parking(pid, "car")`
#### To remove car from lot
5. `ParkingLot.remove_from_parking(pid, "car", 2)`