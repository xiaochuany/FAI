clear all; close all;
 
m  = 100; % number of examples
d  = 2;  % feature dimension
x = randn(m,d); % data
true_w = 1+zeros(d,1); % true w
y = 2*(x*true_w>0)-1; % true labels


w = zeros(d,1); % initialise w
v = (x*w.*y<=0); % initialise v
iter= 0;
hold on

while(sum(v)>=1)  % when <= in v holds at least once:
    index = find(v,1,"first");  % find the first i such that <= holds
    w = w + transpose(x(index,:))*y(index);  % update w = w+ x_i* y_i
    v = (x*w.*y<=0); % compute v after update
    iter = iter +1;
    plot(iter,w(1),'bo');
end
