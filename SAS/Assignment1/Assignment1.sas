/*Creating a parmenant library*/
%let path=C:\Users\ehars\Documents\UCD\SAS\Assignment1; /*Insert your own path here*/
libname assign "&path";

/*assign.assignment1 point the control to load the dataset assignment1 to the library assign.*/
data assign.assignment1;
 input  Participant_ID $ Age Gender Height Bodyweight0 Energy_Intake0 Bodyweight6 Energy_Intake6;
 cards;
H001 44 1 1.64 64 3117.012592 64 2386.293584
H002 60 0 1.79 85 2401.086094 85.8 1975.425133
H003 60 1 1.68 78 3782.278023 71.1 1639.759129
H004 26 1 1.67 71 2390.49456 67.8 1747.363305
H005 43 1 1.73 65 1765.94291 67 2063.152143
H006 42 0 1.86 87 2865.617571 87 3257.243071
H007 24 1 1.82 100 2635.682056 . .
H008 24 1 1.63 51 1593.64229 49 1071.707956
H009 26 1 1.6 86 2207.267554 . .
H010 27 1 1.72 62 2522.437724 60 1950.247716
H011 25 1 1.69 56 2390.0648 . .
H012 56 1 1.75 65 1831.723554 64.5 2550.590745
H013 23 1 1.67 61 2038.749301 60 2210.489126
H014 47 1 1.73 84 3000.298992 82 1397.626227
H015 30 0 1.79 72 2775.717315 71.3 2048.347305
H016 45 1 1.65 69 2922.554318 . .
H017 26 1 1.51 45 1863.480418 44 1829.217287
H018 42 0 1.9 87 2242.550705 85.2 1864.138399
H019 39 1 1.76 65 2926.580957 64.3 3493.39175
H020 30 1 1.64 59 3049.379388 55 1852.220362
H021 28 1 1.72 60 2116.417651 . .
H022 25 0 1.74 69 1828.901811 66.5 3322.061738
H023 50 1 1.58 52 1605.378986 51 1059.506904
H024 28 0 1.83 79 2453.056095 77 2323.807467
H025 31 0 1.7 73 3252.488844 70 2949.823859
H026 63 1 1.75 64 1849.507148 65 1949.270672
H027 25 0 1.76 83 3762.558878 84 1796.010367
H028 22 1 1.8 71 2285.085029 70.4 2708.809868
H029 23 1 1.72 80 4084.044529 82 3999.042599
H030 21 1 1.6 58 5507.717554 63 2164.820558
H031 27 1 1.76 64 1997.504023 62.4 1883.711109
H032 29 1 1.69 58 3507.795437 59 2007.434377
H033 28 1 1.61 62 1743.955493 64 1988.279689
H034 28 1 1.54 56 2492.59956 55.8 2237.603114
H035 24 0 1.79 92 2677.680603 87 1934.12708
H036 30 1 1.69 65 1982.232358 65.5 2049.951692
H037 31 1 1.63 53 1691.691094 54 1656.984196
H038 31 0 1.79 81 3369.939011 80.4 2356.416884
H039 45 1 1.8 80 1404.447784 74.5 1598.045875
H040 44 1 1.68 69 2318.733127 . .
H041 60 0 1.85 89 3265.903279 . .
H042 52 1 1.67 66 2055.801591 65 1359.916937
H043 26 1 1.6 47 2256.950132 46 1583.249504
H044 45 1 1.78 76 3482.107173 78.4 2185.59183
H045 65 0 1.81 79 2513.870866 78.7 2897.863148
H046 58 1 1.7 79 2130.659107 77.3 1714.050242
H047 42 1 1.72 66 3804.918792 64.5 2864.004012
H048 70 0 1.69 67 2790.567978 . .
H049 45 1 1.72 61 1986.792403 58 1960.087586
H050 33 1 1.75 62 2107.673848 62 2221.421188
H051 28 1 1.71 74 1989.963284 . .
H052 61 0 1.83 84 2597.707879 82 2245.12584
H053 46 1 1.78 76 2042.567077 75.6 2338.394276
H054 63 1 1.63 80 3048.516328 87 2428.038633
H055 28 1 1.72 64 2694.650599 59 1358.584926
H056 59 1 1.65 67 1814.504601 63.9 1523.669203
H057 42 1 1.7 60 2451.598141 58.8 1430.498793
H058 45 0 1.9 95 2237.471728 93 1922.244134
H059 63 0 1.79 92 2387.303251 93 1216.543363
H060 49 1 1.78 68 3076.082662 70.2 2525.917387
H061 43 1 1.66 70 3999.705296 63.4 2661.179731
H062 47 0 1.92 105 2275.974315 106 3244.491
H063 31 1 1.69 57 3376.683371 57.4 2527.141671
H064 49 0 1.95 85 5900.250932 86 3567.763257
H065 50 0 1.92 84 2534.362909 86 1999.780746
H066 23 1 1.62 60 2591.20612 . .
H067 29 1 1.76 64 2709.302137 62.6 1605.871552
H068 38 1 1.66 63 1911.53551 63 2371.942576
H069 50 1 1.74 77 1603.238938 75.3 1326.305511
H070 51 1 1.86 89 2884.82134 87.9 2649.649572
H071 49 1 1.6 68 1571.715274 64.7 1721.512423
H072 26 1 1.79 62 2376.5866 64.2 2131.932716
H073 52 1 1.59 67 2543.463476 66.8 1569.101181
H074 32 1 1.67 59 1595.158309 56.6 1465.49205
H075 43 1 1.68 57 4992.233616 59.2 1931.407755
H076 49 1 1.73 100 3840.625779 . .
H077 21 1 1.67 54 1808.712483 54.5 1718.098944
H078 51 0 1.86 96 2785.403164 89.9 3166.416353
H079 29 0 1.7 79 2803.40516 79 1758.116622
H080 57 1 1.68 66 1843.685763 67.2 1854.215478
H081 47 1 1.64 68 2177.769014 67.7 1844.119387
H082 50 1 1.7 57 2415.747464 56 2163.074812
H083 45 1 1.88 76 2452.572791 74.7 2625.701433
H084 24 0 1.78 63 2924.155705 63.4 2164.462333
H085 48 1 1.8 69 3256.4675 66 1977.536582
H086 29 0 1.81 80 2192.924943 78 2967.269589
H087 56 1 1.75 105 2608.725192 96 2218.807586
H088 60 1 1.6 64 1553.938103 61 1458.088902
H089 38 0 1.76 71 2872.335802 . .
H090 39 1 1.68 68 2177.629524 64 1651.179628
H091 48 1 1.68 76 2028.898858 . .
H092 42 1 1.72 74 2114.992894 74.3 2854.211079
H093 24 1 1.73 68 2629.247978 . .
H094 48 0 1.83 79 2293.918018 77.9 2625.011896
H095 51 0 1.86 91 2740.878059 88.4 1665.007766
H096 53 1 1.7 88 1772.696513 86.5 1595.254826
H097 41 1 1.67 54 2847.499041 54.8 2046.021402
H098 55 1 1.63 57 2419.736098 56.6 2741.904877
H099 36 1 1.68 84 2112.347913 . .
H100 47 1 1.73 90 2492.693633 82.9 1855.333933
H101 55 0 1.78 78 2829.395776 72.3 2268.738777
H102 72 0 1.78 103 3083.524411 103 3175.002039
H103 30 0 1.9 99 3997.938343 98 1633.500734
H104 54 1 1.7 92 1964.418512 93.4 1763.599474
H105 44 0 1.82 76 2295.228864 79 1725.374759
H106 57 1 1.75 69 1672.23483 70.3 1425.230302
H107 57 1 1.58 61 2218.066846 59 1844.569135
H108 50 0 1.8 92 2460.731284 90.7 2152.641049
H109 62 0 1.73 67 1880.250657 66.1 2431.101916
H110 53 0 1.82 94 2745.672286 86.7 2301.801611
H111 53 0 1.91 82 2396.735509 85.3 2518.778919
H112 64 0 1.85 87 3534.69648 83.5 2407.103065
H113 55 1 1.65 62 2686.807026 58 1511.498493
H114 54 0 1.8 107 2873.221657 108 2022.840449
H115 43 0 1.78 77 3288.156041 77.8 2673.749642
H116 60 0 1.84 100 2503.346288 99 2252.394697
H117 43 1 1.7 77 2972.469109 77 3167.219743
H118 70 0 1.74 74 2258.43736 73.2 1329.568743
H119 50 1 1.68 70 2384.463214 68.5 2362.399572
H120 43 1 1.6 50 1624.923797 . .
H121 30 0 1.76 68.2 3445.111747 68 2540.401163
H122 54 0 1.75 96 3199.304838 99 4311.060986
H123 55 0 1.79 73 2417.279125 65 2678.085627
H124 68 0 1.79 93 2420.567098 87 1421.749446
H125 49 0 1.85 114 3085.01483 116.6 3183.535328
H126 31 0 1.94 88 2658.029649 85.6 1717.846778
H127 57 0 1.85 81 3492.615406 81.2 2921.668049
H128 67 0 1.71 71 2169.528764 67.9 2003.285054
H129 49 0 1.82 84 5254.927686 85.3 3930.662127
H130 62 0 1.8 98 2134.643096 92 2224.149412
H131 63 1 1.72 71 1448.902415 . .
H132 64 0 1.87 105 4210.453647 106.5 4580.79489
H133 36 0 1.78 90 16271.07383 88 2670.408449
H134 52 0 1.75 66 2787.872588 . .
H135 47 1 1.64 63 1338.044206 65.4 1675.832016
H136 32 0 1.87 94 4486.047662 78 2940.692425
H137 60 0 1.8 111 2296.145318 113.6 3709.185845
H138 43 0 1.87 72 3301.877386 71 2767.973247
H139 36 0 1.85 80 2642.482695 85 1956.86906
H140 47 1 1.78 70 2331.382062 . .
H141 41 0 1.89 90 4167.60336 92 3490.985477
H142 56 0 1.83 81 4240.063353 81.3 3478.220538
H143 22 1 1.67 64 1878.467914 . .
H144 66 1 1.62 93 2481.07688 95 1458.689988
H145 30 0 1.75 72 2055.445417 66 2481.389823
H146 54 0 1.83 77 2460.078363 80.5 2572.632129
H147 67 0 1.83 92 2946.893271 . .
H148 61 0 1.88 118 4165.756908 115 3563.056225
H149 51 0 1.78 73 2355.632084 70 2414.736415
H150 66 0 1.78 81 2209.383975 . .
H151 47 0 1.7 78 2145.01561 79 1844.239157
H152 65 0 1.84 74 2314.656112 71 2195.676501
H153 69 1 1.72 68 1947.700071 66.5 2030.711854
H154 51 0 1.96 118 3166.82039 116.4 2310.771115
H155 26 0 1.8 83 2859.920335 83 2892.812036
H156 27 1 1.72 61 2308.395445 . .
H157 47 0 1.76 81 1936.164556 . .
H158 55 0 1.77 120 2286.704471 115 2775.978367
H159 46 1 1.74 88 1931.932077 81.2 1263.658709
H160 52 0 1.77 81.6 3141.223929 77.7 1884.47022
H161 59 0 1.84 90 2868.868303 91 2735.811414
H162 56 1 1.64 69 4169.605906 68.6 1540.291365
H163 66 1 1.61 62 1398.992129 . .
H164 20 1 1.74 64 3708.492063 . .
H165 28 0 1.77 78 4422.352473 . .
H166 28 0 1.79 83 2824.708557 86 2950.923172
H167 45 1 1.63 70 1756.418734 . .
H168 56 0 1.88 94 2837.087392 93.5 1707.319766
H169 40 0 1.67 66 2693.668251 . .
H170 54 0 1.8 94 2564.934549 85 2468.000551
H171 55 0 1.85 86 1978.438663 83.9 1745.469659
H172 55 1 1.72 65 3128.364017 64.9 1730.149553
H173 49 0 1.76 80 2557.898548 . .
H174 30 0 1.94 98 2597.304895 94 1490.244984
H175 55 1 1.72 71 1919.054833 . .
H176 64 0 1.85 73 2284.525766 74 2450.239805
H177 53 1 1.67 51 1392.594356 52 1335.043925
H178 37 0 1.75 92 2309.734592 98.2 2105.25384
H179 43 0 1.82 89 2673.656359 86.3 2257.569855
H180 44 1 1.82 86 2383.072973 85.1 3594.188597
H181 39 0 1.85 84 2305.081741 . .
H182 51 0 1.74 80 2206.951114 . .
H183 36 0 1.84 82 3787.829079 78 2267.656049
H184 55 1 1.64 49 1672.37153 49.3 1856.729727
H185 23 1 1.79 72 3102.694206 70.2 1377.572783
H186 52 1 1.67 58 2696.592855 57 2179.324708
H187 37 0 1.71 67.5 2878.677406 67.3 2502.366847
H188 24 0 1.76 77 2567.526822 74.7 2147.168361
H189 32 0 1.83 84 3321.76696 . .
H190 31 0 1.85 74 3461.728256 73 2358.376137
H191 32 0 1.79 65 3833.097466 65 3323.213723
H192 41 0 1.84 78 2477.855836 . .
H193 38 0 1.8 89 2633.359362 . .
H194 23 0 1.93 75 3250.099322 74 3133.995748
H195 28 0 1.74 75 3133.373205 76.8 1920.2702
H196 21 1 1.84 117 3014.837846 . .
H197 45 1 1.78 64 3348.912437 62.5 2139.826796
H198 30 0 1.72 73.5 2747.906932 . .
H199 18 0 1.78 61 2504.375933 61.7 2406.51483
H200 32 0 1.78 72 2876.977774 70 2266.168913
H201 38 1 1.66 59 2305.005312 62.1 1625.572308
H202 46 1 1.76 58 1928.131821 57.3 2067.669891
H203 54 1 1.72 65 2520.006052 61 2160.857746
H204 18 0 1.87 65 1751.044703 . .
H205 32 1 1.57 54 1587.293263 59.3 1087.07812
H206 45 1 1.73 86 3055.553931 81.2 1231.086676
H207 27 1 1.76 67 1895.697891 66.7 1209.169591
H208 32 1 1.68 70 1924.340328 . .
H209 29 0 1.83 79 3076.555675 . .
H210 61 1 1.6 60 1850.811886 . .
H211 55 0 1.84 62 3371.797965 62 2434.380323
H212 39 1 1.65 75 2155.359742 . .
H213 50 1 1.78 68 3479.013824 68.2 3414.68707
H214 56 1 1.68 74 3170.634511 77 1524.804185
H215 52 1 1.76 99 2918.561221 102.5 1994.870796
H216 18 1 1.65 67 2831.341052 61.9 2650.991504
H217 22 1 1.61 53 2279.971927 51 1114.403054
H218 20 1 1.73 75 1943.811594 . .
H219 68 1 1.68 61 2590.275513 60.6 2329.537187
H220 25 1 1.63 62 2405.174453 59.8 1946.399281
;
