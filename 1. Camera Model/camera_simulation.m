clc; clear; close all;

%% Make a virtual camera
% image size
ImageSize = [1280 960]; % pixel

% Calibration matrix
K = [1280    0 640;
        0 1280 480;
        0    0   1]; % pixel

% Rotation matrix(camera to world)
thx = 0*pi/180; thy = -90*pi/180; thz = -90*pi/180; % radian
Rx = [1        0         0;
      0 cos(thx)  sin(thx);
      0 -sin(thx)  cos(thx)];
Ry = [ cos(thy) 0 -sin(thy);
              0 1        0;
       sin(thy) 0 cos(thy)];
Rz = [cos(thz)  sin(thz) 0;
      -sin(thz)  cos(thz) 0;
             0         0 1];
R = Rz'*Ry'*Rx';

% Camera center in world coordinate frame
C_ = [-3; 0; 2];

% Translation vector
t = -R*C_;

% Camera projection matrix
P = K*R*[eye(3) -C_];

%% Build a virtual environment.

% 3D points in world coodinate frame.
% Ojbect #1 (Lane marking)
x1 = -5:0.01:20; y1 = [-1.5 1.5]; z1 = 0; % meter
[X1, Y1, Z1] = meshgrid(x1,y1,z1);
X1 = X1(:); Y1 = Y1(:); Z1 = Z1(:);

% Object #2 (Large road sign)
x2 = 15; y2 = -6:0.01:-2; z2 = 5:0.01:7; % meter
[X2, Y2, Z2] = meshgrid(x2,y2,z2);
X2 = X2(:); Y2 = Y2(:); Z2 = Z2(:);

% Object #3 (small road sign)
x3 = 10; y3 = 4:0.01:5; z3 = 1:0.01:4; % meter
[X3, Y3, Z3] = meshgrid(x3,y3,z3);
X3 = X3(:); Y3 = Y3(:); Z3 = Z3(:);

%% Draw 3D points and world coordinate frame

% Draw 3D points and world coordinate frame
figure; plot3(X1,Y1,Z1,'c.'); hold on;
plot3(X2,Y2,Z2,'m.');
plot3(X3,Y3,Z3,'y.');

len = 2;
Xp = [len; 0; 0]; Yp = [0; len; 0]; Zp = [0; 0; len];

plot3([0 Xp(1)],[0 Xp(2)],[0 Xp(3)],'b-','LineWidth',2);
plot3([0 Yp(1)],[0 Yp(2)],[0 Yp(3)],'g-','LineWidth',2);
plot3([0 Zp(1)],[0 Zp(2)],[0 Zp(3)],'r-','LineWidth',2);

xlabel('X (meter)'); ylabel('Y (meter)');
zlabel('Z (meter)'); axis equal; grid on;

%% Draw camera coordinate frame

% Draw camera coordinate frame
% if we use transpose, we can world to camera ( = we can draw camera coordinate)
% Xp - t => translation to camera coordinate
CX = R'*(Xp - t); % C2W rigid transform
CY = R'*(Yp - t);
CZ = R'*(Zp - t);

plot3([C_(1) CX(1)],[C_(2) CX(2)],[C_(3) CX(3)],'b:','LineWidth',2);
plot3([C_(1) CY(1)],[C_(2) CY(2)],[C_(3) CY(3)],'g:','LineWidth',2);
plot3([C_(1) CZ(1)],[C_(2) CZ(2)],[C_(3) CZ(3)],'r:','LineWidth',2);
hold off;

%% Accuire images of 3D points.

x1 = P*[X1'; Y1'; Z1'; ones(1,length(X1))]; % All points to camera coordinate.
x1(1,:) = x1(1,:)./x1(3,:);
x1(2,:) = x1(2,:)./x1(3,:); 
x2 = P*[X2'; Y2'; Z2'; ones(1,length(X2))];
x2(1,:) = x2(1,:)./x2(3,:);
x2(2,:) = x2(2,:)./x2(3,:); 
x3 = P*[X3'; Y3'; Z3'; ones(1,length(X3))];
x3(1,:) = x3(1,:)./x3(3,:); 
x3(2,:) = x3(2,:)./x3(3,:); 

%% Draw images of 3D points.

figure; plot(x1(1,:),x1(2,:),'c.'); axis equal; grid on; hold on;
plot(x2(1,:),x2(2,:),'m.'); 
plot(x3(1,:),x3(2,:),'y.'); 
axis([1 ImageSize(1) 1 ImageSize(2)]);
xlabel('x (pixel)'); ylabel('y (pixel)'); hold off;

