
function Flowplot3dPlay(flow, scale, aspect,border, name,labelstring)
%Flowplot3d(image, name)
%Where:
% image: 12x12 flow data to be ploted
% title: Plot title
%
%Version: 2.0 @ 26 jun 2016
%Luis Botton (luis.botton@gmail.com)
%UTFPR / CPGEI

[~, ~, k] = size(flow);

plot = zeros(14,14,k);

for k = 1: 100 : 20000
    %Load plot mask
    load('MaskNaN.mat');
    plot(:,:,k) = MaskNaN;

    for i = 2: 13 % insert 12x12 flow data into 14x14 plot mask
        for j = 2:13

            if isnan(flow(i-1,j-1,k))
                flow(i-1,j-1,k) = 0;
            end
            plot(i,j,k) = flow(i-1,j-1,k) .* MaskNaN(i,j);
        end
    end

     %interpolation for artifac elimination

    plot(2,10,k) = (plot(2,9,k)+plot(3,10,k)+plot(3,11,k))/3;
    plot(3,12,k) = (plot(4,11,k)+plot(4,12,k)+plot(3,11,k))/3;
    plot(4,13,k) = (plot(3,12,k)+plot(4,12,k)+plot(5,12,k))/3;
    plot(4,13,k) = (plot(3,12,k)+plot(4,12,k)+plot(5,12,k))/3;
    plot(5,13,k) = (plot(4,12,k)+plot(4,13,k)+plot(5,12,k)+plot(6,12,k)+plot(6,13,k))/5;
    plot(6,14,k) = (plot(5,13,k)+plot(6,13,k)+plot(7,13,k))/3;
    plot(7,14,k) = (plot(6,13,k)+plot(7,13,k)+plot(8,13,k)+plot(6,14,k))/4;
    plot(8,14,k) = (plot(7,13,k)+plot(8,13,k)+plot(9,13,k)+plot(7,14,k))/4;
    plot(9,14,k) = (plot(8,13,k)+plot(9,13,k)+plot(8,14,k))/3;
    plot(10,2,k) = (plot(9,2,k)+plot(10,3,k)+plot(9,3,k)+plot(11,3,k))/4;
    plot(10,13,k) = (plot(9,12,k)+plot(9,13,k)+plot(10,12,k)+plot(11,12,k))/4;
    plot(10,14,k) = (plot(9,12,k)+plot(9,13,k)+plot(10,13,k))/3;
    plot(11,13,k) = (plot(10,12,k)+plot(10,13,k)+plot(11,12,k))/3;
    plot(12,3,k) = (plot(11,3,k)+plot(11,4,k)+plot(12,4,k))/3;
    plot(12,12,k) = (plot(11,11,k)+plot(11,12,k)+plot(11,13,k)+plot(12,11,k))/4;
    plot(12,13,k) = (plot(11,12,k)+plot(11,13,k)+plot(12,12,k))/3;
    plot(13,4,k) = (plot(12,3,k)+plot(12,4,k)+plot(12,5,k))/3; %*
    plot(13,5,k) = (plot(12,4,k)+plot(12,5,k)+plot(12,6,k)+plot(13,4,k)+plot(13,6,k))/5;
    plot(13,10,k) = (plot(12,10,k)+plot(12,11,k)+plot(12,12,k)+plot(13,10,k))/4;
    plot(13,11,k) = (plot(12,9,k)+plot(12,10,k)+plot(12,11,k)+plot(13,9,k))/4;
    plot(13,12,k) = (plot(12,11,k)+plot(12,12,k)+plot(12,13,k)+plot(13,11,k))/4;%*
    plot(14,6,k) = (plot(13,5,k)+plot(13,6,k)+plot(13,7,k))/3;
    plot(14,7,k) = (plot(13,6,k)+plot(13,7,k)+plot(13,8,k)+plot(14,6,k))/4;
    plot(14,8,k) = (plot(13,7,k)+plot(13,8,k)+plot(13,9,k)+plot(14,7,k))/4;%*
    plot(14,9,k) = (plot(13,8,k)+plot(13,9,k)+plot(13,10,k)+plot(14,8,k))/4;
    plot(14,10,k) = (plot(13,9,k)+plot(13,10,k)+plot(13,11,k)+plot(14,9,k))/4;


    %Plot
    f= figure(777);
    f.Color = [0.7 0.7 0.7];

    [x,y] = meshgrid(0:13,0:13);

    [xq,yq] = meshgrid(0:scale:13,0:scale:13);
    plotq = interp2(x,y,plot(:,:,k),xq,yq); %nearest linear spline cubic
    
    Co = plotq;
    s=surf(xq,flipud(yq),plotq,Co);
    s.FaceColor = aspect; %faceted %interp %[flat interp]
    s.EdgeColor = border; %Control visualization of Matrix borders
    s.FaceLighting = 'gouraud';

    t=title(name);
    t.FontSize=12;
    
    %Color bar configuration
        colormap jet
        c=colorbar('EastOutside');
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
        view([-25 10])
        drawnow
        pause(0.25);
 end
end