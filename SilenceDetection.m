[x, Fs] = audioread("newBirds.wav");

%take absolute value of signal
x_abs = abs(x);
L = 1000; %choose high window size to filter noise in silences

%apply moving average filter on signal
average = ones(1, L)/L;
x_filtered = filter(average, 1, x_abs);

%plot original signal
graph = 1:length(x);
plot(graph, x);


%define silence threshold
threshold = 0.02;
t_start = 0;
t_end = 0;


%loop thorugh amplitudes at each instant of t
for i = 1:length(x_filtered)
    %when the amplitude goes below the threshold, store the current t value
    if (x_filtered(i) < threshold && t_start == 0)
        %set t_start to the frame at which threshold is met
        t_start = i;
        t_end = 0;
        %plot silence start
         xline(i, '#00FF00')
    end

    if(t_start ~= 0 && x_filtered(i) > threshold)
        %set t_end to the frame at which threshold is met
        t_end = i;
        t_start = 0;
        %plot silence end
        xline(i, 'r')

    end

end

xlabel('Time (s)')
ylabel('Signal')
title('Birds Silence Detection')