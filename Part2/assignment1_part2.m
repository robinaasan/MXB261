%%Part 2 of assignment

size = 20; %number of bins

Data0 = importdata('sample2022.txt');

figure

hi_cdf = histogram(Data0, size, 'Normalization', 'cdf');
start_points = hi_cdf.BinEdges;

values = hi_cdf.Values;

mid_points_h2 = zeros(1, size);

for i = 1:length(start_points)-1
   mid_points_h2(i) = (start_points(i) + start_points(i+1))/2;
end

%cdf_plot= plot(mid_points_h2, values, "-o");

NewData = zeros(1, 500);
rng(7);

for y = 1:length(NewData)  
    u = rand;
    for t = 1:length(mid_points_h2)
        if u <= values(t)
            NewData(y) = mid_points_h2(t);
            break
        end
    end
end

figure 
subplot(1, 2, 1);

first_hist = histogram(Data0, size);
data1_pdf = first_hist.Values;
title('Data0', 'Fontsize', 14)
subplot(1, 2, 2)
second_hist = histogram(NewData, size);
data2_cdf = second_hist.Values;
title('NewData', 'Fontsize', 14)

figure
subplot(1, 2, 1)
plot(1:20, first_hist.Values, '-o')

%% LEIBLER%

the_sum_first = 0;
the_sum_second = 0;


%normalize data in Data0 and NewData

for y = 1:size
    data1_pdf(y) = data1_pdf(y)/length(Data0); %Normalize
    data2_cdf(y) = data2_cdf(y)/length(Data0); %Normalize
end


for i = 1:size
    format long
    the_sum_first = the_sum_first + data1_pdf(i)*log(data1_pdf(i)/data2_cdf(i));
    the_sum_second = the_sum_second + data2_cdf(i)*log(data2_cdf(i)/data1_pdf(i));
end
disp(the_sum_first)
disp(the_sum_second)

















