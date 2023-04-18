# Camera Calibration

* A procedure to estimate intrinsic and extrinsic parameters of the camera by estimation the projection matrix, $P$.
  * Intrinsic parameters are included in $K$. (Camera to Image Transformation)
  * Extrinsic parameters are included in $R$ and $t$. (World to Camera Transformation)

$$\mathbf{x} = K[R|t]\mathbf{X}$$

![image](https://user-images.githubusercontent.com/60316325/232674846-642ed958-e14d-4cad-9515-da70098d817a.png)

* The camera Projection matrix, P is estimated from corresponding 3-space and image entities.
* The simplest such correspondence is that between a 3D Point $\mathbf{X}$ and its image $\mathbf{x}$ under the unknown camera mapping.
* Given sufficiently many correspondences $\mathbf{X}\_i \leftrightarrow \mathbf{x}\_i$, the camera matrix P may be determined. <br>
 (similarly, P can be determined from sufficient corresponding world and image "lines")

## 1. Basic Equations

* We assume a number of correspondence $\mathbf{X}\_i \leftrightarrow \mathbf{x}\_i$ between 3D Points $\mathbf{X}\_i$ and 2D image points $\mathbf{x}\_i$ are given.

![image](https://user-images.githubusercontent.com/60316325/232675893-c95c4a40-1a8a-437f-8674-96802e0d256f.png)

* We are required to find a camera matrix P, namely a 3x4 matrix such that $\mathbf{x}\_i = P\mathbf{X}\_i$ for all $i$. <br>
(The similarity of this problem with that of computing a 2D projective transformation H is evident, **the only difference = dimension**)
* In the previous case, H matrix has 3x3, but this case P is 3x4 matrix.

* $\mathbf{x}\_i = P\mathbf{X}\_i$ -> Two vector differ in magnitude but have the same direction.

$$\mathbf{x}\_i \times P\mathbf{X}\_i = 0, \qquad [\mathbf{x}\_i]\_{\times}P\mathbf{X}\_i = 0$$

$$ 
\begin{bmatrix}
\mathbf{0}^T & -w_i\mathbf{x}\_i^T & y_i\mathbf{x}\_i^T \\
w_i\mathbf{x}\_i^T & \mathbf{0}^T & -x_i\mathbf{x}\_i^T \\
y_i\mathbf{x}\_i^T & x_i\mathbf{x}\_i^T & \mathbf{0}^T \\ \end{bmatrix}\begin{pmatrix}
\mathbf{\mathbf{P}}^{1}\\
\mathbf{\mathbf{P}}^{2}\\
\mathbf{\mathbf{P}}^{3}\\ \end{pmatrix} =\begin{bmatrix}
\mathbf{0}^T & -w_i\mathbf{x}\_i^T & y_i\mathbf{x}\_i^T \\
w_i\mathbf{x}\_i^T & \mathbf{0}^T & -x_i\mathbf{x}\_i^T \\ \end{bmatrix}\begin{pmatrix}
\mathbf{\mathbf{P}}^{1}\\
\mathbf{\mathbf{P}}^{2}\\
\mathbf{\mathbf{P}}^{3}\\ \end{pmatrix}, \qquad 
$$

* $\mathbf{P}^i$ is Transpose of $i$ th row of P matrix. like $\mathbf{P}^1 = (P_{11}, P_{12}, P_{13})^T$

* So we can write out below

$$A\mathbf{p} = 0$$

* Minimal solution
  * $\mathbf{p}$ has 11 DOF.
  * 2 independent equations per point correspondence.
  * 5 correspondences are needed.

* Over-determined solution
  * $n\ge 6$ points.
  * minimize $\lVert A\mathbf{p} \rVert$ subject to constraints $\lVert \mathbf{p} \rVert = 1$, --> **Use SVD!** 

* As in the case of 2D homography, data normalization should be carried out.

## 2. Geometric Error

* As in the case of homography, geometric error can be defined.
* Suppose that world point $\mathbf{X}\_i$ are known far more accurately than the measured image points $\mathbf{x}\_i$
  * $\mathbf{X}\_i$ is from an accurately machined calibration object.
  * $\mathbf{x}\_i$ is obtained by hand or algorithms (e.g corner detector)
* Then, the geometric error in the image can be define as
  * $\mathbf{x}\_i$ is the measured point and $P\mathbf{X}\_i$ is the image of $\mathbf{X}\_i$.
 
$$\sum_{i}d(\mathbf{x}\_i, P\mathbf{X}\_i)^2$$

* We can find P that minimizes the geometric error using iterative techniques, such as "Levenberg-Marquardt (LM)"

![image](https://user-images.githubusercontent.com/60316325/232700969-284da0c3-28a5-4695-8dbe-c49b6a078944.png)

### 2-1. Iterative Estimation of P

* Given $n\ge 6$ 3D to 2D point correspondences $\mathbf{X}\_i \leftrightarrow \mathbf{x}\_i$, determine P
* Algorithm
  1. Linear Solution : <br>
    (a) Normalization : $\tilde{\mathbf{X}}\_i = U\mathbf{X}\_i, \tilde{\mathbf{x}}\_i = T\mathbf{x}\_i$. <br>
    (b) DLT : A solution of $A\mathbf{p} = 0$ subject to $\lVert \mathbf{p} \rVert = 1$ --> SVD!
  2. Minimization of geomteric error : <br>
    \- minimize the geometric error by LM using the linear estimate as a starting point. <br>
    \- $\sum_{i}d(\mathbf{x}\_i, P\mathbf{X}\_i)^2$$ 
  3. Denormalization : $P = T^{-1}\tilde{P}U$
  
## 3. Camera matrix decomposition
  
* Once the projection matrix, P is obtained, the camera center can be calculated as follows.

$$P = KR[I|-\tilde{\mathbf{C}}]$$

$$= M[I|-\tilde{\mathbf{C}}]$$

$$= [M|-M\tilde{\mathbf{C}}]$$

$$= [M|\mathbf{p}\_4]$$
  
$$\tilde{\mathbf{C}} = -M^{-1}\mathbf{p}\_4 \quad \rightarrow \quad C = \begin{pmatrix}
-M^{-1}\mathbf{p}\\
1 \end{pmatrix}, \qquad \qquad K = \begin{bmatrix}
\alpha_x & s & x_0 \\
0 & \alpha_y & y_0 \\
0 & 0 & 1 \\ \end{bmatrix}
$$

* Since $M = KR$, $KR$ can be found by decomposing M using "QR Decomposition".
