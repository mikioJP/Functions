function MatrixFigure(figurenumbers, clearflag)
%MATRIXFIGURE Figure�𐮗񂷂�B
%   figurenumbers�ɐ����̔z�������B
%   clearflag = true��figure���������B
if ~exist('clearflag', 'var')
    clearflag = false; 
end
for fn = 1:length(figurenumbers)
   f = figure(figurenumbers(fn));
   if(clearflag)
       clf(f);
   end
   x = ceil(fn/2) - 1;
   y = mod(fn, 2);
   
   f.Position(1) = -1920 + 640 * x;
   f.Position(2) = 520 * y;
end
end

