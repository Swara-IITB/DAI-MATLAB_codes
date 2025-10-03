% 1st case with f = 30%
fprintf("For f = %f \n",0.3);
x = -3:0.02:3;
y = 6.5 * sin((2.1*x)+(pi/3));
tmp = randperm(length(y),round(length(y)*0.3));
z = y;
z(tmp) = y(tmp)+ 100 + (120-100)*rand(size(tmp));

% filtering
y_median = z;
y_mean = z;
y_quartile = z;
for i=1:length(z)
    c = z(max(1,i-8):min(i+8,length(z)));
    y_median(i) = median(c);
    y_mean(i) = mean(c);
    y_quartile(i) = quantile(c,0.25);
end

% plotting the waves 
figure(1);
plot(x,y,'b',x,z,'r',x,y_median,'g',x,y_mean,'m',x,y_quartile,'c');
legend('Original','Corrupted','Median Filtered','Mean Filtered', 'Quartile Filtered');
xlabel('X-axis');
ylabel('Y-axis');
title('Signal Filtering Comparison');

% relative mean squared error
rmse_median = sum((y-y_median).^2)/sum(y.^2);
rmse_mean = sum((y-y_mean).^2)/sum(y.^2);
rmse_quartile = sum((y-y_quartile).^2)/sum(y.^2);

fprintf("Relative mean squared error \n for moving median filtering : %f \n for moving mean filtering : %f \n for moving quartile filtering : %f \n",rmse_median,rmse_mean,rmse_quartile);

% 2nd case with f = 60%
fprintf("For f = %f \n",0.6);
x = -3:0.02:3;
y = 6.5 * sin((2.1*x)+(pi/3));
tmp = randperm(length(y),round(length(y)*0.6));
z = y;
z(tmp) = y(tmp)+ 100 + (120-100)*rand(size(tmp));

% filtering
y_median = z;
y_mean = z;
y_quartile = z;
for i=1:length(z)
    c = z(max(1,i-8):min(i+8,length(z)));
    y_median(i) = median(c);
    y_mean(i) = mean(c);
    y_quartile(i) = quantile(c,0.25);
end

%plotting the waves
figure(2);
plot(x,y,'b',x,z,'r',x,y_median,'g',x,y_mean,'m',x,y_quartile,'c');
legend('Original','Corrupted','Median Filtered','Mean Filtered', 'Quartile Filtered');
xlabel('X-axis');
ylabel('Y-axis');
title('Signal Filtering Comparison');

% relative mean squared error
rmse_median = sum((y-y_median).^2)/sum(y.^2);
rmse_mean = sum((y-y_mean).^2)/sum(y.^2);
rmse_quartile = sum((y-y_quartile).^2)/sum(y.^2);

fprintf("Relative mean squared error \n for moving median filtering : %f \n for moving mean filtering : %f \n for moving quartile filtering : %f \n",rmse_median,rmse_mean,rmse_quartile);
