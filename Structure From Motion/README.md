# Structure From Motion 👈

**REFERENCE : "Structure-from-motion Revisited" in CVPR (2016)**

SFM is extracts 3D information from 2D image. SFM goes through several processes

![image](https://user-images.githubusercontent.com/60316325/231698586-5a318bd1-7b5e-4027-82f1-cc4cc91c99ae.png)

1. **Camera Calibration ( Intrinsic Parameters & Extrinsic Parameters )**
2. **Feature Extraction**
3. **Description = Feature Matching**
4. **Epipolar Geometry**
5. **Triangulation**
6. **Bundle Adjustment**

---

### 1. Camera Calibration 📷

The real world we see with our eyes is 3D. However, when taken with a camera, it becomes a 2D image.

Where the 3D points are projected on the image is determined by the position and direction of the camera.

Further, the Actual image is affected by the mechanical parts inside the camera used. <br>(Lens, distance from lens, angle etc..)

When restoring 3D space coordinates from the positions of 3D points projected in image or from points on 2D, <br>
intrinsic parmeter must be known.

Thus, The process of finding **Intrinsic Parameter** is called "Camera Calibration". <br>
(한마디로, 카메라 내부 파라미터를 찾아내는 과정을 말한다.)

Perspective Projection of 3D point to 2D image plane

![image](https://user-images.githubusercontent.com/60316325/231688055-4da488e9-cd67-4bf4-9df5-1059310f5dac.png)

![image](https://user-images.githubusercontent.com/60316325/231683702-a868464b-a6dc-4824-9c25-370b827bc5bd.png)

![image](https://user-images.githubusercontent.com/60316325/231683990-4587b6f6-574f-486a-808c-cd2ce958f60a.png)

* $X, Y, Z$ = 3D Position respect to world coordinate system <br>
* $[R|t]$ = Rotation Matrix to transform world coordinate respect to camera coordinate frame (extrinsic parameter), R=rotation, t=moved
* $A$ = Intrinsic camera matrix
* $A[R|t]$ = Camera matrix or Projection Matrix

* $f_x, f_y$ = Focal length : The distance between the lens and the point on the image plane.
* $c_x, c_y$ = Principal point : Center of camera lens.
* $skew$ _ $cf_x$ = assymmetry coefficient (비대칭 계수) : The degree of tilt of the y-axis of the image sensor.

In general, Camera Calibration is proceed by using check pattern board below...

![image](https://user-images.githubusercontent.com/60316325/231694191-81ea44ad-8678-4d19-8b71-e7e6f7f66ba8.png)

---

### 2. Feature Extraction ✨

This is the process of extracting feature points such as corners or edges. <br>
However, ther is a problem that is vulnerable to movement, rotation and scale conversion of the image.

To solve this problem, various techniques such as **SIFT, SURF, BRISK, ORB, FAST** have been used and developed.

---

### 3. Feature Matching ✅

![image](https://user-images.githubusercontent.com/60316325/231700894-c9f3d68c-b19e-481e-904a-fd575298f738.png)

This is a step of matching points having the same characteristics between images based on the feature points extracted from each images.<br>
No geometrical meaning is included...

---

### 4. Epipolar Geometry 📷 📷

Based on the images from two different view, It is possible to find out the geometric relationship between the points matched in the previous step.

![image](https://user-images.githubusercontent.com/60316325/231701711-95d90f64-bc79-4ad6-b8d2-376e54d6fdcb.png)

For easy explanation, called image plane of camera 1 = A, camera 2 = B

* $x$ = Point in 3D space.
* $\bar{x}\_1, \bar{x}\_2$ = Points in 3D space projected on a 2D image (2D 이미지 평면상에 투영된 3차원 공간상의 점)
* $e_1, e_2$ = Epipole : The point at which center of a camera at another viewpoint is projected onto the image plane of a specific camera. <br>
(다른 시점의 카메라 중심점($c_2$)을, 특정 카메라($c_1$)의 이미지 평면에 투영시켰을 때의 점)
* $\tilde{l}\_1, \tilde{l}\_2$ = Epipolar line : The line connecting $\bar{x}$ and $e$.
* Baseline = The distance between two cameras.
* $[R|t]$ = A matrix representing how much $c_2$ is rotated and moved relative to $c_1$. <br>
(c1 카메라를 기준으로 c2 카메라가 어떤 회전과 이동이 이루어졌는지를 나타내는 행렬)

Even if we know $[R|t]$, if we don't know depth(distance) about point $x$, we can't know accurate point of $x$.

If straight line that connecting $c_1$ and $x$ is projected onto $c_2$ image plane, It becomes "Epipolar Line ($\tilde{I}\_2$)" <br>
That is, if we know the positional relationship between the image and the camera for the two views, we cannot match points to points, <br>
but we can match points to lines. <br>
(즉 2개의 서로다른 뷰에 대한 이미지와 카메라간의 위치관계($[R|t]$)를 안다면, 점과 점을 대응시킬 수는 없지만 점과 선을 대응시킬 수는 있다.)

쉽게, A 상의 영상좌표 $\bar{x}\_1$를 알고 있을 때, 이를 B에서 대응되는 영상 좌표 $\bar{x}\_2$의 좌표를 구할 때 <br>
3차원 상의 점 $x$까지의 거리(depth)정보를 모른다면, $x$ 의 좌표를 복원할 수 없으므로 이를 B에 투영시킨 $\bar{x}\_2$의 좌표 또한 결정할 수 없다. <br>
하지만 점 $x$는 $c_1$ 과 $\bar{x}\_1$를 잇는 직선상에 존재하므로, 이 직선을 B에 투영시키면 점 $\bar{x}\_2$가 투영된 직선에 있음을 알 수 있다.  

So. The matrix representing the correspondence between such points and lines is called **"Essential Matrix"** and **"Fundamental Matrix"**

#### 4.1 Essential Matrix

E Matrix는 정규화된 이미지 평면에서 매칭 쌍($\bar{x}\_1$, $\bar{x}\_2$)들 사이의 기하학적 관계를 설명하는 행렬<br>
E를 알면, 두 카메라 시점 사이의 회전, 평행이동 관계를 파악 가능하다.

Before learning about Essential Matrix, understand concepts below. 

* **Homogeneous** 하다는 의미는, 이미지 평면상의 좌표 ($x$, $y$)를, ($x$, $y$, $1$)로 표현한다는 것, 3차원의 경우 ($x$, $y$, $z$, $1$)<br>
이렇게 되면, affine 변환이나 perspective(projective) 변환을 하나의 단일 행렬로 표현할 수 있다는 장점이 있다. <br>
[Homogeneous means that coordinates ($x$, $y$) on the image plane are expressed as ($x$, $y$, $1$), in the case of 3D, ($x$, $y$, $z$, $1$) <br>
This has the advantage of being able to express affine transformations or perspective(projective) transformations in a single matrix.]

* **Nomarlized image plane** 은 정규좌표계 라고도 하며 '카메라의 내부 파라미터(intrinsic)의 영향을 제거한' 이미지 좌표계이다. <br>
즉, 정규화되었으므로 카메라 초점과의 거리가 1인 가상의 이미지 평면을 정의한다. <br> (원래의 이미지 평면을 초점과의 거리가 1인 지점으로 옮겨놓았다고 생각) <br>
서로 다른 카메라로 찍더라도, Intrinsic을 제거했으므로 일관된 기하학적인 해석을 하는데 효과적이기에 도입되었음. <br>
[Normalized image plane is called Normalized coordinate system that removed the effect of the camera's intrinsic parameters <br>
That is, since it is normalized, a virtual image plane with a distance of 1 from the camera focal point is defined. <br>
(Think of moving the original image plane to a point where the distance from focal point is 1) <br>
Even if it is taken with different cameras, it is effective for cosistent geometric analysis because Intrinsic has been removed]

If $x$ projected to $\bar{x}\_1$ at A and $\bar{x}\_2$ at B <br>
Essential Matrix describing the relationship between $\bar{x}\_1$ and $\bar{x}\_2$. <br>
(But, $\bar{x}\_1$ and $\bar{x}\_2$ are **homogeneous coordinate on normalized image plane**)

$$ x'^{\ T} \mathbf{E} x = 0 \quad ... (1)$$

$$ 
\begin{bmatrix}
u' &  v' & 1
\end{bmatrix}
\mathbf{E}
\begin{bmatrix}
u \\
v \\
1
\end{bmatrix} = 0 \quad ... (2)
$$

* $u, v$ = Point $\bar{x}\_1$ on image plane A, $u', v'$ = Point $\bar{x}\_2$ on image plane B. (coordinate)

Equation (1) called **"Epipolar Constraints"** and E matrix called **"Essential Matrix"**.

$$ \mathbf{E} = \mathbf{R} \ [t]\_{\times} $$

* $R$ = Rotation Matrix, $t$ = Parallel Movement vector.

#### 4.2 Fundamental Matrix

F Matrix는 카메라 파라미터까지 포함된 두 이미지의 실제 픽셀 좌표 사이의 기하학적 관계를 표현하는 행렬

For Any two image plane(A,B), A matrix exists that satisfying relationship between $\bar{x}\_1$, $\bar{x}\_2$. <br>
F Matrix that satisfies this relationship is called **"Fundamental Matrix"**

$$ \bar{x}\_2^{\ T} \mathbf{F} \bar{x}\_1 = 0 \quad $$

$$ 
\begin{bmatrix}
x' &  y' & 1
\end{bmatrix}
\mathbf{F}
\begin{bmatrix}
x \\
y \\
1
\end{bmatrix} = 0
$$

---

### 5. Triangulation 📐

삼각측량법 이라고도 한다.

If geometric relationship between two image planes ( Essential and Fundamental Matrix) is given and <br>
matching pair $\bar{x}\_1$, $\bar{x}\_2$ on the two image planes given, we can determine the original 3D coordinate $x$ from them

![image](https://user-images.githubusercontent.com/60316325/231755896-0109c505-31c9-4657-8a74-179f5bb83c65.png)

* $c_1, c_2$ : Principal Points
* $p_1, p_2$ : Projected 2D Feature Point From 3D point in each image plane

Two straight line \overrightarrow{$c_1p_1$} and  \overrightarrow{$c_2p_2$} is intersect at P <br>
(But, Actually it may not completely intersect due to noise like above image)

To solve this, there are many method pesented. In Wikipedia, there are three typical method <br>
( Refer this ! : https://en.wikipedia.org/wiki/Triangulation_(computer_vision) )

More detail about "Triangulation" will be explained in its part (Triangulation directory)

---

### 6. Bundle Adjustment 📂

![image](https://user-images.githubusercontent.com/60316325/231939338-7460eec9-fad4-406f-9aef-5216a9e68755.png)

![image](https://user-images.githubusercontent.com/60316325/231939360-4e8dad2d-0d1f-44a8-98e1-cb5b56303ca0.png)

Bundle Adjustment is to optimize the relative 3D motion between the camera frame and the 3D point loaction that can be estimated <br>
based on the locations of keypoints that exist in multiple frames.

From Triangulation, we can get 3D coordinate position. $P_1^'$, $P_2^'$, $P_3^'$ are coordinate position that reprojected 3D point <br>
(after Triangulation) to 2D image plane. so this is not the original coordinate.

The overall flow is as below..

1. Input image and Extract(Detect) Feature Points.
2. From the Feature Points, we can estimate Camera pose. ($R$ matrix and $t$ vector)
3. Determine 3D point position using Triangulation.
4. Correct Camera pose and 3D Point using Bundle Adjustment, Output = Corrected Camera pose and 3D Point position

Usually, use Outlier Filtering method (e.g RANSAC) and Bundle Adjustment together to reduce reprojection error.

---
