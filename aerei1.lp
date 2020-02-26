%Atoms
hour(0..23).
flight(1..5).
desk(1..n).
time_interval(1,15,16). %time_interval(FLIGHT, FROM, TO) indicates when the desks are needed for a specific flight.
time_interval(2,14,16). 
time_interval(3,15,16). 
time_interval(4,22,23). 
time_interval(5,21,23). 
desks_required(1,2). %desks_required(FLIGHT, NUMBER) indicates the number of desks a specific flight needs for check-in.
desks_required(2,2).
desks_required(3,2).
desks_required(4,3).
desks_required(5,2).


%Auxiliary predicates
min(V,N,O) :- N = #min { D: desk(D), desk_reserved(V,D,O)}, flight(V), time_interval(V,I,F), hour(O), O>=I, O<F. %min(FLIGHT, DESK, HOUR) finds the desk with the smallest ID - among all of the desks that have been reserved to a specific flight "V", at a specific hour "H"

gauss_sum(V,G,O) :- min(V,N,O), hour(O), desk(A), flight(V), desks_required(V,D), desk(D), G=(N*2+D-1)*D/2. %gauss_sum(FLIGHT, SUM, HOUR) finds what the sum of the consecutive desks' IDs (assigned to a flight "V" at hour "H") should be, if the smallest of the desks' IDs is min(FLIGHT, DESK, HOUR).

actual_sum(V,N,O) :- N = #sum { D: desk(D), desk_reserved(V,D,O)}, hour(O), flight(V), time_interval(V,I,F), hour(O), O>=I, O<F. %actual_sum(FLIGHT, SUM, HOUR) sums up the IDs of all of the desk that have been reserved for a flight "V", at hour "O". We will compare, later, this number to the number we would get if these desks were consecutive gauss_sum(FLIGHT, SUM, HOUR) - if they are not identical, we will discard the solution.

%Generate solutions
N{desk_reserved(V,D,O) : desk(D)}N :- flight(V), desks_required(V,N), time_interval(V,I,F), hour(O), O>=I, O<F. %N{desk_reserved(FLIGHT, DESK, HOUR)[...]}N reserves for each flight the desks it needs at the hours that are included in the time interval going from hour "I" included to hour "F" excluded.

%Define the restrictions
:- gauss_sum(V,N,O),actual_sum(V,S,O),flight(V),hour(O), N!=S. %Remove solutions in which desks reserved for a flight's check-in are not consecutive.
:- desk_reserved(V,D,O), desk_reserved(T,D,O), hour(O), flight(V), flight(T), desk(D), V!=T. %Imposing that the same desk can not be assigned to two different flights.
:- min(V,N,O), min(V,S,F), flight(V), hour(O), hour(F), N!=S. %Imposing that the subsequnce of desks does not change in time - in case the check-in lasts more than one hour.

%Control which predicates are printed, when a satisfying model for the instance is found
#show. %Suppress all atoms in output.
#show desks_required/2. %Include all atoms of predicate desks_required/2 in output.
#show time_interval/3. %Include all atoms of predicate time_interval/3 in output.
#show desk_reserved/3. %Include all atoms of predicate desk_reserved/3 in output.

