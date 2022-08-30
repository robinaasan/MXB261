%% First part
size = 40; %number of bins
Data0 = importdata('sample2022.txt');

figure
subplot(1, 2, 1);
histogram(Data0, size);
set(gca,'FontSize',18)

%%
cdf_hist = histogram(Data0, size,'normalization', 'probability');
%sum(cdf_hist.Values); 

bins_place = (1:size);
bin_value = cdf_hist.Values;
subplot(1, 2, 2)
bar(bins_place, bin_value);

%calculating the cumulative sum
cum = cumsum(bin_value);

figure 
bar(bins_place, cum);
xlabel('bin number');
ylabel('Cumulative probability');
set(gca,'FontSize',18)

%% making lines from histogram

%when x < 1,  
Fx_0 = @(x) 0.*x;

figure
bar(bins_place, cum)
hold on
xvec_0 = linspace(0,1,size);
plot(xvec_0,Fx_0(xvec_0),'LineWidth',2)
for i = 1:size-1
    if (i == 1)
        Fx_1 = @(x) (cum(1)-0)/(2-1).*(x-1)+0; 
        xvec_0 = linspace(1,2,size);
        plot(xvec_0,Fx_1(xvec_0),'LineWidth',2)
        continue
    end
    Fx_rest = @(x) (cum(i+1)-cum(i))/(i+1-i).*(x-i)+cum(i);
    xvec_0 = linspace(i,i+1,size);
    plot(xvec_0,Fx_rest(xvec_0),'LineWidth',2)
end


%% Sampling part
samples = 500;
NewData = zeros(samples, 1);
rng(12);

sampling_list = zeros(1, samples);
for s = 1:samples
    u = rand;
    for y = 1:size
       if u<=cum(y)
           if y == 1
               y1 = 0;
           else
               y1 = cum(y-1); % set y1 = left CDF value
           end
           x1 = y-1; % set x1 = left RV
           x2 = y; % set x2 = right RV
           y2 = cum(y); %set y2 = right CDF value
           sampling_list(s) = y;
           break
       end
    end
    NewData(s) = (u-y1)*(x2-x1)/(y2-y1)+x1;
end


figure
subplot(1, 2, 1)
bar(bins_place, bin_value);
title('Sampled RV')
ylabel('Frequence in N samples')
set(gca,'FontSize',18);

subplot(1, 2, 2)

experimental_hist = histogram(NewData, size,'Normalization','pdf');
title('Experimental data')
ylabel('Frequence in N samples')
set(gca,'FontSize',18);

%% LEIBLER%

the_sum_first = 0;
the_sum_second = 0;

experimental_list = experimental_hist.Values;
format long
sum(experimental_list)

%normalize data in Data0 and NewData

% for y = 1:size
%     data1_pdf(y) = data1_pdf(y)/length(Data0); %Normalize
%     data2_cdf(y) = data2_cdf(y)/length(Data0); %Normalize
% end
% 
% 
for i = 1:size
    format long
    the_sum_first = the_sum_first + bin_value(i)*log(bin_value(i)/experimental_list(i));
    the_sum_second = the_sum_second + experimental_list(i)*log(experimental_list(i)/bin_value(i));
end
disp(the_sum_first)
disp(the_sum_second)




0.040
0.017

0.004
0.004

0.033
0.10
