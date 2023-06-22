function el = elevation(ENU, el_mask)
% ENU (n-by-3 matrix, 단위 km)
% el_mask (위성 최소 앙각, deg)
% elevation angle (1-by-n, 단위 deg)

E=ENU(1); N=ENU(2); U=ENU(3);
el=rad2deg(atan(U/sqrt(E^2+N^2)));
if el<=el_mask
   el=NaN;
end

end