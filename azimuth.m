function az = azimuth(ENU)
% ENU (n-by-3 matrix, 단위 km)
% azimuth angle (1-by-n, 단위 deg)

E=ENU(1); N=ENU(2);
az=rad2deg(atan2(E,N));


end