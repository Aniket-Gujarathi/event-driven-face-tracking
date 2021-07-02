% Visualizes a batch of events, defined by deltat
% Author: Valentina Vasco



filename = '/home/aniket/gaze_tracking/Python_new/Python/yarp_out_new/batch05/ch0dvs/data.log.txt';

sel_channel = 0;
sel_pol = 1;

events = importdata(filename); % import data
 
%events(events(:, 1) ~= sel_channel, :) = []; % remove all events with channel different from the one selected
%events(events(:, 3) ~= sel_pol, :) = []; % remove all events with polarity different from the one selected
events(:, 2) = events(:, 2).*1000; % change time scale to seconds

events(:, 2) = events(:, 2) - events(1, 2);

ts = events(1, 2); % starting timestamp 
deltat = 0.2; % seconds

figure(1); clf;
%hold on; % remove hold on if you want to visualize only data in the current window 
set(gca, 'xlim', [0 640]);
set(gca, 'ylim', [0 480]);
set(gca, 'zlim', [events(1, 2) events(end, 2)]);
xlabel('x');
ylabel('y');
zlabel('ts (s)');
grid on;

for i = 1:size(events, 1)
    
    batch = events(events(:, 2) >= ts & (events(:, 2) <= ts + deltat), :); % define a window of events which fall in the temporal window defined by deltat
    
    if ~ishandle(1); break; end;
    %scatter3(batch(:, 4), batch(:, 5), batch(:, 2), 1, 'm'); % visualize events in the 3D space with colour depending on timestamp
    scatter(-batch(:, 4), -batch(:, 5), 1, 'm');
    drawnow;
    %pause
    
    ts = ts + deltat; % update timestamp
    
end