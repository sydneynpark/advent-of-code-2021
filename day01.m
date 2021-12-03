% Day 1

depths = importdata('inputs/01test.txt');

A = [depths(1); depths];
Ashift = [depths; depths(end)];

increases = Ashift > A;
sum(increases)
three_meas_sums = movsum(A,3, 'Endpoints','discard')
increases =  [three_meas_sums; three_meas_sums(end)] > [three_meas_sums(1);three_meas_sums]
sum(increases)