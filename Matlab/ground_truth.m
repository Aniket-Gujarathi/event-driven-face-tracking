% Visualizes a batch of events, defined by deltat
% Author: Valentina Vasco

filename = 'C:\Users\Aniket Gujarathi\Desktop\Event Driven\Dataset\facetracking\2\ATIS\data.log.txt';

template = imread('template.jpg');
T = rgb2gray(template);
[Tr, Tc] = size(T);
face = imread('3_2.jpg');
F = rgb2gray(face);
[Fr, Fc] = size(F);

sel_channel = 0;
sel_pol = 1;

events = importdata(filename); % import data
states = dlmread('C:\Users\Aniket Gujarathi\Desktop\Event-Driven-Tracking\States\state2_double\data.log');

%events(events(:, 1) ~= sel_channel, :) = []; % remove all events with channel different from the one selected
%events(events(:, 3) ~= sel_pol, :) = []; % remove all events with polarity different from the one selected

events(:, 2) = events(:, 2)./10000000; % change time scale to seconds
states(:, 3) = states(:, 3)./10000000; 

events(:, 2) = events(:, 2) - events(1, 2);
ts = events(1, 2); % starting timestamp 
deltat = 0.2; % seconds

%figure(1);
clf;
%hold on; % remove hold on if you want to visualize only data in the current window 
set(gca, 'xlim', [0 304]);
set(gca, 'ylim', [0 240]);
set(gca, 'zlim', [events(1, 2) events(end, 2)]);
xlabel('x');
ylabel('y');
zlabel('ts (s)');
%grid on;

r_index(1) = 0;
c_index(1) = 0;
    
for i = 1:size(events, 1)
    
    batch = events(events(:, 2) >= ts & (events(:, 2) <= ts + deltat), :); % define a window of events which fall in the temporal window defined by deltat
    if ~ishandle(1); break; end;
    %to visualise in 3D
    %%scatter3(batch(:, 2), batch(:, 4), batch(:, 5), 1, 'm'); % visualize events in the 3D space with colour depending on timestamp
    
    %to visualise in 2D
    s = scatter(batch(:, 4), batch(:, 5), 1, [0, 0, 0]);
    
%     figure(1);
%     drawnow;
    frame = getframe(gcf);
    [image, map] = frame2im(frame);
    
    Ima = rgb2gray(image);
    Ima = imresize(Ima, [420, 560]);
    [Ir, Ic] = size(Ima);
% %     Z = zeros(420, 560);
% %     for r = 1 : 420
% %         for c = 1 : 560
% %             if (image(r, c) == 0)
% %                 Z(r, c) = 1; 
% %             end
% %         end
% %     end
%     figure(2);
%     imshow(Z);
%   [Zr, Zc] = size(Z)
  
    %Apply normalised cross correlation on the template and the image
    R = normxcorr2(T, Ima);
    
    %find the maximum point from the correlation
    [r, c] = find(R == max(R(:)));

    %Account for the offset
    
    r_index(i) = r - size(template, 1) + 1
    c_index(i) = c - size(template, 2) + 1
   
    %Draw a rectangle around the ROI
    RGB = insertShape(image, 'rectangle', [c_index(i) r_index(i) Tc Tr], 'LineWidth', 3);
    
    RGB = imresize(RGB, [420, 560]);
    [Rr, Rc] = size(RGB);
    %figure(4);
    %imshow(RGB);
    
    times(i) = ts;
    
    s_time(i) = states(i, 3);
    s_x(i) = states(i, 4)
    s_y(i) = states(i, 5)
    
    figure(3);   
    hold on;
    sc1 = scatter3(times, c_index, r_index, 10, 'b'); 
    sc2 = scatter3(times, s_x, s_y, 10, 'm');
    xlabel('Time');
    ylabel('X');
    zlabel('Y');
    legend([sc1, sc2], 'Ground Truth', 'Actual Tracking');
    hold off;
    figure(5);
    
    ts = ts + deltat; % update timestamp
    
end
