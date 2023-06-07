function az = azimuth(ENU)
% ENU (n-by-3 matrix, 단위 km)
% azimuth angle (1-by-n, 단위 deg)
az=zeros(1,height(ENU));
for n=1: height(ENU)
    E=ENU(n,1); N=ENU(n,2);
    if E<0
    az(1,n)=360-rad2deg(acos(N/sqrt(E^2+N^2)));
    end
end
end