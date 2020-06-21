% 批量转换IMG文件为png图像文件
% sourDir为IMG文件所在文件夹，destDir为png图像文件输出文件夹，根据实际情况进行修改
% 如果需要保存图像未处理的原始灰度值信息，取消代码中 sava 行注释
% 如果需要在保存的png图像文件中添加文字信息，取消代码中 imgPixels = insertText 行注释

clear;clc;
tic;

sourDir = 'D:\temp\temp';                           % IMG文件所在文件夹路径
destDir = 'D:\temp\dest';                           % 输出png图像文件的文件夹路径
mkdir(destDir);                                     % 创建输出文件夹

IMG = ls([sourDir, '\*.IMG']);                      % 搜索.IMG文件
temp = repmat([sourDir, '\'], size(IMG, 1), 1);     % 生成路径的矩阵
IMGFull = [temp, IMG];                              % 组装成带有完整路径的文件列表


for k = 1 : size(IMGFull, 1)                        % 遍历每张图像
    [imgPixels,vicarProperty] = vicarread(deblank(IMGFull(k, :)));      % 读取图像的灰度值和属性
    imgPixels = double(imgPixels);                  % 读取后的数据统一转换成double类型
    
%     save([destDir, '\', strrep(deblank(IMG(k, :)), 'IMG', 'mat')], 'imgPixels');        % 把图像原始灰度值保存为.mat格式
    
    imgPixels = log(imgPixels+1);                   % 对数变换后把灰度值范围线性映射到0-1（double图像的灰度值范围为0-1）
    imgPixels = imgPixels - min(imgPixels(:));
    imgPixels = imgPixels / max(imgPixels(:));
    
    % 在图像上添加文字信息（如曝光时间），用于快速根据数据信息筛选图像
%     imgPixels = insertText(imgPixels,[0, 0], ['ED: ', num2str(vicarProperty.EXPOSURE_DURATION/1000), 's'], ...
%         'FontSize', 30, 'BoxColor', 'cyan');

    imwrite(imgPixels, [destDir, '\', strrep(deblank(IMG(k, :)), 'IMG', 'png')])            % 保存图像
end


toc;