%% 3-D Cone Plot
% Plot velocity vector cones for vector volume data representing motion of
% air through a rectangular region of space.

% Copyright 2015 The MathWorks, Inc.


%%
% Load the data. The |wind| data set contains the arrays |u|, |v|, and |w|
% that specify the vector components and the arrays |x|, |y|, and |z| that
% specify the coordinates. 

load wind

%% Modifica;óes do Lu[is
x = x(1:12, 1:2, 1:12);
y = y(1:12, 1:2, 1:12);
z = z(1:12, 1:2, 1:12);

%% configuração do espaço vetorial
u = u(1:12, 1:2, 1:12);

% u( 2:12 , 1:2, :) = 0;
u(:, :, :) = 0; %bom

v = v(1:12, 1:2, 1:12);

v( 2:12, 1:2, :) = 0;
%v(:, :, :) =0;

w = w(1:12, 1:2, 1:12);

w( 2:12 ,1:2,:) = 0;
%w(:, :, :) =0;

%%
% Calculate the magnitude of the vector field (which represents wind speed)
% to generate scalar data for the |slice| command.


wind_speed = sqrt(u.^2 + v.^2 + w.^2);




%% 
% Establish the range of the data to place the slice planes and to specify
% where you want the cone plots.

xmin = min(x(:));
xmax = max(x(:));
ymin = min(y(:));
ymax = max(y(:));
zmin = min(z(:));

%%
% Define where to plot the cones. Select the full range in |x| and |y| and
% select the range 3 to 15 in |z|.

xrange = linspace(xmin,xmax,12);
yrange = linspace(ymin,ymax,12);
zrange = 1:1:12;
[cx,cy,cz] = meshgrid(xrange,yrange,zrange);

%%
% Plot the cones and set the scale factor to 5 to make the cones larger
% than the default size. 

figure
hcone = coneplot(x,y,z,u,v,w,cx,cy,cz,4, wind_speed);

% hcone = coneplot(x,y,z,u,v,w,cx,cy,cz,2,'quiver');

%%
% Set the cone colors.

% hcone.FaceColor = 'red';
hcone.EdgeColor = 'none';



%%
% Change the axes view and set the data aspect ratio.

axis square
% axis off;
xlabel('X')
ylabel('Y')
zlabel('Z')
grid off;
box on;
colormap jet
view([120 6]);

% view(30,40)
% daspect([2,2,1])

%%
% Add a light source to the right of the camera and use Gouraud lighting to
% give the cones and slice planes a smooth, three-dimensional appearance.

% set(hsurfaces,'AmbientStrength',0.6)
hcone.DiffuseStrength = 0.8;

camproj perspective;
camzoom(1.0);


light;
lighting phong; % gouraud phong flat none
shading interp; % flat interp faceted
delete(findall(gcf,'Type','light'))
camlight(20,90);

%% rotação do gráfico com correção de luz
% h = camlight('left');
% for i = 1:90
%    camorbit(10,0)
%    camlight(h,'left')
%    pause(.1)
% end

%% 
title('Time Averaged interface flow velocity') 


