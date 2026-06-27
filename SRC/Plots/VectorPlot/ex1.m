[x,y,z] = meshgrid(-1:.1:1,-1:.1:1,-3:.1:3);
[u,v,w] = deal(y./sqrt(x.^2+y.^2),-x./sqrt(x.^2+y.^2),1./(cos(z/3)+1));
c = num2cell((rand(2000,3)-.5)*diag([2 2 6]),1);
set(coneplot(x,y,z,u,v,w,c{:},2),'facec',[.2 .7 1],'edgec','n')
axis image, view(3), camlight, lighting gouraud

% 作者：知乎用户
% 链接：https://www.zhihu.com/question/28497819/answer/89015419
% 来源：知乎
% 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。