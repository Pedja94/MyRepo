m = 20;
sumGF = 0;
sumAvg = 0;
sumMed = 0;

for i = 1 : m
    poredjenje
    sumGF = sumGF + GFTime;
    sumAvg = sumAvg + AvgTime;
    sumMed = sumMed + MedTime;
end

avgGF = sumGF / m;
avgAvg = sumAvg / m;
avgMed = sumMed / m;