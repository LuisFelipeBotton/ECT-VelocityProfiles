%% 3-D Cone Plot
% Plot velocity vector cones for vector volume data representing motion of
% air through a rectangular region of space.

% Copyright 2015 The MathWorks, Inc.


%%
load('velocidade.mat')
max_vel = max(aaCOV(:));


%% cria os vetores x,y,z que especificam as coordenadas
 
 x = zeros(12,12,2);
 y = x;
 z = ones(12,12,2);

 x(:,1,1) = ones(12,1);
 x(:,2,1) = 12 .* x(:,1,1);
 for count1 = 2 : 1 : 2
     x(:, :, count1) = x(:, :, 1);
 end
 
 y(:,1,1) = linspace(1,12,12)';
 y(:,2,1) = linspace(1,12,12)';
 for count2 = 2 : 1 : 2
     y(:,:, count2) = y(:,:,1);
 end
 
 z(:,1,1) = ones(12,1);
 z(:,2,1) = z(:,1,1);
 for count3 = 2 : 1 : 2
     z(:, :, count3) = count3 .* z(:, : ,1);
 end
 
%% configuração do espaço vetorial
u = x;
v = y;
w = z;




%% Calculate the magnitude of the vector field (which represents wind speed)
% to generate scalar data for the |slice| command.

wind_speed = sqrt(u.^2 + v.^2 + w.^2); %aaCOV





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

xrange = linspace(1,12,12);
yrange = linspace(1,12,12);
zrange = 1:1:1;
[cx,cy,cz] = meshgrid(xrange,yrange,zrange);

%%
% Plot the cones and set the scale factor to 5 to make the cones larger
% than the default size. 

figure
hcone = coneplot(u,v,w,cx,cy,cz,2, wind_speed);

%%
% Set the cone colors.
hcone.EdgeColor = 'none';



%% Change the axes view and set the data aspect ratio.

axis square
% axis off;
xlabel('X')
ylabel('Y')
zlabel('Z')
grid off;
box on;
colormap jet
view([320 60]);

% view(30,40)
% daspect([2,2,1])

%%
% Add a light source to the right of the camera and use Gouraud lighting to
% give the cones and slice planes a smooth, three-dimensional appearance.

% set(hsurfaces,'AmbientStrength',0.6)
% hcone.DiffuseStrength = 0.8;

camproj perspective;
camzoom(1);


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


