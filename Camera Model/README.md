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
