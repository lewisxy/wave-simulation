% n points in total, the resolution of simulation
% Warning: do not let n > 1000, it may cause damage to your machine
n = 500; 

% Wave parameters
% two source interference
xpos = [-2 2];
ypos = [0 0];
%xpos = [-4 -2 0 2 4];
%ypos = [0 0 0 0 0];
% Huygens Principal
%xpos = linspace(-8, 8, 101);
%ypos = zeros(1,101);
%k = 2*pi/2;
p = size(xpos, 2); % number of point wave source
k = 2*pi/(2); % wave number = 2pi/wavelength
w = 0.2; % omega (angular frequency)
t = 0; % t (time)

[x, y] = meshgrid(linspace(-10, 10, n), linspace(-10, 10, n));
z = zeros(n);
for j = 1:p
   z = z + (0.5./(((x-xpos(j)).^2) + (y-ypos(j)).^2).^(1/4)).*(sin(k*sqrt((x-xpos(j)).*(x-xpos(j)) + (y-ypos(j)).*(y-ypos(j))) - w*t));
end

f = figure;
hold on;
% ignore the below comment
% [M, c1] = contour(x, y, z, [0.99, 0.99], 'blue');
% [M, c2] = contour(x, y, z, [-0.99, -0.99], 'red');
% [M, c3] = contour(x, y, z, [0, -100], 'black');
%[M, c4] = contour(x, y, z, [-0.99, -100], 'red');
s = surf(x, y, z);
[M, c] = contour(x, y, z, [0, 0], 'black');
s.EdgeColor = 'none';
sc = scatter(xpos, ypos, 'black', 'filled');
colorbar;
caxis([-1.5, 1.5]);
%caxis([-10, 10]);
hold off;

fname = '2dWave2.gif';

% add the below line after z + to simulate with energy lose
% (0.5./(((x-xpos(j)).^2) + (y-ypos(j)).^2).^(1/4)).*

for t = 0:30
    z = zeros(n);
    for j = 1:p
        z = z + (0.5./(((x-xpos(j)).^2) + (y-ypos(j)).^2).^(1/4)).*(sin(k*sqrt((x-xpos(j)).*(x-xpos(j)) + (y-ypos(j)).*(y-ypos(j))) - w*t));
    end
    set(s, 'XData', x, 'YData', y, 'ZData', z);
    % If you want to turn on the contour plot, uncommene the below line
    %set(c, 'XData', x, 'YData', y, 'ZData', z);
    
    %ignore the below comment
%     set(c1, 'XData', x, 'YData', y, 'ZData', z);
%     set(c2, 'XData', x, 'YData', y, 'ZData', z);
%     set(c3, 'XData', x, 'YData', y, 'ZData', z);

    % if you don't want to produce gif output, comment the below code
    drawnow limitrate
    frame = getframe(f);
    im = frame2im(frame);
    [imind, cm] = rgb2ind(im, 256);
    if t == 0
        imwrite(imind, cm, fname, 'gif', 'Loopcount', inf, 'DelayTime', 0.10);
    else
        imwrite(imind, cm, fname, 'gif', 'WriteMode', 'append', 'DelayTime', 0.10);
    end
end