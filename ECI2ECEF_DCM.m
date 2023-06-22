function DCM=ECI2ECEF_DCM(time)
% time ([YYYY,MM,DD,hh,mm,ss] format)
% DCM matrix (3-by-3)
t=juliandate(time);
t0=juliandate([2000 01 01 12 00 00]);
theta_g0=siderealTime(t0);
theta_g=siderealTime(t);
rtheta_g=deg2rad(theta_g);
DCM=[cos(rtheta_g) -sin(rtheta_g) 0; sin(rtheta_g) cos(rtheta_g) 0; 0 0 1];
end