function ENU=ECEF2ENU(r_ecef,r_P_ecef)
% ECEF to ENU
% r_ecef=[x y z]'
% r_P_ecef = station position
x=r_ecef(1);
y=r_ecef(2);
z=r_ecef(3);
r=6378.1370; % radius of Earth [km]

latitude=atan(z/sqrt(x^2+y^2)); % [rad]
longitude=atan2(y,x); % [rad]
height=sqrt(x^2+y^2+z^2)-r; % [km]
% r_geocentric=[latitude longitude height]';

R_lat=[1 0 0;0 cos(pi/2-latitude) sin(pi/2-latitude); 0 -sin(pi/2-latitude) cos(pi/2-latitude)];
R_log=[cos(pi/2+longitude) sin(pi/2+longitude) 0; -sin(pi/2+longitude) cos(pi/2+longitude) 0; 0 0 1];
ENU=R_lat*R_log*(r_ecef-r_P_ecef);
end