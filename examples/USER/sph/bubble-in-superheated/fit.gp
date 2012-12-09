f(x) = A*abs(x)**B
A = 0.0038854976612842
B = 1.5

set macros
lim="[200:1000]"
file="data-wall3/rg.dat"
fit @lim f(x) file u 0:2 via B, A

set xlabel "t, time"
set ylabel "number of vapor particles"

set fit errorvariables
set key left
plot @lim file u 0:2 w lp, f(x) t sprintf("A*t^%.2f +/- %.2f", B, B_err)