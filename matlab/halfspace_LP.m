m  = 1000; % number of examples
d  = 50;  % feature dimension
x = randn(m,d); % data
true_w = 1+zeros(d,1); % true w
y = 2*(x*true_w>0)-1; % label of the data

u = zeros(d,1); % objective linear function
A = x.*y; % constraint LHS matrix
b = 1+zeros(m,1); % constraint RHS 
w = linprog(u,-A,-b); %  solve linear programming -A w <= -b i.e. Aw>= b

w = w/norm(w);  % normalise w. 