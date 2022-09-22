function plot_iso(x, y, z, signal, n)

n_levels = n;

t = linspace(0.4, 1.2, n_levels);

levels = exp(t) .^ 4;

levels = levels./max(levels);

% levels = linspace(0.01, 0.2, n_levels);

fa = levels;

figure;

for i = 1:n_levels
    
    iLevel = levels(i);    
   
    p = patch(isosurface(x, y, z, signal, iLevel));    
    
    ind = floor(i/n_levels * 256);
    
    colormap 'jet';
    cmap = colormap;
    c = squeeze(ind2rgb(ind, cmap));    
    
    p.FaceColor = c;
    p.EdgeColor = 'none';
    p.FaceAlpha = fa(i);
    
    hold on
    
end

daspect([1 1 1])
view(3);
axis equal;
grid on
camlight
lighting gouraud