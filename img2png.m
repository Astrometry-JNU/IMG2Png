% ����ת��IMG�ļ�Ϊpngͼ���ļ�
% sourDirΪIMG�ļ������ļ��У�destDirΪpngͼ���ļ�����ļ��У�����ʵ����������޸�
% �����Ҫ����ͼ��δ�����ԭʼ�Ҷ�ֵ��Ϣ��ȡ�������� sava ��ע��
% �����Ҫ�ڱ����pngͼ���ļ������������Ϣ��ȡ�������� imgPixels = insertText ��ע��

clear;clc;
tic;

sourDir = 'D:\temp\temp';                           % IMG�ļ������ļ���·��
destDir = 'D:\temp\dest';                           % ���pngͼ���ļ����ļ���·��
mkdir(destDir);                                     % ��������ļ���

IMG = ls([sourDir, '\*.IMG']);                      % ����.IMG�ļ�
temp = repmat([sourDir, '\'], size(IMG, 1), 1);     % ����·���ľ���
IMGFull = [temp, IMG];                              % ��װ�ɴ�������·�����ļ��б�


for k = 1 : size(IMGFull, 1)                        % ����ÿ��ͼ��
    [imgPixels,vicarProperty] = vicarread(deblank(IMGFull(k, :)));      % ��ȡͼ��ĻҶ�ֵ������
    imgPixels = double(imgPixels);                  % ��ȡ�������ͳһת����double����
    
%     save([destDir, '\', strrep(deblank(IMG(k, :)), 'IMG', 'mat')], 'imgPixels');        % ��ͼ��ԭʼ�Ҷ�ֵ����Ϊ.mat��ʽ
    
    imgPixels = log(imgPixels+1);                   % �����任��ѻҶ�ֵ��Χ����ӳ�䵽0-1��doubleͼ��ĻҶ�ֵ��ΧΪ0-1��
    imgPixels = imgPixels - min(imgPixels(:));
    imgPixels = imgPixels / max(imgPixels(:));
    
    % ��ͼ�������������Ϣ�����ع�ʱ�䣩�����ڿ��ٸ���������Ϣɸѡͼ��
%     imgPixels = insertText(imgPixels,[0, 0], ['ED: ', num2str(vicarProperty.EXPOSURE_DURATION/1000), 's'], ...
%         'FontSize', 30, 'BoxColor', 'cyan');

    imwrite(imgPixels, [destDir, '\', strrep(deblank(IMG(k, :)), 'IMG', 'png')])            % ����ͼ��
end


toc;