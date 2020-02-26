# asp_check_in_desks_assignment
Solution to the problem of assigning consecutive desks at the airport, needed for the distinct check-ins.


Given the following information:

  •There are N desksfor check-in in an airport. Those desks are identical and  placed  sequentially  in  one  row:
    from  the  desk  number 1 up  to the desk number N.
  •For  today  (from  midnight  to  midnight)  there  have  been  scheduled M flights(flight  1,  ...   flight  M).
    Each  flight  requires  a  certain  number  ofdesks for check-in - numdesks (<flight>) - in a specific time 
    interval [a,b[ - that is from hour a included up to hour b excluded.
  •The check-in desks that are being reserved for a specific flight must be consecutive(they must be a sub-sequence of 1..N).
  •A desk can not be reserved for two different flights in the same moment.

, write an ASP program that for all of the scheduled flights tries to find a way to reserve the desks they require.
