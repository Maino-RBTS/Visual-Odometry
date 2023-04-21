# Camera Model

## Pinhole Camera Model

- Camera is a mapping between the 3D world and a 2D image.
- a point in space with coordinate $\mathbf{X} = (X,Y,Z)^T$ is mapped to the point on the image plane <br>
  where a line joining the point $\mathbf{X}$ to the center of projection $\mathbf{C}$ meets the image plane. <br>
  (3D 상의 점 $\mathbf{X}$와 카메라의 중심점 $\mathbf{C}$를 잇는 직선과 2D 이미지평면이 만나는 점에 $\mathbf{X}$가 투영된다.)
  
![image](https://user-images.githubusercontent.com/60316325/233344804-96813f97-d107-4523-a61b-f7b15118cd12.png)

- By similar triangles, the point $(X,Y,Z)^T$ is mapped to the point $(fX/Z, fY/Z, f)^T$ on the image plane.
- **Ignoring the final image coordinate**, we see that

$$(X,Y,Z)^T \rightarrow (fX/Z, fY/Z)^T$$

![image](https://user-images.githubusercontent.com/60316325/233348519-897b3f27-231f-4443-b88a-77dfa6233af0.png)

- This is a mapping from Euclidean 3-space $IR^3$ to Euclidean 2-space $IR^2$.

- The center of projection is called the **camera center** or opitcal center.
- The line from the camera center perpendicular to the image plane is called the "principal axis" or "principal ray" of the camera.
- The point where the principal axis metts the image plane is called "principal point"
- The plane through the camera center parallel to the image plane is called the "principal plane" of the camera.

## Homogeneous Coordinates

![image](https://user-images.githubusercontent.com/60316325/233352328-d9287bdf-5166-4d46-b0be-7a3c470ae663.png)

- It is a convenient coordinate system to represent many useful transformations.
- Homogeneous coordinates represent an N-dimensional space using a (N+1)-demenstional vector.
  - In the case of 2D space, $[x,y]^T \rightarrow [x,y,1]^T = [wx, wy, w]^T$
  - $[x,y]^T$ = inhomogeneous coordinate.
  - $[x,y,w]^T$ = homogeneous coordinate.
  - $[x,y,w]^T \rightarrow [x/w, y/w]^T$
  - $[x,y,0]^T$ a point at infinity.
  - In 3D space, $[X,Y,Z]^T \rightarrow [X,Y,Z,1]^T = [WX,WY,WZ,W]^T$.
  
- If the world and image points are represented by homogeneous vectors, this projection is simply expressed as a linear mapping <br>
  between their homogeneous coordinates.

$$(X,Y,Z)^T \rightarrow (fX/Z, fY/Z)^T$$

![image](https://user-images.githubusercontent.com/60316325/233361431-57a64722-4476-4049-a26e-55663e3dc514.png)

- So we can express $\mathbf{x} = P\mathbf{X} \rightarrow P$ diag $(f,f,1)[I|\mathbf{0}]$.

### Principal point offset

- The expression below assumes that the origin of coordinates in the image plane $P$ is at the principal point (Z-axis).

$$(X,Y,Z)^T \rightarrow (fX/Z, fY/Z)^T$$

- In practice, it may not be and there is a more general expression as..

$$(X,Y,Z)^T \rightarrow (fX/Z + p_x, fY/Z + p_y)^T$$

- This equation may be expressed conveniently in homogeneous coordinates as..

![image](https://user-images.githubusercontent.com/60316325/233365141-2d5e7345-8736-42e4-9700-fdc7e81da34b.png)

![image](https://user-images.githubusercontent.com/60316325/233365293-a2665baf-1319-4c19-b75e-8472e1b3c069.png)

- $\mathbf{X}_{cam}$ is expressed in the 3D point $\mathbf{X}$ w.r.t camera coordinate frame. $K$ is **Calibration matrix or Intrinsic parameter matrix**.

$$\mathbf{x} = K[I\ |0]\mathbf{X}_{cam}, \qquad K = \begin{bmatrix}
f&0&p_x\\
0&f&p_y\\
0&0&1 \end{bmatrix}$$

### Camera rotation and Translation

- In general, points in space will be expressed in terms of a different Euclidean coordinate frame, known as the *"world coordinate frame"*.
- The two coordinate frames are related via a rotation $R$ and a translation $t$.

![image](https://user-images.githubusercontent.com/60316325/233523184-cee9ab59-6726-444b-a966-1ead358f9c66.png)

- tilde symbol means **inhomogeneous coordinate**
  - $\tilde{\mathbf{X}}$ represents a 3D point in the world coordinate frame. 
  - $\tilde{\mathbf{C}}$ represents the coordinates of the camera. (w.r.t World coordinate frame)
  - $\tilde{\mathbf{X}}\_{cam}$ represents the same point in the camera coordinate frame. (w.r.t World coordinate frame)
  - $R$ is 3x3 rotation matrix representing the orientation of the camera coordinate frame. (world to camera)
 
$$\tilde{\mathbf{X}}\_{cam} = R(\tilde{\mathbf{X}} - \tilde{\mathbf{C}}) = R\tilde{\mathbf{X}} - R\tilde{\mathbf{C}}$$

![image](https://user-images.githubusercontent.com/60316325/233537622-30fc27a3-f012-4069-8233-f352b35dfd8e.png)

- This equation may be written in homogeneous coordinates as...
  - $\mathbf{X}\_{cam}$ and $\mathbf{X}$ are all in **homogeneous coordinate system**.
  - $\mathbf{X}$ represents a 3D point in the world coordinate frame.
  - $\mathbf{X}\_{cam}$ represents the same point but w.r.t camera coordinate frame.
- So we can express eqution like below.

![image](https://user-images.githubusercontent.com/60316325/233539092-a758e647-c98f-4207-a080-bda1d97c22c9.png)

![image](https://user-images.githubusercontent.com/60316325/233541511-927a8a5d-4456-49de-9cee-04b00f6a7a81.png)

## CCD cameras.

- The general form of the calibration matrix of CCD camera is as follows:

![image](https://user-images.githubusercontent.com/60316325/233542519-8ab04af3-81de-4cfd-aa98-b4a3272ee9e9.png)

- $\alpha_x = fm_x$ and $\alpha_y = fm_y$ represent the **focal length of the camera in terms of pixel dimensions** in the x and y direction, respectively.
- $(x_0, y_0)$ is the **principal point in terms of pixel dimensions** with coordinates $\alpha_x = fm_x$ and $\alpha_y = fm_y$.

- Sometimes, the skew parameter (s) is added to the calibration matrix like below.

![image](https://user-images.githubusercontent.com/60316325/233543095-dfa4c394-6ad6-4e68-8dd8-2e45c7c68371.png)

- The skew parameter will be zero for most normal cameras.
- However, in certain unusual instances, it can take non-zero values.
- If $s\neq 0$, then this can be interpreted as a skewing of the pixel elements in the CCD array so that the x- and y-axes are not perpendicular(수직).

## Camera matrix Decomposition.

- A general projective camera may be decomposed into blocks according to $P = [M\ |\mathbf{p}\_4]$, (M : 3x3, $\mathbf{p}\_4$ : 3x1 ).

![image](https://user-images.githubusercontent.com/60316325/233544999-d5f067d7-37a3-4426-b263-46c6c8c75524.png)

- If P is given, the camera center can be calculated as follows :

![image](https://user-images.githubusercontent.com/60316325/233546010-f7e7781e-526a-4b27-aab6-09c488c8be5f.png)

- Since M=KR, KR can be found by decomposing M using QR decomposition.

![image](https://user-images.githubusercontent.com/60316325/233546173-5c02d995-84bf-4b5b-80f1-cf43ab269b2c.png)

- Decompose $M^{-1}$ using QR decomposition and calculate its inverse, then K and R can be found.

## Field of View (FOV)

- The field of view is that part of the world that is visible through the camera at a particular position and orientation in space
- Object outside of FOV are not recorded in the image.
- Given K and image size (W,H), FOV can be calculated as..

![image](https://user-images.githubusercontent.com/60316325/233549453-002f2a54-de20-480e-9a8d-789d18acccf4.png)

