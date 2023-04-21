clc; clear; close all;

% image size (pixel)
W1 = 1280; H1 = 960;
W2 = 640; H2 = 480;

% Calibration matrix
K1 = [200 0 W1/2; 0 200 H1/2; 0 0 1]; % pixel
K2 = [100 0 W2/2; 0 100 H2/2; 0 0 1]; % pixel

% Rotation matrix
thx = 10*pi/180; thy = -180*pi/180; thz = -70*pi/180; % radian
Rx = [1 0 0; 0 cos(thx) -sin(thx); 0 sin(thx) cos(thx)];
Ry = [cos(thy) 0 sin(thy); 0 1 0; -sin(thy) 0 cos(thy)];
Rz = [cos(thz) -sin(thz) 0; sin(thz) cos(thz) 0; 0 0 1];
R1 = Rz*Ry*Rx;

thx = -10*pi/180; thy = -170*pi/180; thz = 0*pi/180; % radian
Rx = [1 0 0; 0 cos(thx) -sin(thx); 0 sin(thx) cos(thx)];
Ry = [cos(thy) 0 sin(thy); 0 1 0; -sin(thy) 0 cos(thy)];
Rz = [cos(thz) -sin(thz) 0; sin(thz) cos(thz) 0; 0 0 1];
R2 = Rz*Ry*Rx;

% Camera center in world coordinate frame (meter)
C1_ = [-2; -2; 10];
C2_ = [5; 5; 15];

% Translation vector
t1 = -R1*C1_;
t2 = -R2*C2_;

% Camera projection matrix (P = K*[R t])
P1 = K1*R1*[eye(3) -C1_];
P2 = K2*R2*[eye(3) -C2_];

% 3D points in world coordinate frame
x1 = [-10 -9 -7 -4 0 5 11]; y1 = [-10 -9 -7 -4 0 5 11]; z1 = 0;
[X1, Y1, Z1] = meshgrid(x1,y1,z1);
X1 = X1(:); Y1 = Y1(:); Z1 = Z1(:);

% Draw 3D points and world coordinate frame
figure; plot3(X1,Y1,Z1,'k.'); hold on;
xlabel('X (meter)'); ylabel('Y (meter)'); zlabel('Z (meter)');
axis equal; grid on;

% Draw camera coordinate frame
len = 2;
Xp = [len; 0; 0]; Yp = [0; len; 0]; Zp = [0; 0; len];

% C2W rigid transform
CX1 = R1'*(Xp - t1); CY1 = R1'*(Yp - t1); CZ1 = R1'*(Zp - t1); 
CX2 = R2'*(Xp - t2); CY2 = R2'*(Yp - t2); CZ2 = R2'*(Zp - t2);
plot3([C1_(1) CX1(1)],[C1_(2) CX1(2)],[C1_(3) CX1(3)],'b:','LineWidth',2);
plot3([C1_(1) CY1(1)],[C1_(2) CY1(2)],[C1_(3) CY1(3)],'g:','LineWidth',2);
plot3([C1_(1) CZ1(1)],[C1_(2) CZ1(2)],[C1_(3) CZ1(3)],'r:','LineWidth',2);
plot3([C2_(1) CX2(1)],[C2_(2) CX2(2)],[C2_(3) CX2(3)],'b-','LineWidth',2);
plot3([C2_(1) CY2(1)],[C2_(2) CY2(2)],[C2_(3) CY2(3)],'g-','LineWidth',2);
plot3([C2_(1) CZ2(1)],[C2_(2) CZ2(2)],[C2_(3) CZ2(3)],'r-','LineWidth',2);
hold off;

% Acquire images of 3D points
x1 = P1*[X1'; Y1'; Z1'; ones(1,length(X1))];
x1(1,:) = x1(1,:)./x1(3,:); x1(2,:) = x1(2,:)./x1(3,:);
x1(3,:) = x1(3,:)./x1(3,:);
x2 = P2*[X1'; Y1'; Z1'; ones(1,length(X1))];
x2(1,:) = x2(1,:)./x2(3,:); x2(2,:) = x2(2,:)./x2(3,:);
x2(3,:) = x2(3,:)./x2(3,:);

% Draw images of 3D points
figure; 
subplot(121); plot(x1(1,:),x1(2,:),'r.'); axis equal; grid on; hold on;
axis([1 W1 1 H1]); xlabel('x (pixel)'); ylabel('y (pixel)'); 
hold off;
subplot(122); plot(x2(1,:),x2(2,:),'b.'); axis equal; grid on; hold on;
axis([1 W2 1 H2]); xlabel('x (pixel)'); ylabel('y (pixel)'); 
hold off;

save('data.mat','W1','H1','W2','H2','x1','x2');
