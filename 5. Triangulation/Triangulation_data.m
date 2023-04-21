clc; clear; close all;

%% Image size (pixel)
width = 1024; height = 768;

%% Calibration matrix
K1 = [300-3 0.02 width/2-5; 0 300+2 height/2+10; 0 0 1]; % pixel;
K2 = [300+3 0.01 width/2+5; 0 300-2 height/2-10; 0 0 1]; % pixel;

%% Rotation matrix (camera to world)
thx = -30*pi/180; thy = -170*pi/180; thz = -80*pi/180;
Rx = [1 0 0;0 cos(thx) sin(thx);0 -sin(thx) cos(thx)];
Ry = [cos(thy) 0 -sin(thy);0 1 0;sin(thy) 0 cos(thy)];
Rz = [cos(thz) sin(thz) 0;-sin(thz) cos(thz) 0; 0 0 1];
R1 = Rz'*Ry'*Rx';

thx = 30*pi/180; thy = -180*pi/180; thz = -70*pi/180;
Rx = [1 0 0;0 cos(thx) sin(thx);0 -sin(thx) cos(thx)];
Ry = [cos(thy) 0 -sin(thy);0 1 0;sin(thy) 0 cos(thy)];
Rz = [cos(thz) sin(thz) 0;-sin(thz) cos(thz) 0; 0 0 1];
R2 = Rz'*Ry'*Rx';

%% Camera center in world coordinate frame (meter)
C1_ = [0; -3; 10]; C2_ = [-1; 3; 9];

%% Translation vector
t1 = -R1*C1_; t2 = -R2*C2_;

%% Camera projection matrix (P = K*[R t])
P1 = K1*R1*[eye(3) -C1_];
P2 = K2*R2*[eye(3) -C2_];

%% 3D points in world coordinate frame
x = -4:1:4; y = -2:1:0; z = 0;
[X, Y, Z] = meshgrid(x,y,z);
X1 = X(:); Y1 = Y(:); Z1 = Z(:);
x = -4:1:4; y = 0:1:2; z = 2;
[X, Y, Z] = meshgrid(x,y,z);
x = -4:1:4; y = 2:1:4; z = 0;
X2 = X(:); Y2 = Y(:); Z2 = Z(:);
[X, Y, Z] = meshgrid(x,y,z);
X3 = X(:); Y3 = Y(:); Z3 = Z(:);
X = [X1; X2; X3]; Y = [Y1; Y2; Y3]; Z = [Z1; Z2; Z3];

% Draw 3D points and world coordinate frame
figure; plot3(X,Y,Z,'k.'); hold on;
hold on; plot3(X(28:27*2),Y(28:27*2),Z(28:27*2),'m.'); hold on;
xlabel('X (meter)'); ylabel('Y (meter)'); zlabel('Z (meter)');
axis equal; grid on;

%% Draw Camera coordinate frame
len = 2;
Xp = [len; 0; 0]; Yp = [0; len; 0]; Zp = [0; 0; len];
CX1 = R1'*(Xp-t1); CY1 = R1'*(Yp-t1); CZ1=R1'*(Zp-t1);
CX2 = R2'*(Xp-t2); CY2 = R2'*(Yp-t2); CZ2=R2'*(Zp-t2);

plot3([C1_(1) CX1(1)],[C1_(2) CX1(2)],[C1_(3) CX1(3)],'b-','LineWidth',2); hold on;
plot3([C1_(1) CY1(1)],[C1_(2) CY1(2)],[C1_(3) CY1(3)],'g-','LineWidth',2);
plot3([C1_(1) CZ1(1)],[C1_(2) CZ1(2)],[C1_(3) CZ1(3)],'r-','LineWidth',2);
plot3([C2_(1) CX2(1)],[C2_(2) CX2(2)],[C2_(3) CX2(3)],'b:','LineWidth',2);
plot3([C2_(1) CY2(1)],[C2_(2) CY2(2)],[C2_(3) CY2(3)],'g:','LineWidth',2);
plot3([C2_(1) CZ2(1)],[C2_(2) CZ2(2)],[C2_(3) CZ2(3)],'r:','LineWidth',2);
axis equal; hold off;

%% Acquire images of 3D points
x1 = P1*[X'; Y'; Z'; ones(1,length(X))];
x1(1,:) = x1(1,:)./x1(3,:); x1(2,:) = x1(2,:)./x1(3,:);
x1(3,:) = x1(3,:)./x1(3,:);
x2 = P2*[X'; Y'; Z'; ones(1,length(X))];
x2(1,:) = x2(1,:)./x2(3,:); x2(2,:) = x2(2,:)./x2(3,:); 
x2(3,:) = x2(3,:)./x2(3,:);

%% Draw images of 3D points
figure; 
subplot(121); plot(x1(1,:),x1(2,:),'k.'); hold on; 
plot(x1(1,28:27*2),x1(2,28:27*2),'m.'); axis equal; grid on;
axis([1 width 1 height]); xlabel('x (pixel)'); ylabel('y (pixel)'); 
title('camera 1 (line)');
hold off;
subplot(122); plot(x2(1,:),x2(2,:),'k.'); hold on; 
plot(x2(1,28:27*2),x2(2,28:27*2),'m.'); axis equal; grid on;
axis([1 width 1 height]); xlabel('x (pixel)'); ylabel('y (pixel)'); 
title('camera 2 (dot-line)');
hold off;
save('data_twoviews.mat','K1','R1','t1','K2','R2','t2','X','Y','Z','x1','x2','width','height');