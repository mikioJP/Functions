%% ����f�[�^�̖�����
% sample[�ԍ�]-[�v�������ꏊ�̔ԍ�]_[�f�[�^���((ex)raman or PL)].txt
% sample[�ԍ�]-[�v�������ꏊ�̔ԍ�].png

%% PowerPoint���J��
h = actxserver('PowerPoint.Application');
% PowerPoint�̃E�B���h�E�\���i�o���h���̊m�F�p�j
h.Visible = 1; 

%% �v���[���e�[�V������ǉ�
h.Presentation.invoke;
Presentation = h.Presentation.Add;

%% �J�X�^�����C�A�E�g�ǂݍ���
titleSlide = Presentation.SlideMaster.CustomLayouts.Item(1);
blankSlide = Presentation.SlideMaster.CustomLayouts.Item(6);

%% �^�C�g���y�[�W�ǉ�
Slide1 = Presentation.Slides.AddSlide(1,titleSlide);
Slide1.Shapes.Title.TextFrame.TextRange.Text = '����_�����̂Ŏ�����';

%% 2�y�[�W�ڈȍ~�A�C���[�W��`��

foldername = "[foldername]";
scalebar_filename = which(x100scalebar.bmp);

%�t�@�C�������X�g�쐬
FL = dir(foldername + "\*.txt");
n = length(FL);
Filename_list = strings(n);
for i = 1:n
    FL(i).name = erase(FL(i).name,'_raman.txt');
    FL(i).name = erase(FL(i).name,'_PL.txt');
    FL(i).name = erase(FL(i).name,'.txt');
    Filename_list(i) = FL(i).name;
end
%Filename_list = unique(Filename_list);

%���O���X�g�̏d�����폜
for i = 1:n
    checkfile = Filename_list(i);
    for j = i+1:n
        if(Filename_list(j) == checkfile)
            Filename_list(j) = [];
            n=n-1;
        end
    end
end
filetypes = ["_raman.txt", "_PL.txt", ".png"];

%�O���t���v���b�g��ppt�ɏo��
for nn = 1:n
    if(contains( Filename_list(nn), 'correction'))
            continue;
        end
    newslide = Presentation.Slides.AddSlide(2,blankSlide);
    newslide.Shapes.Title.TextFrame.TextRange.Text = Filename_list(nn);
    for mm = 1:3
        ffilename = fullfile(foldername, Filename_list(nn)+filetypes(mm));
        if(exist(ffilename, 'file')==2)
         switch mm
             case 1 %raman
                a = readmatrix(ffilename);
                f = clf(figure(1));
                wavenumber = a(:,1);
                intensity = a(:,2);
        
                plot(wavenumber, intensity, 'r');
                xlabel("Raman Shift (cm^{-1})");
                axis tight;
                ylabel("Intensity (count)");
                title(Filename_list(nn),'Interpreter','none');
                FigSeikei();
                print(f,'-dmeta','-r150');
                Image1 = newslide.Shapes.Paste;
                set(Image1, 'Left', 66); % �ʒu�A�傫���Z�b�g
                set(Image1, 'Top', 176);
                set(Image1, 'Width', 300);
                set(Image1, 'Height',300);
            case 2 %PL
                a = readmatrix(ffilename);
                f = clf(figure(1));
                wavenumber = a(:,1);
                intensity = a(:,2);
                
                plot(Wavelength2Energy(Wavenumber2Wavelength(wavenumber, 532)), intensity, 'r');
                xlabel("Energy (eV)");
                axis tight;
                ylabel("Intensity (count)");
                title(Filename_list(nn),'Interpreter','none');
                FigSeikei();

                print(f,'-dmeta','-r150');
                Image2 = newslide.Shapes.Paste;
                set(Image2, 'Left',465);
                set(Image2, 'Top', 176);
                set(Image2, 'Width', 300);
                set(Image2, 'Height', 300);
            case 3 %png
                Image3 = newslide.Shapes.AddPicture(ffilename,'msoFalse','msoTrue',701,10,240,180);
                
                Image4 = newslide.Shapes.AddPicture(scalebar_filename,'msoFalse','msoTrue',893,176,48,12);
         end
        end
    end

    % Text �}�� (Left, Top, Width, Height �� TextBox �̈ʒu�ƃT�C�Y)
    tmp = newslide.Shapes.AddTextbox('msoTextOrientationHorizontal',235,495,400,70);
    tmp.TextFrame.TextRange.Text = 'raman';
    tmp = newslide.Shapes.AddTextbox('msoTextOrientationHorizontal',650,495,400,70);
    tmp.TextFrame.TextRange.Text = 'PL';
   
    
%     print_tanaka(f, replace(ffilename, ".txt", ""));
end
%% �v���[���e�[�V������ۑ�
Presentation.SaveAs([foldername '\ExamplePresentation.pptx']);

%% PowerPoint�����
h.Quit;
h.delete;