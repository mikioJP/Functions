function print_tanaka(figurehandle, filename)
%print_tanaka ���i�g���̈ꊇ�o��
%   1��figure handle, 2�Ƀt�@�C���l�[���̓�, 3�ɃJ�b�g�̗L��
%   png pdf(�C����) fig���R�s�[�Apng�͒[��؂藎�Ƃ��B
print(figurehandle, strcat(filename,'.png'), "-dpng", "-r250");
print(figurehandle, strcat(filename,'.pdf'), "-dpdf", "-painters");
savefig(figurehandle, strcat(filename, '.fig'), 'compact');

end

