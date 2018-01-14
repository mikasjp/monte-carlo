clc()
clear()
figure(0)
clf()


// function to be integrated
function y = f(x)
    y = sin(x)
    //y = x
endfunction

// sample rate
sr = 100

// function values in the range
x = -1:1/sr:2*%pi+1
y = f(x)

// integration limits
x_min = 0
x_max = %pi

// maximum and minimum value of the function in the range
y_min = min(y)
y_max = max(y)

// ammount of random points
points = 1000

// generate radnom points
xp = zeros(1, points)
yp = zeros(1, points)

for i = 1:points
    xp(i) = x_min + (x_max - x_min) * rand()
    yp(i) = (abs(y_max) + abs(y_min)) * rand() - abs(y_min())
end

// plot our function and generated random points
clf()
plot(x, y)
scatter(xp, yp, 3, 'green', 'fill', 'x')
xgrid()

// extend view
a = get('current_axes')
a.data_bounds = a.data_bounds * 1.1

// draw the area on which the algorithm works
xrect(x_min, y_max, (x_max - x_min), (y_max - y_min))
r=get('hdl')
r.foreground=color('red')

// count the number of points inside the function
counter = 0
for i = 1:points
    fv = f(xp(i))
    if fv >= 0 then
        if (yp(i) <= fv) & (yp(i) >= 0) then
            counter = counter + 1
        end
    else
        if (yp(i) >= fv) & (yp(i) <= 0) then
            counter = counter - 1
        end
    end
end

// finally calculate the integral value
integral = (x_max - x_min) * (y_max - y_min) * counter/points

disp(integral)
xtitle('Integral value = ' + string(integral))
xlabel('x')
ylabel('y')
