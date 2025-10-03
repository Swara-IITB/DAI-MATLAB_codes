% reading images
im1 = double(imread('T1.jpg'));
im2 = double(imread('T2.jpg'));


[r,c] = size(im2);
p_arr = zeros(1,21);
Qmi_arr = zeros(1,21);
mi_arr = zeros(1,21);

for tx = -10:10
    im = zeros(size(im2));
    tmp = max(tx+1,1):min(c,tx+c);
    im(:,tmp) = im2(:, max(1-tx,1):min(c-tx,c)); % taking shifted image
    I1 = im1(:,tmp);
    I2 = im(:,tmp);
    I1 = I1(:);
    I2 = I2(:);
    %% correlation coefficient
    cv = cov(I1,I2);
    p_arr(tx+11) = cv(1,2)/(std(I1)*std(I2));
    
    %% QMI    
    jhist = zeros(26,26); % bins[0-10,10-20,...,250-260]
    for i = 1:length(I1)
        bin1 = floor(I1(i)/10) + 1;
        bin2 = floor(I2(i)/10) + 1;
        jhist(bin1, bin2) = jhist(bin1, bin2) + 1; % counting values in joint histogram
    end
    jhist = jhist/sum(jhist(:));

    % computing marginal histograms
    pI1 = sum(jhist,2); 
    pI2 = sum(jhist,1);
    for i1=1:26
        for i2 = 1:26
            Qmi_arr(tx+11) = Qmi_arr(tx+11) + (jhist(i1,i2)-(pI1(i1)*pI2(i2)))^2;
        end
    end
    %% MI
    for i1=1:26
        for i2 = 1:26
            if jhist(i1,i2)>0 && pI1(i1)>0 && pI2(i2)>0
               mi_arr(tx+11) = mi_arr(tx+11)+jhist(i1,i2)*log(jhist(i1,i2)/(pI1(i1)*pI2(i2)));
            end
        end
    end
end
tx = -10:10;

%% plotting graphs
figure(1);
plot(tx,p_arr);
xlabel('tx');
ylabel('Correlation Coefficient');
title('Correlation coefficient vs tx');

figure(2);
plot(tx, Qmi_arr);
xlabel('tx');
ylabel('QMI');
title('Quadratic mutual information vs tx');

figure(3);
plot(tx, mi_arr);
xlabel('tx');
ylabel('MI');
title('Mutual information vs tx');
