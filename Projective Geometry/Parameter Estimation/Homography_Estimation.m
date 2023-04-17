clc; clear; close all;

% Load ata
load('data.mat');

% Add noise
scale = 5;
x1n = x1(1:2,:) + randn(size(x1(1:2,:)))*scale; x1n(3,:) = 1;
x2n = x2(1:2,:) + randn(size(x2(1:2,:)))*scale; x2n(3,:) = 1;

% Draw Data
figure;
subplot(121);
plot(x1(1,:),x1(2,:),'r+'); axis equal; grid on; hold on;
plot(x1n(1,:),x1n(2,:),'b.'); 
axis([1 W1 1 H1]);
title('image 1');
xlabel('x (pixel)'); ylabel('y (pixel)'); hold off;
legend('noise-free point','noise-contaminated points');
subplot(122); plot(x2(1,:),x2(2,:),'r+'); axis equal; grid on; hold on;
plot(x2n(1,:),x2n(2,:),'b.'); axis([1 W2 1 H2]);
xlabel('x (pixel)'); ylabel('y (pixel)'); hold off;
title('image 2');
legend('noise-free point','noise-contaminated points');

% Normalize data
iT1 = [W1+H1 0 W1/2; 0 W1+H1 H1/2; 0 0 1]; T1 = inv(iT1);
iT2 = [W2+H2 0 W2/2; 0 W2+H2 H2/2; 0 0 1]; T2 = inv(iT2);
x1nm = T1*x1n;
x2nm = T2*x2n;

% Estimate homography by DLT
A = []; numPnt = size(x1nm,2);
for i=1:numPnt
    x = x1nm(1,i); y = x1nm(2,i); w = x1nm(3,i);
    x_ = x2nm(1,i); y_ = x2nm(2,i); w_ = x2nm(3,i);
    tmp = [0 0 0 -x*w_ -y*w_ -w*w_ x*y_ y*y_ w*y_;
           x*w_ y*w_ w*w_ 0 0 0 -x*x_ -y*x_ -w*x_];
    A = [A; tmp];
end
[U D V] = svd(A);
h = V(:,end);
Hnm = [h(1:3)'; h(4:6)'; h(7:9)'];
H = inv(T2)*Hnm*T1;

% Transform points
x2n_ = H*x1n;
x2n_(1,:) = x2n_(1,:)./x2n_(3,:); x2n_(2,:) = x2n_(2,:)./x2n_(3,:);
x2n_(3,:) = x2n_(3,:)./x2n_(3,:);

x1n_ = inv(H)*x2n;
x1n_(1,:) = x1n_(1,:)./x1n_(3,:); x1n_(2,:) = x1n_(2,:)./x1n_(3,:);
x1n_(3,:) = x1n_(3,:)./x1n_(3,:);

% Draw transformation result
figure; 
subplot(121); plot(x1n(1,:),x1n(2,:),'b+'); axis equal; grid on; hold on;
plot(x2n(1,:),x2n(2,:),'r.'); axis equal; grid on; hold on;
axis([1 W1 1 H1]); xlabel('x (pixel)'); ylabel('y (pixel)'); hold off;
title('image 1');
subplot(122); plot(x2n_(1,:),x2n_(2,:),'b+'); axis equal; grid on; hold on;
plot(x2n(1,:),x2n(2,:),'r.'); axis equal; grid on; hold on;
axis([1 W2 1 H2]); xlabel('x (pixel)'); ylabel('y (pixel)'); hold off;
title('image 2');

% Symmetric transfer error
error_DLT = sum(sum((x2n(1:2,:)-x2n_(1:2,:)).^2) ...
+ sum((x1n(1:2,:)-x1n_(1:2,:)).^2)); 
