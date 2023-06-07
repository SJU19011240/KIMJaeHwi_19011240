function el = elevation(ENU, el_mask)
% ENU (n-by-3 matrix, 단위 km)
% el_mask (위성 최소 앙각, deg)
% elevation angle (1-by-n, 단위 deg)
el=zeros(1,height(ENU));
for n=1:height(ENU)
E=ENU(n,1); N=ENU(n,2); U=ENU(n,3);
el(1,n)=rad2deg(asin(U/sqrt(E^2+N^2+U^2)));
    if el(1,n)<=el_mask
       el(1,n)=NaN;
    end
end
end