classdef IMAGE_EDITOR < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure          matlab.ui.Figure
        Panel             matlab.ui.container.Panel
        pushbutton1       matlab.ui.control.Button
        pushbutton2       matlab.ui.control.Button
        pushbutton3       matlab.ui.control.Button
        pushbutton4       matlab.ui.control.Button
        pushbutton5       matlab.ui.control.Button
        pushbutton6       matlab.ui.control.Button
        pushbutton7       matlab.ui.control.Button
        pushbutton8       matlab.ui.control.Button
        axes1             matlab.ui.control.UIAxes
        axes2             matlab.ui.control.UIAxes
        text11            matlab.ui.control.Label
        Panel_3           matlab.ui.container.Panel
        pushbutton10      matlab.ui.control.Button
        pushbutton9       matlab.ui.control.Button
        pushbutton15      matlab.ui.control.Button
        pushbutton16      matlab.ui.control.Button
        pushbutton24      matlab.ui.control.Button
        pushbutton33      matlab.ui.control.Button
        pushbutton33_2    matlab.ui.control.Button
        uibuttongroup16   matlab.ui.container.ButtonGroup
        text2             matlab.ui.control.Label
        text3             matlab.ui.control.Label
        text4             matlab.ui.control.Label
        Slider_3Label     matlab.ui.control.Label
        Slider_3          matlab.ui.control.Slider
        Slider_4Label     matlab.ui.control.Label
        Slider_4          matlab.ui.control.Slider
        Slider_5Label     matlab.ui.control.Label
        Slider_5          matlab.ui.control.Slider
        uibuttongroup8_2  matlab.ui.container.ButtonGroup
        pushbutton21      matlab.ui.control.Button
        pushbutton22      matlab.ui.control.Button
        pushbutton20      matlab.ui.control.Button
        pushbutton23      matlab.ui.control.Button
        text7             matlab.ui.control.Label
        text5             matlab.ui.control.Label
        text6             matlab.ui.control.Label
        uibuttongroup8_3  matlab.ui.container.ButtonGroup
        pushbutton12      matlab.ui.control.Button
        pushbutton13      matlab.ui.control.Button
        pushbutton14      matlab.ui.control.Button
        uibuttongroup8_4  matlab.ui.container.ButtonGroup
        pushbutton17      matlab.ui.control.Button
        pushbutton18      matlab.ui.control.Button
        pushbutton19      matlab.ui.control.Button
        uibuttongroup8_5  matlab.ui.container.ButtonGroup
        pushbutton26      matlab.ui.control.Button
        pushbutton26_2    matlab.ui.control.Button
        pushbutton26_3    matlab.ui.control.Button
        pushbutton26_4    matlab.ui.control.Button
        pushbutton30      matlab.ui.control.Button
        pushbutton32      matlab.ui.control.Button
        pushbutton9_2     matlab.ui.control.Button
        text5_2           matlab.ui.control.Label
        text11_2          matlab.ui.control.Label
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: pushbutton1
        function uploadimage(app, event)
            [FileName,PathName]=uigetfile({'*.*'},'choose a image file');
            imshow(fullfile(PathName,FileName),'Parent',app.axes1);
        end

        % Button pushed function: pushbutton2
        function rgb2gray(app, event)
            R=getimage(app.axes1);
            [rows,columns,ColorChannels]=size(R);
            if ColorChannels>1
                R_gray=rgb2gray(R);
            else
                R_gray=R;
            end
            imshow(R_gray,'Parent',app.axes2);
            
        end

        % Button pushed function: pushbutton3
        function rgb2hsvconverter(app, event)
            A=getimage(app.axes1);
            [rows,columns,numberOfColorChannels] = size(a);
            if numberOfColorChannels ==3
                A_hsv = rgb2hsv(A);
            else
                error = errordlg('It is a gray scale image','image Error');
                imshow(error,'Parent',app.axes2);
            end
            imshow(A_hsv,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton4
        function binaryimageconverter(app, event)
            C=getimage(app.axes1);
            [rows,columns,ColorChannels]=size(C);
            if ColorChannels>1
                C_gray=rgb2gray(C);
            else
                C_gray=C;
            end
            C_gray=im2double(C_gray);
            H=graythresh(C_gray);
            N=im2bw(C_gray,H);
            imshow(N,'Parent',app.axes2);   
        end

        % Button pushed function: pushbutton5
        function SHARPNESS(app, event)
            C=getimage(app.axes1);
            sharp=imsharpen(C,'Amount',3);
            imshow(sharp,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton6
        function whitebalancer(app, event)
            a=getimage(app.axes1);
            [rows,columns, ColorChannels] = size(a);
            if ColorChannels > 1
                a_gray=rgb2gray(a);
            else
                a_gray = a; 
            end
            redChannel=a(:,:,1);
            greenChannel = a(:,:,2); 
            blueChannel = a(:,:,3);
            meanR= mean2(redChannel);
            meanG= mean2(greenChannel);
            meanB= mean2(blueChannel);
            meanGray= mean2(a_gray);
            redChannel = uint8(double (redChannel) *meanGray/meanR);
            greenChannel = uint8(double(greenChannel)*meanGray/meanG);
            blueChannel = uint8(double(blueChannel) *meanGray/meanB); 
            rgbImage_1 = cat(3, redChannel, greenChannel, blueChannel);
            imshow(rgbImage_1, 'Parent',app.axes2);
        end

        % Button pushed function: pushbutton7
        function grayadjuster(app, event)
            r=getimage(app.axes1);
            [rows,columns, ColorChannels] = size(r);
            if ColorChannels > 1
                a_gray=rgb2gray(r);
            else
                a_gray = r; 
            end
            gray_adjust=imadjust(a_gray);
            imshow(gray_adjust,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton8
        function coloradjuster(app, event)
            s=getimage(app.axes1);
             [rows,columns, ColorChannels] = size(s);
            if ColorChannels ==3
                redChannel=s(:,:,1);
                greenChannel = s(:,:,2); 
                blueChannel = s(:,:,3);
                adjust_R=imadjust(redChannel);
                adjust_G=imadjust(greenChannel);
                adjust_B=imadjust(blueChannel);
            else
                error=errordlg('grayscale image','image error');
                imshow(error,'Parent',app.axes2);
            end
            color_adjuster=cat(3,adjust_R,adjust_G,adjust_B);
            imshow(color_adjuster,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton9
        function histogram(app, event)
            a=getimage(app.axes1);
            imhist(a);
            axis auto;
            axes(app.axes2);
            [counts,binlocations]=imhist(a);
            stem(app.axes2,binlocations,counts);
        end

        % Button pushed function: pushbutton10
        function histeq(app, event)
            r=getimage(app.axes1);
            [rows,columns, ColorChannels] = size(r);
            if ColorChannels==3
               hsv=rgb2hsv(r);
               value=hsv(:,:,3);
               value_1=histeq(value);
               hsv(:,:,3)=value_1;
               rgb=hsv2rgb(hsv);
               imshow(rgb,'Parent',app.axes2);
            else colorchannels == 0
                gray=histeq(a);
                imshow(gray,'Parent',app.axes2);
            end
        end

        % Button pushed function: pushbutton24
        function compimg(app, event)
            a=getimage(app.axes1);
            compimg=imcomplement(a);
            imshow(compimg,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton15
        function clockwise(app, event)
            a=getimage(app.axes1);
            rotate=imrotate(a,-90);
            imshow(rotate,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton16
        function anticlockwise(app, event)
            a=getimage(app.axes1);
            rotate=imrotate(a,90);
            imshow(rotate,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton20
        function avgfilter(app, event)
            a=getimage(app.axes1);
            avg= fspecial('average',3); 
            avgfilt=imfilter (a,avg);
            imshow(avgfilt,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton21
        function gaussfilter(app, event)
            a=getimage(app.axes1);
            gauss= fspecial('gaussian',3); 
            gaussfilt=imfilter (a,gauss);
            imshow(gaussfilt,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton22
        function medfilter(app, event)
            a=getimage(app.axes1);
            [rows, columns, ColorChannels] = size(a);
            if ColorChannels == 3
                redchannel = a(:,:,1);
                greenChannel = a(:,:,2);
                blueChannel = a(:,:,3);
                med_filtR= medfilt2(redchannel);
                med_filtG= medfilt2(greenChannel);
                med_filtB = medfilt2(blueChannel);
                median_filtrgb = cat(3, med_filtR, med_filtG, med_filtB);
                imshow(median_filtrgb, 'Parent',app.axes2);
            else ColorChannels == 0
                median_filtgray = medfilt2(a);
                imshow(median_filtgray, 'Parent',app.axes2);
            end
        end

        % Button pushed function: pushbutton23
        function guidedfilt(app, event)
            a=getimage(app.axes1);
            g=imguidedfilter(a);
            imshow(g,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton12
        function prewittedge(app, event)
            a=getimage(app.axes1);
            [rows,columns, ColorChannels] = size(a);
            if ColorChannels > 1
                a_gray=rgb2gray(a);
            else
                a_gray = a; 
            end
            prewittedge=edge(a_gray,'prewitt');
            imshow(prewittedge,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton13
        function sobeledge(app, event)
             a=getimage(app.axes1);
            [rows,columns, ColorChannels] = size(a);
            if ColorChannels > 1
                a_gray=rgb2gray(a);
            else
                a_gray = a; 
            end
            sobeledge=edge(a_gray,'sobel');
            imshow(sobeledge,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton14
        function cannyedge(app, event)
             a=getimage(app.axes1);
            [rows,columns, ColorChannels] = size(a);
            if ColorChannels > 1
                a_gray=rgb2gray(a);
            else
                a_gray = a; 
            end
            cannyedge=edge(a_gray,'canny');
            imshow(cannyedge,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton17
        function gaussnoise(app, event)
             a=getimage(app.axes1);
             gaussnoise=imnoise(a,"gaussian");
             imshow(gaussnoise,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton18
        function specklenoise(app, event)
            a=getimage(app.axes1);
             specklenoise=imnoise(a,"speckle");
             imshow(specklenoise,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton19
        function saltpeppernoise(app, event)
            a=getimage(app.axes1);
             saltpeppernoise=imnoise(a,"salt & pepper");
             imshow(saltpeppernoise,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton26
        function sepiacolor(app, event)
            a=getimage(app.axes1);
            [rows, columns, noOfColorChannels] = size(a)
            if noOfColorChannels == 3
                b=im2double(a);
                redChannel = b(:,:,1);
                greenChannel = b(:,:,2);
                blueChannel = b(:,:,3);
                red_R = (redChannel.*0.393 + greenChannel.*0.769 + blueChannel .*0.189);
                green_G = (redChannel.*0.349 + greenChannel.*0.686 + blueChannel .*0.168);
                blue_B = (redChannel.*0.272 + greenChannel.*0.534 + blueChannel .*0.131);
                sepia_effect = cat(3, red_R, green_G, blue_B);
                imshow(sepia_effect,'Parent',app.axes2);
           else
                error = errordlg('It is a gray scale image','image Error');
                imshow(error,'Parent',app.axes2);
            end
        end

        % Button pushed function: pushbutton30
        function vivid(app, event)
            a=getimage(app.axes1);
            a_hsv=rgb2hsv(a);
            hChannel = a_hsv(:,:,1); 
            sChannel = a_hsv(:,:,2);
            vChannel = a_hsv (:,:,3);
            sChannel = sChannel * 2;
            a_hsv = cat(3,hChannel,sChannel,vChannel)            
            rgb_vivid = hsv2rgb(a_hsv);
            imshow(rgb_vivid, 'Parent',app.axes2);
        end

        % Button pushed function: pushbutton26_2
        function red(app, event)
            a=getimage(app.axes1);
            [rows,columns, ColorChannels] = size(a);
            if ColorChannels ==3
                a(:,:,2)=0;
                a(:,:,3)=0;
            imshow(a,'Parent',app.axes2);
            else
                error=erroedlg('grayscale image','image error');
                imshow(error,'Parent',app.axes2);
            end
        end

        % Button pushed function: pushbutton26_3
        function green(app, event)
             a=getimage(app.axes1);
            [rows,columns, ColorChannels] = size(a);
            if ColorChannels ==3
                a(:,:,1)=0;
                a(:,:,3)=0;
            imshow(a,'Parent',app.axes2);
            else
                error=erroedlg('grayscale image','image error');
                imshow(error,'Parent',app.axes2);
            end
        end

        % Button pushed function: pushbutton26_4
        function blue(app, event)
             a=getimage(app.axes1);
             [rows,columns, ColorChannels] = size(a);
            if ColorChannels ==3
                a(:,:,1)=0;
                a(:,:,2)=0;
            imshow(a,'Parent',app.axes2);
            else
                error=erroedlg('grayscale image','image error');
                imshow(error,'Parent',app.axes2);
            end
        end

        % Button pushed function: pushbutton32
        function motion(app, event)
             a=getimage(app.axes1);
             a_motion = fspecial('motion', 80, 180);
             MotionBlur = imfilter (a,a_motion, 'replicate');            
             imshow (MotionBlur, 'Parent',app.axes2);
        end

        % Callback function
        function resetbutton(app, event)
            app.UIFigure. Visible = 'off'; 
            app2();
            close (app.UIFigure);
        end

        % Value changed function: Slider_3
        function contrastadjuster(app, event)
            a=getimage(app.axes1);
            contrastFactor = app.Slider_3.Value;
            newimage = uint8(double(a)*contrastFactor);
            imshow(newimage,[0, 255],'Parent',app.axes2);
        end

        % Value changed function: Slider_4
        function brightness(app, event)
            a=getimage(app.axes1);
            brightnessFactor=app.Slider_4.Value;
            newimage = uint8(double(a)+brightnessFactor);
            imshow(newimage,[0, 255], 'Parent',app.axes2);
        end

        % Value changed function: Slider_5
        function saturationadjuster(app, event)
            g=getimage(app.axes1);
            a_hsv=rgb2hsv(g); 
            saturationfactor= app.Slider_5.Value;
            a_hsv(:,:,2)= a_hsv(:,:,2)*1.2+saturationfactor;
            a_rgb= hsv2rgb(a_hsv);
            imshow(a_rgb,[0, 255], 'Parent',app.axes2);            
        end

        % Button pushed function: pushbutton9_2
        function boundaryextraction(app, event)
            a=getimage(app.axes1);
            [rows, columns,ColorChannels] = size(a);
            if ColorChannels > 1
                a_gray = rgb2gray(a);
            else 
                a_gray =a;
            end
            a_bin = im2bw(a_gray);
            se=strel('disk',3);
            a_dilate=imdilate(a_bin,se);
            a_bound=a_dilate-a_bin;
            imshow(a_bound,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton33
        function save(app, event)
           axes(app.axes2);
           [FileName, PathName] = uiputfile({'*.*'},'Save output as');
           Name = fullfile(PathName, FileName);
           exportgraphics(app.axes2,Name);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [1 2 1517 806];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.Scrollable = 'on';

            % Create Panel
            app.Panel = uipanel(app.UIFigure);
            app.Panel.BackgroundColor = [0.8314 0.8314 0.8314];
            app.Panel.Position = [1 184 258 598];

            % Create pushbutton1
            app.pushbutton1 = uibutton(app.Panel, 'push');
            app.pushbutton1.ButtonPushedFcn = createCallbackFcn(app, @uploadimage, true);
            app.pushbutton1.Tag = 'pushbutton1';
            app.pushbutton1.BackgroundColor = [0 0.502 0.5059];
            app.pushbutton1.FontName = 'Arial';
            app.pushbutton1.FontSize = 16;
            app.pushbutton1.FontWeight = 'bold';
            app.pushbutton1.FontColor = [1 1 1];
            app.pushbutton1.Position = [44 517 171.98 49.99];
            app.pushbutton1.Text = 'UPLOAD IMAGE';

            % Create pushbutton2
            app.pushbutton2 = uibutton(app.Panel, 'push');
            app.pushbutton2.ButtonPushedFcn = createCallbackFcn(app, @rgb2gray, true);
            app.pushbutton2.Tag = 'pushbutton2';
            app.pushbutton2.BackgroundColor = [0.1255 0.698 0.6667];
            app.pushbutton2.FontName = 'Arial';
            app.pushbutton2.FontSize = 16;
            app.pushbutton2.FontWeight = 'bold';
            app.pushbutton2.FontColor = [1 1 1];
            app.pushbutton2.Position = [44 443 171.98 49.99];
            app.pushbutton2.Text = 'RGB TO GRAY';

            % Create pushbutton3
            app.pushbutton3 = uibutton(app.Panel, 'push');
            app.pushbutton3.ButtonPushedFcn = createCallbackFcn(app, @rgb2hsvconverter, true);
            app.pushbutton3.Tag = 'pushbutton3';
            app.pushbutton3.BackgroundColor = [0.9725 0.3725 0.2549];
            app.pushbutton3.FontName = 'Arial';
            app.pushbutton3.FontSize = 16;
            app.pushbutton3.FontWeight = 'bold';
            app.pushbutton3.FontColor = [1 1 1];
            app.pushbutton3.Position = [43 375 171.98 49.99];
            app.pushbutton3.Text = 'RGB TO HSV';

            % Create pushbutton4
            app.pushbutton4 = uibutton(app.Panel, 'push');
            app.pushbutton4.ButtonPushedFcn = createCallbackFcn(app, @binaryimageconverter, true);
            app.pushbutton4.Tag = 'pushbutton4';
            app.pushbutton4.BackgroundColor = [0.3922 0.5843 0.9294];
            app.pushbutton4.FontName = 'Arial';
            app.pushbutton4.FontSize = 16;
            app.pushbutton4.FontWeight = 'bold';
            app.pushbutton4.FontColor = [1 1 1];
            app.pushbutton4.Position = [43 304 171.98 49.99];
            app.pushbutton4.Text = 'BINARY IMAGE';

            % Create pushbutton5
            app.pushbutton5 = uibutton(app.Panel, 'push');
            app.pushbutton5.ButtonPushedFcn = createCallbackFcn(app, @SHARPNESS, true);
            app.pushbutton5.Tag = 'pushbutton5';
            app.pushbutton5.BackgroundColor = [0 0.447058823529412 0.741176470588235];
            app.pushbutton5.FontName = 'Arial';
            app.pushbutton5.FontSize = 16;
            app.pushbutton5.FontWeight = 'bold';
            app.pushbutton5.FontColor = [1 1 1];
            app.pushbutton5.Position = [42.99 233.99 172 49];
            app.pushbutton5.Text = {'SHARPNESS'; ''};

            % Create pushbutton6
            app.pushbutton6 = uibutton(app.Panel, 'push');
            app.pushbutton6.ButtonPushedFcn = createCallbackFcn(app, @whitebalancer, true);
            app.pushbutton6.Tag = 'pushbutton6';
            app.pushbutton6.BackgroundColor = [0.7843 0.2471 0.2863];
            app.pushbutton6.FontName = 'Arial';
            app.pushbutton6.FontSize = 16;
            app.pushbutton6.FontWeight = 'bold';
            app.pushbutton6.FontColor = [1 1 1];
            app.pushbutton6.Position = [44 162 171.98 49.99];
            app.pushbutton6.Text = 'WHITE BALANCE';

            % Create pushbutton7
            app.pushbutton7 = uibutton(app.Panel, 'push');
            app.pushbutton7.ButtonPushedFcn = createCallbackFcn(app, @grayadjuster, true);
            app.pushbutton7.Tag = 'pushbutton7';
            app.pushbutton7.BackgroundColor = [0.549 0.702 0.3765];
            app.pushbutton7.FontName = 'Arial';
            app.pushbutton7.FontSize = 16;
            app.pushbutton7.FontWeight = 'bold';
            app.pushbutton7.FontColor = [1 1 1];
            app.pushbutton7.Position = [43 95 171.98 49.99];
            app.pushbutton7.Text = 'GRAY ADJUST';

            % Create pushbutton8
            app.pushbutton8 = uibutton(app.Panel, 'push');
            app.pushbutton8.ButtonPushedFcn = createCallbackFcn(app, @coloradjuster, true);
            app.pushbutton8.Tag = 'pushbutton8';
            app.pushbutton8.BackgroundColor = [0.702 0.5098 0.2431];
            app.pushbutton8.FontName = 'Arial';
            app.pushbutton8.FontSize = 16;
            app.pushbutton8.FontWeight = 'bold';
            app.pushbutton8.FontColor = [1 1 1];
            app.pushbutton8.Position = [43 24 171.98 49.99];
            app.pushbutton8.Text = 'COLOR ADJUST';

            % Create axes1
            app.axes1 = uiaxes(app.UIFigure);
            app.axes1.FontSize = 13;
            app.axes1.GridColor = [0 0 0];
            app.axes1.XTick = [];
            app.axes1.YTick = [];
            app.axes1.Color = [0.8627 0.8627 0.7843];
            app.axes1.NextPlot = 'replace';
            app.axes1.Tag = 'axes1';
            app.axes1.Position = [509 436 506 346];

            % Create axes2
            app.axes2 = uiaxes(app.UIFigure);
            app.axes2.FontSize = 13;
            app.axes2.GridColor = [0 0 0];
            app.axes2.MinorGridColor = [0.1 0.1 0.1];
            app.axes2.XTick = [];
            app.axes2.YTick = [];
            app.axes2.ZTick = [];
            app.axes2.Color = [0.8627 0.8627 0.7843];
            app.axes2.NextPlot = 'replace';
            app.axes2.Tag = 'axes2';
            app.axes2.Position = [1014 436 506 346];

            % Create text11
            app.text11 = uilabel(app.UIFigure);
            app.text11.Tag = 'text11';
            app.text11.BackgroundColor = [0.3412 0.3412 0.3412];
            app.text11.HorizontalAlignment = 'center';
            app.text11.VerticalAlignment = 'top';
            app.text11.FontName = 'Arial';
            app.text11.FontSize = 24;
            app.text11.FontWeight = 'bold';
            app.text11.FontColor = [1 1 1];
            app.text11.Position = [259 405 1261 32];
            app.text11.Text = 'CONTROL PANEL';

            % Create Panel_3
            app.Panel_3 = uipanel(app.UIFigure);
            app.Panel_3.ForegroundColor = [1 1 1];
            app.Panel_3.BackgroundColor = [0.8314 0.8314 0.8314];
            app.Panel_3.FontName = 'Arial';
            app.Panel_3.FontWeight = 'bold';
            app.Panel_3.FontSize = 20;
            app.Panel_3.Position = [2 1 1516 153];

            % Create pushbutton10
            app.pushbutton10 = uibutton(app.Panel_3, 'push');
            app.pushbutton10.ButtonPushedFcn = createCallbackFcn(app, @histeq, true);
            app.pushbutton10.Tag = 'pushbutton10';
            app.pushbutton10.BackgroundColor = [0.6902 0.7686 0.8706];
            app.pushbutton10.FontName = 'Arial';
            app.pushbutton10.FontSize = 16;
            app.pushbutton10.FontWeight = 'bold';
            app.pushbutton10.Position = [326 92 262 46];
            app.pushbutton10.Text = 'HISTOGRAM EQUALIZATION';

            % Create pushbutton9
            app.pushbutton9 = uibutton(app.Panel_3, 'push');
            app.pushbutton9.ButtonPushedFcn = createCallbackFcn(app, @histogram, true);
            app.pushbutton9.Tag = 'pushbutton9';
            app.pushbutton9.BackgroundColor = [0.6902 0.7686 0.8706];
            app.pushbutton9.FontName = 'Arial';
            app.pushbutton9.FontSize = 16;
            app.pushbutton9.FontWeight = 'bold';
            app.pushbutton9.Position = [22 92 264 46];
            app.pushbutton9.Text = 'HISTOGRAM';

            % Create pushbutton15
            app.pushbutton15 = uibutton(app.Panel_3, 'push');
            app.pushbutton15.ButtonPushedFcn = createCallbackFcn(app, @clockwise, true);
            app.pushbutton15.Tag = 'pushbutton15';
            app.pushbutton15.BackgroundColor = [0.6902 0.7686 0.8706];
            app.pushbutton15.FontName = 'Arial';
            app.pushbutton15.FontSize = 16;
            app.pushbutton15.FontWeight = 'bold';
            app.pushbutton15.Position = [943 92 262 46];
            app.pushbutton15.Text = 'ROTATE CLOCKWISE';

            % Create pushbutton16
            app.pushbutton16 = uibutton(app.Panel_3, 'push');
            app.pushbutton16.ButtonPushedFcn = createCallbackFcn(app, @anticlockwise, true);
            app.pushbutton16.Tag = 'pushbutton16';
            app.pushbutton16.BackgroundColor = [0.6902 0.7686 0.8706];
            app.pushbutton16.FontName = 'Arial';
            app.pushbutton16.FontSize = 16;
            app.pushbutton16.FontWeight = 'bold';
            app.pushbutton16.Position = [1239 92 265 46];
            app.pushbutton16.Text = 'ROTATE ANTI-CLOCKWISE';

            % Create pushbutton24
            app.pushbutton24 = uibutton(app.Panel_3, 'push');
            app.pushbutton24.ButtonPushedFcn = createCallbackFcn(app, @compimg, true);
            app.pushbutton24.Tag = 'pushbutton24';
            app.pushbutton24.BackgroundColor = [0.6902 0.7686 0.8706];
            app.pushbutton24.FontName = 'Arial';
            app.pushbutton24.FontSize = 16;
            app.pushbutton24.FontWeight = 'bold';
            app.pushbutton24.Position = [628 92 264 46];
            app.pushbutton24.Text = 'COMPLEMENT IMAGE';

            % Create pushbutton33
            app.pushbutton33 = uibutton(app.Panel_3, 'push');
            app.pushbutton33.ButtonPushedFcn = createCallbackFcn(app, @save, true);
            app.pushbutton33.Tag = 'pushbutton33';
            app.pushbutton33.BackgroundColor = [0.0745 0.6235 1];
            app.pushbutton33.FontName = 'Arial';
            app.pushbutton33.FontSize = 20;
            app.pushbutton33.FontWeight = 'bold';
            app.pushbutton33.FontColor = [1 1 1];
            app.pushbutton33.Position = [768 24 245 33];
            app.pushbutton33.Text = {'SAVE'; ''};

            % Create pushbutton33_2
            app.pushbutton33_2 = uibutton(app.Panel_3, 'push');
            app.pushbutton33_2.Tag = 'pushbutton33';
            app.pushbutton33_2.BackgroundColor = [0.7412 0.3922 0.3922];
            app.pushbutton33_2.FontName = 'Arial';
            app.pushbutton33_2.FontSize = 20;
            app.pushbutton33_2.FontWeight = 'bold';
            app.pushbutton33_2.FontColor = [1 1 1];
            app.pushbutton33_2.Position = [458 25 258 33];
            app.pushbutton33_2.Text = 'RESET';

            % Create uibuttongroup16
            app.uibuttongroup16 = uibuttongroup(app.UIFigure);
            app.uibuttongroup16.BackgroundColor = [0.8314 0.8314 0.8314];
            app.uibuttongroup16.Tag = 'uibuttongroup16';
            app.uibuttongroup16.FontSize = 11;
            app.uibuttongroup16.Position = [259 436 255 346];

            % Create text2
            app.text2 = uilabel(app.uibuttongroup16);
            app.text2.Tag = 'text2';
            app.text2.BackgroundColor = [0.1843 0.3098 0.3098];
            app.text2.HorizontalAlignment = 'center';
            app.text2.VerticalAlignment = 'top';
            app.text2.FontName = 'Arial';
            app.text2.FontSize = 16;
            app.text2.FontWeight = 'bold';
            app.text2.FontColor = [1 1 1];
            app.text2.Position = [13 294 230 21];
            app.text2.Text = 'CONTRAST ADJUSTMENT';

            % Create text3
            app.text3 = uilabel(app.uibuttongroup16);
            app.text3.Tag = 'text3';
            app.text3.BackgroundColor = [0.1843 0.3098 0.3098];
            app.text3.HorizontalAlignment = 'center';
            app.text3.VerticalAlignment = 'top';
            app.text3.FontName = 'Arial';
            app.text3.FontSize = 16;
            app.text3.FontWeight = 'bold';
            app.text3.FontColor = [1 1 1];
            app.text3.Position = [10 191 231 24];
            app.text3.Text = 'BRIGHTNESS ADJUSTMENT';

            % Create text4
            app.text4 = uilabel(app.uibuttongroup16);
            app.text4.Tag = 'text4';
            app.text4.BackgroundColor = [0.1843 0.3098 0.3098];
            app.text4.HorizontalAlignment = 'center';
            app.text4.VerticalAlignment = 'top';
            app.text4.FontName = 'Arial';
            app.text4.FontSize = 16;
            app.text4.FontWeight = 'bold';
            app.text4.FontColor = [1 1 1];
            app.text4.Position = [10 89 231 25];
            app.text4.Text = 'SATURATION ADJUSTMENT';

            % Create Slider_3Label
            app.Slider_3Label = uilabel(app.uibuttongroup16);
            app.Slider_3Label.HorizontalAlignment = 'right';
            app.Slider_3Label.Position = [18 261 36 22];
            app.Slider_3Label.Text = 'Slider';

            % Create Slider_3
            app.Slider_3 = uislider(app.uibuttongroup16);
            app.Slider_3.Limits = [0 10];
            app.Slider_3.ValueChangedFcn = createCallbackFcn(app, @contrastadjuster, true);
            app.Slider_3.Position = [75 270 150 3];

            % Create Slider_4Label
            app.Slider_4Label = uilabel(app.uibuttongroup16);
            app.Slider_4Label.HorizontalAlignment = 'right';
            app.Slider_4Label.Position = [16 159 36 22];
            app.Slider_4Label.Text = 'Slider';

            % Create Slider_4
            app.Slider_4 = uislider(app.uibuttongroup16);
            app.Slider_4.Limits = [0 5];
            app.Slider_4.ValueChangedFcn = createCallbackFcn(app, @brightness, true);
            app.Slider_4.Position = [73 168 150 3];

            % Create Slider_5Label
            app.Slider_5Label = uilabel(app.uibuttongroup16);
            app.Slider_5Label.HorizontalAlignment = 'right';
            app.Slider_5Label.Position = [16 58 36 22];
            app.Slider_5Label.Text = 'Slider';

            % Create Slider_5
            app.Slider_5 = uislider(app.uibuttongroup16);
            app.Slider_5.ValueChangedFcn = createCallbackFcn(app, @saturationadjuster, true);
            app.Slider_5.Position = [72 67 150 3];

            % Create uibuttongroup8_2
            app.uibuttongroup8_2 = uibuttongroup(app.UIFigure);
            app.uibuttongroup8_2.BackgroundColor = [0.8314 0.8314 0.8314];
            app.uibuttongroup8_2.Tag = 'uibuttongroup8';
            app.uibuttongroup8_2.FontSize = 11;
            app.uibuttongroup8_2.Position = [259 184 206 221];

            % Create pushbutton21
            app.pushbutton21 = uibutton(app.uibuttongroup8_2, 'push');
            app.pushbutton21.ButtonPushedFcn = createCallbackFcn(app, @gaussfilter, true);
            app.pushbutton21.Tag = 'pushbutton21';
            app.pushbutton21.BackgroundColor = [0.4706 0.5294 0.6];
            app.pushbutton21.FontName = 'Arial';
            app.pushbutton21.FontSize = 16;
            app.pushbutton21.FontWeight = 'bold';
            app.pushbutton21.FontColor = [1 1 1];
            app.pushbutton21.Position = [28 122 152 41];
            app.pushbutton21.Text = 'GAUSSIAN FILTER';

            % Create pushbutton22
            app.pushbutton22 = uibutton(app.uibuttongroup8_2, 'push');
            app.pushbutton22.ButtonPushedFcn = createCallbackFcn(app, @medfilter, true);
            app.pushbutton22.Tag = 'pushbutton22';
            app.pushbutton22.BackgroundColor = [0.4706 0.5294 0.6];
            app.pushbutton22.FontName = 'Arial';
            app.pushbutton22.FontSize = 16;
            app.pushbutton22.FontWeight = 'bold';
            app.pushbutton22.FontColor = [1 1 1];
            app.pushbutton22.Position = [28 73 152 41];
            app.pushbutton22.Text = 'MEDIAN FILTER';

            % Create pushbutton20
            app.pushbutton20 = uibutton(app.uibuttongroup8_2, 'push');
            app.pushbutton20.ButtonPushedFcn = createCallbackFcn(app, @avgfilter, true);
            app.pushbutton20.Tag = 'pushbutton20';
            app.pushbutton20.BackgroundColor = [0.4706 0.5294 0.6];
            app.pushbutton20.FontName = 'Arial';
            app.pushbutton20.FontSize = 16;
            app.pushbutton20.FontWeight = 'bold';
            app.pushbutton20.FontColor = [1 1 1];
            app.pushbutton20.Position = [28 171 152 41];
            app.pushbutton20.Text = 'AVERAGE FILTER';

            % Create pushbutton23
            app.pushbutton23 = uibutton(app.uibuttongroup8_2, 'push');
            app.pushbutton23.ButtonPushedFcn = createCallbackFcn(app, @guidedfilt, true);
            app.pushbutton23.Tag = 'pushbutton23';
            app.pushbutton23.BackgroundColor = [0.4706 0.5294 0.6];
            app.pushbutton23.FontName = 'Arial';
            app.pushbutton23.FontSize = 16;
            app.pushbutton23.FontWeight = 'bold';
            app.pushbutton23.FontColor = [1 1 1];
            app.pushbutton23.Position = [28 24 152 41];
            app.pushbutton23.Text = 'GUIDED FILTER';

            % Create text7
            app.text7 = uilabel(app.UIFigure);
            app.text7.Tag = 'text7';
            app.text7.BackgroundColor = [0.3412 0.3412 0.3412];
            app.text7.HorizontalAlignment = 'center';
            app.text7.VerticalAlignment = 'top';
            app.text7.FontName = 'Arial';
            app.text7.FontSize = 20;
            app.text7.FontWeight = 'bold';
            app.text7.FontColor = [1 1 1];
            app.text7.Position = [0 781 259 26];
            app.text7.Text = {'CONSOLE'; ''};

            % Create text5
            app.text5 = uilabel(app.UIFigure);
            app.text5.Tag = 'text5';
            app.text5.BackgroundColor = [0.3412 0.3412 0.3412];
            app.text5.HorizontalAlignment = 'center';
            app.text5.VerticalAlignment = 'top';
            app.text5.FontName = 'Arial';
            app.text5.FontSize = 20;
            app.text5.FontWeight = 'bold';
            app.text5.FontColor = [1 1 1];
            app.text5.Position = [509 781 473 26];
            app.text5.Text = 'INPUT IMAGE';

            % Create text6
            app.text6 = uilabel(app.UIFigure);
            app.text6.Tag = 'text6';
            app.text6.BackgroundColor = [0.3412 0.3412 0.3412];
            app.text6.HorizontalAlignment = 'center';
            app.text6.VerticalAlignment = 'top';
            app.text6.FontName = 'Arial';
            app.text6.FontSize = 20;
            app.text6.FontWeight = 'bold';
            app.text6.FontColor = [1 1 1];
            app.text6.Position = [981 781 539 26];
            app.text6.Text = 'OUTPUT IMAGE';

            % Create uibuttongroup8_3
            app.uibuttongroup8_3 = uibuttongroup(app.UIFigure);
            app.uibuttongroup8_3.BackgroundColor = [0.8314 0.8314 0.8314];
            app.uibuttongroup8_3.Tag = 'uibuttongroup8';
            app.uibuttongroup8_3.FontSize = 11;
            app.uibuttongroup8_3.Position = [464 184 335 221];

            % Create pushbutton12
            app.pushbutton12 = uibutton(app.uibuttongroup8_3, 'push');
            app.pushbutton12.ButtonPushedFcn = createCallbackFcn(app, @prewittedge, true);
            app.pushbutton12.Tag = 'pushbutton12';
            app.pushbutton12.BackgroundColor = [0.4706 0.5294 0.6];
            app.pushbutton12.FontName = 'Arial';
            app.pushbutton12.FontSize = 16;
            app.pushbutton12.FontWeight = 'bold';
            app.pushbutton12.FontColor = [1 1 1];
            app.pushbutton12.Position = [82 162 172 50];
            app.pushbutton12.Text = 'PREWITT EDGE';

            % Create pushbutton13
            app.pushbutton13 = uibutton(app.uibuttongroup8_3, 'push');
            app.pushbutton13.ButtonPushedFcn = createCallbackFcn(app, @sobeledge, true);
            app.pushbutton13.Tag = 'pushbutton13';
            app.pushbutton13.BackgroundColor = [0.4706 0.5294 0.6];
            app.pushbutton13.FontName = 'Arial';
            app.pushbutton13.FontSize = 16;
            app.pushbutton13.FontWeight = 'bold';
            app.pushbutton13.FontColor = [1 1 1];
            app.pushbutton13.Position = [82 94 172 50];
            app.pushbutton13.Text = 'SOBEL EDGE';

            % Create pushbutton14
            app.pushbutton14 = uibutton(app.uibuttongroup8_3, 'push');
            app.pushbutton14.ButtonPushedFcn = createCallbackFcn(app, @cannyedge, true);
            app.pushbutton14.Tag = 'pushbutton14';
            app.pushbutton14.BackgroundColor = [0.4706 0.5294 0.6];
            app.pushbutton14.FontName = 'Arial';
            app.pushbutton14.FontSize = 16;
            app.pushbutton14.FontWeight = 'bold';
            app.pushbutton14.FontColor = [1 1 1];
            app.pushbutton14.Position = [82 24 172 50];
            app.pushbutton14.Text = 'CANNY EDGE';

            % Create uibuttongroup8_4
            app.uibuttongroup8_4 = uibuttongroup(app.UIFigure);
            app.uibuttongroup8_4.BackgroundColor = [0.8314 0.8314 0.8314];
            app.uibuttongroup8_4.Tag = 'uibuttongroup8';
            app.uibuttongroup8_4.FontSize = 11;
            app.uibuttongroup8_4.Position = [798 184 332 221];

            % Create pushbutton17
            app.pushbutton17 = uibutton(app.uibuttongroup8_4, 'push');
            app.pushbutton17.ButtonPushedFcn = createCallbackFcn(app, @gaussnoise, true);
            app.pushbutton17.Tag = 'pushbutton17';
            app.pushbutton17.BackgroundColor = [0.4706 0.5294 0.6];
            app.pushbutton17.FontName = 'Arial';
            app.pushbutton17.FontSize = 16;
            app.pushbutton17.FontWeight = 'bold';
            app.pushbutton17.FontColor = [1 1 1];
            app.pushbutton17.Position = [80 164 172 50];
            app.pushbutton17.Text = 'GAUSSIAN NOISE';

            % Create pushbutton18
            app.pushbutton18 = uibutton(app.uibuttongroup8_4, 'push');
            app.pushbutton18.ButtonPushedFcn = createCallbackFcn(app, @specklenoise, true);
            app.pushbutton18.Tag = 'pushbutton18';
            app.pushbutton18.BackgroundColor = [0.4706 0.5294 0.6];
            app.pushbutton18.FontName = 'Arial';
            app.pushbutton18.FontSize = 16;
            app.pushbutton18.FontWeight = 'bold';
            app.pushbutton18.FontColor = [1 1 1];
            app.pushbutton18.Position = [80 96 172 50];
            app.pushbutton18.Text = 'SPECKLE NOISE';

            % Create pushbutton19
            app.pushbutton19 = uibutton(app.uibuttongroup8_4, 'push');
            app.pushbutton19.ButtonPushedFcn = createCallbackFcn(app, @saltpeppernoise, true);
            app.pushbutton19.Tag = 'pushbutton19';
            app.pushbutton19.BackgroundColor = [0.4706 0.5294 0.6];
            app.pushbutton19.FontName = 'Arial';
            app.pushbutton19.FontSize = 16;
            app.pushbutton19.FontWeight = 'bold';
            app.pushbutton19.FontColor = [1 1 1];
            app.pushbutton19.Position = [66 26 199 50];
            app.pushbutton19.Text = 'SALT & PEPPER NOISE';

            % Create uibuttongroup8_5
            app.uibuttongroup8_5 = uibuttongroup(app.UIFigure);
            app.uibuttongroup8_5.BackgroundColor = [0.8314 0.8314 0.8314];
            app.uibuttongroup8_5.Tag = 'uibuttongroup8';
            app.uibuttongroup8_5.FontSize = 11;
            app.uibuttongroup8_5.Position = [1129 184 389 221];

            % Create pushbutton26
            app.pushbutton26 = uibutton(app.uibuttongroup8_5, 'push');
            app.pushbutton26.ButtonPushedFcn = createCallbackFcn(app, @sepiacolor, true);
            app.pushbutton26.Tag = 'pushbutton26';
            app.pushbutton26.BackgroundColor = [0.4706 0.5294 0.6];
            app.pushbutton26.FontName = 'Arial';
            app.pushbutton26.FontSize = 16;
            app.pushbutton26.FontWeight = 'bold';
            app.pushbutton26.FontColor = [1 1 1];
            app.pushbutton26.Position = [64 142 76 61];
            app.pushbutton26.Text = 'SEPIA';

            % Create pushbutton26_2
            app.pushbutton26_2 = uibutton(app.uibuttongroup8_5, 'push');
            app.pushbutton26_2.ButtonPushedFcn = createCallbackFcn(app, @red, true);
            app.pushbutton26_2.Tag = 'pushbutton26';
            app.pushbutton26_2.BackgroundColor = [1 0 0];
            app.pushbutton26_2.FontName = 'Arial';
            app.pushbutton26_2.FontSize = 16;
            app.pushbutton26_2.FontWeight = 'bold';
            app.pushbutton26_2.FontColor = [1 1 1];
            app.pushbutton26_2.Position = [64 73 76 59];
            app.pushbutton26_2.Text = '';

            % Create pushbutton26_3
            app.pushbutton26_3 = uibutton(app.uibuttongroup8_5, 'push');
            app.pushbutton26_3.ButtonPushedFcn = createCallbackFcn(app, @green, true);
            app.pushbutton26_3.Tag = 'pushbutton26';
            app.pushbutton26_3.BackgroundColor = [0 1 0];
            app.pushbutton26_3.FontName = 'Arial';
            app.pushbutton26_3.FontSize = 16;
            app.pushbutton26_3.FontWeight = 'bold';
            app.pushbutton26_3.FontColor = [1 1 1];
            app.pushbutton26_3.Position = [158 72 76 59];
            app.pushbutton26_3.Text = '';

            % Create pushbutton26_4
            app.pushbutton26_4 = uibutton(app.uibuttongroup8_5, 'push');
            app.pushbutton26_4.ButtonPushedFcn = createCallbackFcn(app, @blue, true);
            app.pushbutton26_4.Tag = 'pushbutton26';
            app.pushbutton26_4.BackgroundColor = [0 0 1];
            app.pushbutton26_4.FontName = 'Arial';
            app.pushbutton26_4.FontSize = 16;
            app.pushbutton26_4.FontWeight = 'bold';
            app.pushbutton26_4.FontColor = [1 1 1];
            app.pushbutton26_4.Position = [254 73 73 59];
            app.pushbutton26_4.Text = '';

            % Create pushbutton30
            app.pushbutton30 = uibutton(app.uibuttongroup8_5, 'push');
            app.pushbutton30.ButtonPushedFcn = createCallbackFcn(app, @vivid, true);
            app.pushbutton30.Tag = 'pushbutton30';
            app.pushbutton30.BackgroundColor = [0.4706 0.5294 0.6];
            app.pushbutton30.FontName = 'Arial';
            app.pushbutton30.FontSize = 16;
            app.pushbutton30.FontWeight = 'bold';
            app.pushbutton30.FontColor = [1 1 1];
            app.pushbutton30.Position = [158 142 73 60];
            app.pushbutton30.Text = 'VIVID';

            % Create pushbutton32
            app.pushbutton32 = uibutton(app.uibuttongroup8_5, 'push');
            app.pushbutton32.ButtonPushedFcn = createCallbackFcn(app, @motion, true);
            app.pushbutton32.Tag = 'pushbutton32';
            app.pushbutton32.BackgroundColor = [0.4706 0.5294 0.6];
            app.pushbutton32.FontName = 'Arial';
            app.pushbutton32.FontSize = 16;
            app.pushbutton32.FontWeight = 'bold';
            app.pushbutton32.FontColor = [1 1 1];
            app.pushbutton32.Position = [249 143 78 59];
            app.pushbutton32.Text = 'MOTION';

            % Create pushbutton9_2
            app.pushbutton9_2 = uibutton(app.uibuttongroup8_5, 'push');
            app.pushbutton9_2.ButtonPushedFcn = createCallbackFcn(app, @boundaryextraction, true);
            app.pushbutton9_2.Tag = 'pushbutton9';
            app.pushbutton9_2.BackgroundColor = [0.4706 0.5294 0.6];
            app.pushbutton9_2.FontName = 'Arial';
            app.pushbutton9_2.FontSize = 15;
            app.pushbutton9_2.FontWeight = 'bold';
            app.pushbutton9_2.FontColor = [1 1 1];
            app.pushbutton9_2.Position = [64 21 263 44];
            app.pushbutton9_2.Text = {'BOUNDARY EXTRACTION'; ''};

            % Create text5_2
            app.text5_2 = uilabel(app.UIFigure);
            app.text5_2.Tag = 'text5';
            app.text5_2.BackgroundColor = [0.3412 0.3412 0.3412];
            app.text5_2.HorizontalAlignment = 'center';
            app.text5_2.VerticalAlignment = 'top';
            app.text5_2.FontName = 'Arial';
            app.text5_2.FontSize = 20;
            app.text5_2.FontWeight = 'bold';
            app.text5_2.FontColor = [1 1 1];
            app.text5_2.Position = [259 781 255 26];
            app.text5_2.Text = 'ADJUSTMENT';

            % Create text11_2
            app.text11_2 = uilabel(app.UIFigure);
            app.text11_2.Tag = 'text11';
            app.text11_2.BackgroundColor = [0.3412 0.3412 0.3412];
            app.text11_2.HorizontalAlignment = 'center';
            app.text11_2.VerticalAlignment = 'top';
            app.text11_2.FontName = 'Arial';
            app.text11_2.FontSize = 24;
            app.text11_2.FontWeight = 'bold';
            app.text11_2.FontColor = [1 1 1];
            app.text11_2.Position = [1 153 1517 32];
            app.text11_2.Text = {'ADVANCED OPERATIONS'; ''};

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = IMAGE_EDITOR

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end