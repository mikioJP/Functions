function print_tanaka(figurehandle, filename, bgs)
%print_tanaka 普段使いの一括出力
%   1にfigure handle, 2にファイルネームの頭, 3にbackground or not
%   png pdf(イラレ) figをコピー、
if exist("bgs","var")
    if(bgs)
        parfeval(@print, 0, figurehandle, strcat(filename,'.png'), "-dpng", "-r250");
        parfeval(@print, 0, figurehandle, strcat(filename,'.pdf'), "-dpdf", "-painters");
        parfeval(@savefig, 0, figurehandle, strcat(filename, '.fig'), 'compact');
        
    end
else
    print(figurehandle, strcat(filename,'.png'), "-dpng", "-r250");
    print(figurehandle, strcat(filename,'.pdf'), "-dpdf", "-painters");
    savefig(figurehandle, strcat(filename, '.fig'), 'compact');
end


end

