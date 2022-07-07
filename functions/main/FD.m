function F_D = FD(y)
%Katz Fractal Dimention (FD) calculation of a window
N=length(y);

%compute d
darray=[];
for i=1:N
    darray(end+1)=sqrt((i-1)^2+(y(i)-y(1))^2);
end
d=max(darray);

%compute L
L=0;
for i=2:N
    L=L+sqrt(1+(y(i)-y(i-1))^2);
end

F_D=log(N)/(log(N)+log(d/L));

end

