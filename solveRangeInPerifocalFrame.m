function rangeInPQW=solveRangeInPerifocalFrame(semimajor_axis, eccentricity, true_anomaly)

sma=semimajor_axis;
ecc=eccentricity;
ta=rad2deg(true_anomaly);
r=sma*(1-ecc*(ecc+cos(ta)/(1+ecc*cos(ta))));
rangeInPQW=[r*cos(ta) r*sin(ta) 0]';
end