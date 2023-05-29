function velocityInPQW =solveVelocityInPerifocalFrame(semimajor_axis, eccentricity, true_anomaly)
GM=3.986004418*10^14;
sma=semimajor_axis;
ecc=eccentricity;
ta=rad2deg(true_anomaly);
p=sma*(1-ecc^2);
velocityInPQW=sqrt(GM/p).*[-sin(ta) ecc+cos(ta) 0]';
end