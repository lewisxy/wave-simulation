f = figure;
hold on;

n = 100;
fr = 100;

axis([min(x) max(x) -2 2]);
p = plot(NaN, NaN, 'LineWidth', 2);
txt = text(-1, 1.2, ['t = ', 0], 'FontSize', 20);

c = 0.2;
tt = linspace(0, 10*pi, fr);
x = linspace(-10, 10, n);
y = zeros(n, fr);
for t = 1:fr
    y(:, t) = sin(x-c*tt(t));
end

hold off;

fname = 'travelingWave2.gif';

for t = 1:fr
    set(p, 'XData', x, 'YData', y(:, t));
    set(txt, 'String', ['t = ', num2str(t)]);
    %pause(0.04);
    frame = getframe(f);
    im = frame2im(frame);
    [imind, cm] = rgb2ind(im, 256);
    if t == 1
        imwrite(imind, cm, fname, 'gif', 'Loopcount', inf, 'DelayTime', 0.04);
    else
        imwrite(imind, cm, fname, 'gif', 'WriteMode', 'append', 'DelayTime', 0.04);
    end
end