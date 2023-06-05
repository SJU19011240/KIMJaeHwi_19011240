function rangeInPQW=solveRangeInPerifocalFrame(semimajor_axis, eccentricity, true_anomaly)
GM=3.986004418*10^14;
sma=semimajor_axis;
ecc=eccentricity;
ta=rad2deg(true_anomaly);
ecc_anomaly=acos((ecc+cos(ta)/(1+ecc*cos(ta))));
r=sma*(1-ecc*cos(ecc_anomaly));
rangeInPQW=[r*cos(ta) r*sin(ta) 0]';
end