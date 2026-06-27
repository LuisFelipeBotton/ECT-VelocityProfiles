
function Flowplot3d(image, scale, aspect,border, name,labelstring)
%Flowplot3d(image, scale, aspect,border, name)
%Where:
% image: 12x12 flow data to be ploted
% title: Plot title
%
%Version: 2.2 @ 29 ago 2018
%Luis Botton (luis.botton@gmail.com)
%UTFPR / CPGEI



%Load plot mask
load('MaskNaN.mat');
plot = MaskNaN;



for i = 2: 13 % insert 12x12 flow data into 14x14 plot mask
    for j = 2:13
    
        if isnan(image(i-1,j-1))
            image(i-1,j-1) = 0;
        end
        plot(i,j) = image(i-1,j-1) .* MaskNaN(i,j);
    end
end

 %interpolation for artifac elimination

plot(2,10) = (plot(2,9)+plot(3,10)+plot(3,11))/3;
plot(3,12) = (plot(4,11)+plot(4,12)+plot(3,11))/3;
plot(4,13) = (plot(3,12)+plot(4,12)+plot(5,12))/3;
plot(4,13) = (plot(3,12)+plot(4,12)+plot(5,12))/3;
plot(5,13) = (plot(4,12)+plot(4,13)+plot(5,12)+plot(6,12)+plot(6,13))/5;
plot(6,14) = (plot(5,13)+plot(6,13)+plot(7,13))/3;
plot(7,14) = (plot(6,13)+plot(7,13)+plot(8,13)+plot(6,14))/4;
plot(8,14) = (plot(7,13)+plot(8,13)+plot(9,13)+plot(7,14))/4;
plot(9,14) = (plot(8,13)+plot(9,13)+plot(8,14))/3;
plot(10,2) = (plot(9,2)+plot(10,3)+plot(9,3)+plot(11,3))/4;
plot(10,13) = (plot(9,12)+plot(9,13)+plot(10,12)+plot(11,12))/4;
plot(10,14) = (plot(9,12)+plot(9,13)+plot(10,13))/3;
plot(11,13) = (plot(10,12)+plot(10,13)+plot(11,12))/3;
plot(12,3) = (plot(11,3)+plot(11,4)+plot(12,4))/3;
plot(12,12) = (plot(11,11)+plot(11,12)+plot(11,13)+plot(12,11))/4;
plot(12,13) = (plot(11,12)+plot(11,13)+plot(12,12))/3;
plot(13,4) = (plot(12,3)+plot(12,4)+plot(12,5))/3; %*
plot(13,5) = (plot(12,4)+plot(12,5)+plot(12,6)+plot(13,4)+plot(13,6))/5;
plot(13,10) = (plot(12,10)+plot(12,11)+plot(12,12)+plot(13,10))/4;
plot(13,11) = (plot(12,9)+plot(12,10)+plot(12,11)+plot(13,9))/4;
plot(13,12) = (plot(12,11)+plot(12,12)+plot(12,13)+plot(13,11))/4;%*
plot(14,6) = (plot(13,5)+plot(13,6)+plot(13,7))/3;
plot(14,7) = (plot(13,6)+plot(13,7)+plot(13,8)+plot(14,6))/4;
plot(14,8) = (plot(13,7)+plot(13,8)+plot(13,9)+plot(14,7))/4;%*
plot(14,9) = (plot(13,8)+plot(13,9)+plot(13,10)+plot(14,8))/4;
plot(14,10) = (plot(13,9)+plot(13,10)+plot(13,11)+plot(14,9))/4;


%Plot
f= figure();
f.Color = [0.7 0.7 0.7];

[x,y] = meshgrid(0:13,0:13);

[xq,yq] = meshgrid(0:scale:13,0:scale:13);
plotq = interp2(x,y,plot,xq,yq); %nearest linear spline cubic

%s=surf(x,flipud(y),plot);

Co = plotq;
s=surf(xq,flipud(yq),plotq,Co);

colormap jet
s.FaceColor = aspect; %faceted %interp %[flat interp]
s.EdgeColor = border; %Control visualization of Matrix borders
s.FaceLighting = 'gouraud';


    
    t=title(name);
    t.FontSize=12;


%Color bar configuration
    c = colorbar('EastOutside');
 
    c.FontSize = 12;
    c.FontWeight = 'bold';
    c.Label.String = labelstring;
    
    ticks = min(min(plotq)) : max(max(plotq))/6 : max(max(plotq));
    c.Ticks = ticks;
    L=cellfun(@(x)sprintf('%.2f',x),num2cell(get(c,'xtick')),'Un',0);
    set(c,'xticklabel',L)
    

direction = [1 0 0];
rotate(s,direction,90)

%Axis configuration
    axis square 
    axis tight
    axis off
 
   
end