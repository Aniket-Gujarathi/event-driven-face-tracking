% Visualizes a batch of events, defined by deltat
% Author: Valentina Vasco

filename = '/home/aniket/IIT_project/Dataset/facetracking/3/ATIS/data.log.txt';

template = imread('template.jpg');
T = rgb2gray(template);
[Tr, Tc] = size(T);

sel_channel = 0;
sel_pol = 1;

events = importdata(filename); % import data 
%events(events(:, 1) ~= sel_channel, :) = []; % remove all events with channel different from the one selected
%events(events(:, 3) ~= sel_pol, :) = []; % remove all events with polarity different from the one selected
events(:, 2) = events(:, 2)./1000000; % change time scale to seconds


events(:, 2) = events(:, 2) - events(1, 2);
ts = events(1, 2); % starting timestamp 
deltat = 0.2; % seconds

figure(1); clf;
%hold on; % remove hold on if you want to visualize only data in the current window 
set(gca, 'xlim', [0 304]);
set(gca, 'ylim', [0 240]);
set(gca, 'zlim', [events(1, 2) events(end, 2)]);
xlabel('x');
ylabel('y');
zlabel('ts (s)');
%grid on;
    
for i = 1:size(events, 1)
    
    batch = events(events(:, 2) >= ts & (events(:, 2) <= ts + deltat), :); % define a window of events which fall in the temporal window defined by deltat
    
    if ~ishandle(1); break; end;
    %to visualise in 3D
    %%scatter3(batch(:, 2), batch(:, 4), batch(:, 5), 1, 'm'); % visualize events in the 3D space with colour depending on timestamp
    
    %to visualise in 2D
    scatter(batch(:, 4), batch(:, 5), 1, 'm');
    drawnow;
    
    F = getframe(gcf);
    [image, Map] = frame2im(F);
    I = rgb2gray(image);
    [Ir, Ic] = size(image);
    
    %Apply normalised cross correlation on the template and the image
    R = normxcorr2(T, I);

    %find the maximum point from the correlation
    [r, c] = find(R == max(R(:)));

    %Account for the offset
    r_index = r - size(template, 1) + 1;
    c_index = c - size(template, 2) + 1;

    %Draw a rectangle around the ROI
    RGB = insertShape(image, 'rectangle', [c_index r_index Tc Tr], 'LineWidth', 3);
    figure(4);
    imshow(RGB);

    %pause;

    ts = ts + deltat; % update timestamp
    
end

 
