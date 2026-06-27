
%% A PROPOSITO DI SCRIPT 
%BY: LUÍS FELIPE BOTTON (luis.botton@gmail.com)
%TO: UTFPR-CPGEI / LASII-NUEM
%VER. 1.8 - MAG-2019

%% CARICARE DATI DI VELOCITÀ 
% load('velocidade.mat') %=>aaCOV[12x12]
% BubbleVg = aaCOV;


load('D:\LuísFelipe\UTFPR-Cloud\__MasterThesis\_Passo4\ProcessedData\NBP\NUEm_1in_Processed_NBP.mat', 'VelocityImages');
BubbleVg = reshape(VelocityImages(:,7,1),12,12); %Da 1 a 413


% load('sx.mat') %=>BubbleVg[12x12]
 

BubbleVg = flipud(BubbleVg);

%% DEFINIRE LE COORDINATE PER IL CAMPO VETTORIALE. 
clf;
[x, y, z] = meshgrid(1:1:12);

%% DEFINIRE IL CAMPO VETTORIALE. 
u = zeros(12,12,12);         % x-component of vector field
v = zeros(12,12,12);      % y-component of vector field
w = zeros(12,12,12);                       % z-component of vector field

%% AGGIUNGI INFORMAZIONI SULLA VELOVITÀ AL CAMPO VETTORIALE. 
for c1 = 1 : 1 : 12
    for c2 = 1 : 1 : 12
        u(c1,6,c2) = BubbleVg(c2,c1); %aaCOV(c1,c2); %abs( randn(1,1) * (c1+c2)/2) ;
    end
end

%% IMPOSTA LA DISTRIBUIZIONE DEL COLORE. 
 cores = ones(12,12,12); 
 cores = u;

%% CREA IL GRAFICO. 
[cx, cy, cz] = meshgrid( 1: 1: 12 );
h = coneplot(x, y, z, u, v, w, cx, cy, cz,3,cores,'nearest');
title('Time Averaged cross-section Interface velocity`')

%% CAMBIA LA VISTA DEGLI ASSI E IMPOSTA LE PROPORZIONI DEI DATI. 

axis square
axis off;
xlabel('X')
ylabel('Y')
zlabel('Z')
grid off;
% box on;
colormap jet %parula HSV cool
view([62 12]);
colorbar 'EastOutside' 
 daspect([2,2,2])
 
 %% fare i limiti della barra dei colori e la sua configurazione delle proporzioni tick

%% AGGIUNGI UNA FONTE DI LUCE E UNA VISTA DELLA VIDEOCAMERA. 

h.DiffuseStrength = 0.8;
camproj perspective;
camzoom(1.5);
light;
lighting phong; % gouraud phong flat none
shading interp; % flat interp faceted
delete(findall(gcf,'Type','light'))
camlight(90,120);