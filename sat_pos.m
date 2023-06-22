function [lon,lat,az,el,orbit_para]=sat_pos(time_select)
load("nav.mat","nav")

if evalin("base","GPS")==1
    sma=nav.GPS.a; ecc=nav.GPS.e; mean_an=nav.GPS.M0;
    arg=nav.GPS.omega; inc=nav.GPS.i; RAAN=nav.GPS.OMEGA;
    t=nav.GPS.toc;
elseif evalin("base","QZSS")==1
    sma=nav.QZSS.a; ecc=nav.QZSS.e; mean_an=nav.QZSS.M0;
    arg=nav.QZSS.omega; inc=nav.QZSS.i; RAAN=nav.QZSS.OMEGA;
    t=nav.QZSS.toc;
elseif evalin("base","BDS")==1
    sma=nav.BDS.a; ecc=nav.BDS.e; mean_an=nav.BDS.M0;
    arg=nav.BDS.omega; inc=nav.BDS.i; RAAN=nav.BDS.OMEGA;
    t=nav.BDS.toc;
end

GM=3.986004418*10^14;
mean_motion=sqrt(GM/sma^3);
period=2*pi*sqrt(sma^3/GM); % [sec]
mean_an=mean_an+mean_motion*(period*time_select/24-period);
E0=mean_an;
E1=mean_an+ecc*E0;
while abs(E1-E0)>eps
    E1=mean_an+ecc*E0;
    E0=E1;
end
true_an=atan2(((1-ecc*cos(E0))*(cos(E0)-E0)),sqrt(1-ecc^2)*sin(E0)*(1-ecc*cos(E0)));
if true_an<0
    true_an=true_an+2*pi;
end
orbit_para=[sma,ecc,inc,RAAN,arg,true_an];

r_pqw=solveRangeInPerifocalFrame(sma,ecc,true_an);
v_pqw=solveVelocityInPerifocalFrame(sma,ecc,true_an);
rot_mtx=PQW2ECI(arg,inc,RAAN);
r_eci=rot_mtx*r_pqw;
v_eci=rot_mtx*v_pqw;

time_select_array=[0,0,0,time_select,0,0];
dcm=ECI2ECEF_DCM(t+time_select_array);
r_ecef=dcm*r_eci;
v_ecef=dcm*v_eci;

R_earth=6378.1370;
lon_station=deg2rad(evalin("base","lon_station"));
lat_station=deg2rad(evalin("base","lat_station"));
hei_station=evalin("base","hei_station");
x_P=(R_earth+hei_station)*cos(lon_station)*cos(lat_station);
y_P=(R_earth+hei_station)*cos(lon_station)*sin(lat_station);
z_P=(R_earth+hei_station)*sin(lon_station);
r_P_ecef=[x_P;y_P;z_P]; 
r_ENU=ECEF2ENU(r_ecef,r_P_ecef);

x=r_ecef(1);
y=r_ecef(2);
z=r_ecef(3);

lat=rad2deg(atan(z/sqrt(x^2+y^2)));
lon=rad2deg(atan2(y,x)); 
height=sqrt(x^2+y^2+z^2)-R_earth; % [km]


el_mask=evalin("base","el_mask");
az=azimuth(r_ENU');
el=elevation(r_ENU',el_mask);

end