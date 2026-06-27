

%% Load velocity data
% load('velocidade.mat') %=>aaCOV[12x12]
load('sx.mat') %=>BubbleVg[12x12]
BubbleVg = flipud(BubbleVg);

%%
clf;
[x, y, z] = meshgrid(1:1:12);

%%  Cria os componentes do campo vetorial
u = zeros(12,12,12);         % x-component of vector field
v = zeros(12,12,12);      % y-component of vector field
w = zeros(12,12,12);                       % z-component of vector field

%% v 
% v(1,1,1) = 1;
% v(1,2,1) = 2;
% v(1,3,1) = 3;
% v(1,4,1) = 4;

%% Adiciona informaçoes de velocidade ao campo vetorial
for c1 = 1 : 1 : 12
    for c2 = 1 : 1 : 12
        u(c1,1,c2) = BubbleVg(c2,c1); %aaCOV(c1,c2); %abs( randn(1,1) * (c1+c2)/2) ;
    end
end

% u(1,1,1) = 1;
% u(2,1,1) = 2;
% u(3,1,1) = 3;
% u(4,1,1) = 4;
% u(12,1,12) =1;

%% w esse é ruim

% w(1,1,1) = 1;
% w(2,2,1) = 2;
% w(3,3,1) = 3;
% w(12,12,1) = 4;

%% color
 cores = ones(12,12,12);
 cores = x;

%%
[cx, cy, cz] = meshgrid( 1: 1: 12 );
h = coneplot(x, y, z, u, v, w, cx, cy, cz, 3,cores,'nearest');

%% Change the axes view and set the data aspect ratio.

axis square
% axis off;
xlabel('X')
ylabel('Y')
zlabel('Z')
grid off;
box on;
colormap jet
view([48 12]);

% view(30,40)
% daspect([2,2,1])

%%  Add a light source to the right of the camera and use Gouraud lighting to
% give the cones and slice planes a smooth, three-dimensional appearance.

hcone.DiffuseStrength = 0.8;

camproj perspective;
camzoom(1.0);

light;
lighting phong; % gouraud phong flat none
shading interp; % flat interp faceted
delete(findall(gcf,'Type','light'))
camlight(90,120);