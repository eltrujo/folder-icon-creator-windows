%%% $Date: Thu Jul 20 21:31:20 2017
%%% $Author: github.com/eltrujo

%% Create PNG picture
imageName = 'example.jpg'; % JPG image name (must be inside folderPath)
folderPath = 'C:\Users\eltrujo\Documents\MyFolder\'; % Folder whose icon will be changed

name = imageName(1:length(imageName)-4);
IM = imread([folderPath imageName],'jpg');
IM = double(IM);
IM = IM./255;
[nf,nc,np] = size(IM);
M = zeros(nf,nf,np);
alpha = zeros(nf,nf); % Alpha mask: transparent pixels
if rem(nf-nc,2) ~= 0
    dist1 = floor((nf-nc)/2);
else
    dist1 = (nf-nc)/2;
end
for i = 1:nf
    for j = 1:nf
        for k = 1:np
            if j <= dist1 || j > dist1+nc
                M(i,j,k) = 1;
            else
                M(i,j,k) = IM(i,j-dist1,k);
                alpha(i,j) = 1;
            end
        end
    end
end
M = 255.*M;
M_final = uint8(M);
pngName = [name '.png'];
imwrite(M_final,[folderPath pngName],'png','Alpha',alpha);


%% Create ICO file from Python, if favicon.ico doesn't exist
if exist([folderPath 'favicon.ico'],'file') == 0
    try
        py.CreateICO.CreateICO(folderPath,pngName)
        disp('Icon created')
    catch
        disp('Icon NOT created')
    end
end
%% Set ICO picture as folder icon, if it extists
if exist([folderPath 'favicon.ico'],'file') ~= 0
    oldname = [folderPath 'desktop.txt'];
    textId = fopen(oldname,'wt');
    text = {};
    text{1} = '[.ShellClassInfo]\n';
    text{2} = 'IconResource=favicon.ico,0\n';
    text{3} = '[ViewState]\n';
    text{4} = 'Mode=\n';
    text{5} = 'Vid=\n';
    text{6} = 'FolderType=Pictures\n';
    for i=1:6
        fprintf(textId,text{i});
    end
    fclose(textId);
    delete([folderPath 'desktop.ini']);
    newname = [folderPath 'desktop.ini'];
    movefile(oldname,newname,'f');
    fileattrib([folderPath 'desktop.ini'],'+s +h') % Add attributes of: system file & hidden
    fileattrib(folderPath,'-w'); % Set folder as Read-only (delete Write attribute)
end