# Parameter Estimation

2D homography (projective transformation)
  * Given a set of ($\mathbf{x}\_i, \mathbf{x}\_i^{\prime}$), compute H ($\mathbf{x}\_i^{\prime} = H\mathbf{x}\_i$).

## 1. Direct Linear Transformation (DLT)

![image](https://user-images.githubusercontent.com/60316325/232434856-9255bda9-70ed-4c78-8c78-690de2b9f69d.png)

$$\mathbf{x}\_i^{\prime} = H\mathbf{x}\_i$$

* They have the same direction but may differ in magnitude by a non-zero scale factor. Thus.. <br>
(Cross product of same direction vector = 0, because $sin(\theta)$ element.)

$$\mathbf{x}\_i^{\prime} \times H\mathbf{x}\_i = 0 $$

* We can expressed equation as...

$$\mathbf{x}\_i^{\prime} = (x_i^{\prime},y_i^{\prime},w_i^{\prime})^T \quad H\mathbf{x}\_i = \begin{pmatrix}
\mathbf{h}^{1\ T}\mathbf{x}\_i \\
\mathbf{h}^{2\ T}\mathbf{x}\_i \\
\mathbf{h}^{3\ T}\mathbf{x}\_i \\ \end{pmatrix}, \quad \mathbf{h}^{k\ T} = \begin{pmatrix}
h_{k1} \\
h_{k2} \\
h_{k3} \\ \end{pmatrix}
$$

$$\mathbf{x}\_i^{\prime} \times H\mathbf{x}\_i = [ \mathbf{x}\_i^{\prime} ]\_{\times}(H\mathbf{x}\_i) = \begin{pmatrix}
y_i^{\prime}\mathbf{h}^{3\ T}\mathbf{x}\_i - w_i^{\prime}\mathbf{h}^{2\ T}\mathbf{x}\_i \\
w_i^{\prime}\mathbf{h}^{1\ T}\mathbf{x}\_i - x_i^{\prime}\mathbf{h}^{3\ T}\mathbf{x}\_i \\
x_i^{\prime}\mathbf{h}^{2\ T}\mathbf{x}\_i - y_i^{\prime}\mathbf{h}^{1\ T}\mathbf{x}\_i \\ \end{pmatrix} = \begin{bmatrix}
\mathbf{0}^T & -w_i^{\prime}\mathbf{x}\_i^T & y_i^{\prime}\mathbf{x}\_i^T \\
w_i^{\prime}\mathbf{x}\_i^T & \mathbf{0}^T & -x_i^{\prime}\mathbf{x}\_i^T \\
y_i^{\prime}\mathbf{x}\_i^T & x_i^{\prime}\mathbf{x}\_i^T & \mathbf{0}^T \\ \end{bmatrix}\begin{pmatrix}
\mathbf{h}^{1}\\
\mathbf{h}^{2}\\
\mathbf{h}^{3}\\ \end{pmatrix} = A_i\mathbf{h} = 0$$

* Only 2 out of 3 are linearly independent (indeed, 2 equations per point). We can reduce matrix.

$$ 
\begin{bmatrix}
\mathbf{0}^T & -w_i^{\prime}\mathbf{x}\_i^T & y_i^{\prime}\mathbf{x}\_i^T \\
w_i^{\prime}\mathbf{x}\_i^T & \mathbf{0}^T & -x_i^{\prime}\mathbf{x}\_i^T \\
y_i^{\prime}\mathbf{x}\_i^T & x_i^{\prime}\mathbf{x}\_i^T & \mathbf{0}^T \\ \end{bmatrix}\begin{pmatrix}
\mathbf{h}^{1}\\
\mathbf{h}^{2}\\
\mathbf{h}^{3}\\ \end{pmatrix} =\begin{bmatrix}
\mathbf{0}^T & -w_i^{\prime}\mathbf{x}\_i^T & y_i^{\prime}\mathbf{x}\_i^T \\
w_i^{\prime}\mathbf{x}\_i^T & \mathbf{0}^T & -x_i^{\prime}\mathbf{x}\_i^T \\ \end{bmatrix}\begin{pmatrix}
\mathbf{h}^{1}\\
\mathbf{h}^{2}\\
\mathbf{h}^{3}\\ \end{pmatrix}
$$

* Solving for H using 4 points. ( A is an 8x9 matrix)

$$
\begin{bmatrix}
A_1 \\
A_2 \\
A_3 \\
A_4 \end{bmatrix} \mathbf{h} = A\mathbf{h} = 0 \qquad A = \begin{bmatrix}
\mathbf{0}^T & -w_i^{\prime}\mathbf{x}\_i^T & y_i^{\prime}\mathbf{x}\_i^T \\
w_i^{\prime}\mathbf{x}\_i^T & \mathbf{0}^T & -x_i^{\prime}\mathbf{x}\_i^T \\ \end{bmatrix}
$$

![image](https://user-images.githubusercontent.com/60316325/232469611-272702bb-9914-4b7e-ac66-f9312a6ad653.png)

* But if Over-determined solution (more than 4 points), No exact solution because of inexact measurements (i.e. "Noise"). <br>
  So we have to Find approximate solution
  * Additional constraints needed to avoid $\mathbf{0}$, (e.g. $\lVert \mathbf{h} \rVert$ = 1)
  * $A\mathbf{h}$ is not possible, so minimize $\lVert A\mathbf{h} \rVert$. ==> **Use SVD!**

### DLT Algorithm

- Given $n\ge 4$ 2D to 2D point correspondences { $\mathbf{x}\_i \leftrightarrow \mathbf{x}\_i^{\prime}$ }, <br>
  determine the 2D homography matrix $H$ such that $\mathbf{x}\_i^{\prime} = H\mathbf{x}\_i$.

  1. For each correspondence $\mathbf{x}\_i \leftrightarrow \mathbf{x}\_i^{\prime}$, compute $A_i$. Usually only two first rows needed.
  2. Assemble $n$ to $2\times9$ matrices $A_i$ into a single $2n\times9$ matrix A.
  3. Obtain SVD of A. Solution for $\mathbf{h}$ is last column of V.
  4. Determine $H$ from $\mathbf{h}$.

## 2. Normarlized Direct Linear Transformation

* Typical image points $\mathbf{x}\_i$ and $\mathbf{x}\_i^{\prime}$ are like $(x,y,w)^T = (100,100,1)^T$. <br>
  (일반적으로 이미지상의 점은, $(x,y,w)^T$ 차수(Order)이다.)

* Order of magnitude are quite different.
* In the presence of noise, this difference makes the solution diverge from the correct result.
* So. We can simply transform points before estimating homography to sove this problem.
  
* Trnasformation
  * The points are translated so that their centroid is at origin.
  * The points are then scaled so that the average distance from the origin is equal to $\sqrt{2}$.
  * This transformation is independently applied to two images.

* This can be done by applying the following transformation :

$$T_{norm} = \begin{bmatrix}
w+h & 0 & w/2 \\
0 & w+h & h/2 \\
0 & 0 & 1 \\ \end{bmatrix} ^{-1} $$

### Normalized DLT Algorithm

- Given $n\ge 4$ 2D to 2D point correspondences { $\mathbf{x}\_i \leftrightarrow \mathbf{x}\_i^{\prime}$ }, <br>
  determine the 2D homography matrix $H$ such that $\mathbf{x}\_i^{\prime} = H\mathbf{x}\_i$.

  1. Normalize Points. $\tilde{\mathbf{x}\_i} = T_{norm} \mathbf{x}\_i \quad \tilde{\mathbf{x}\_i}^{\prime} = T_{norm}^{\prime} \mathbf{x}\_i^{\prime}$
  2. Apply DLT algorithm to $\tilde{\mathbf{x}\_i} \leftrightarrow \tilde{\mathbf{x}\_i}^{\prime}$
  3. Denormalize solution

$$H = T_{norm}^{\prime \ -1}\tilde{H}T_{norm}, \qquad \mathbf{x}\_i^{\prime} = T_{norm}^{\prime \ -1}\tilde{H}T_{norm}\mathbf{x}\_i$$

## 3. Iterative Estimation

## Degenerate configuration

* A homography is computed using four corresponding points, and suppose that three of the points $\mathbf{x}\_1, \mathbf{x}\_2, \mathbf{x}\_3$ are collinear(같은선상).
  * **case 1**. The corresponding points $\mathbf{x}\_1^{\prime}, \mathbf{x}\_2^{\prime}, \mathbf{x}\_3^{\prime}$ are also collinear.
    * The homography is not sufficiently constrained, and there will exist a family of homographies mapping $\mathbf{x}_i$ to $\mathbf{x}\_i^{\prime}$.
  * **case 2**. The corresponding points $\mathbf{x}\_1^{\prime}, \mathbf{x}\_2^{\prime}, \mathbf{x}\_3^{\prime}$ are not collinear.
    * There can be no transformation $H$ taking $\mathbf{x}_i$ to $\mathbf{x}\_i^{\prime}$ since a projective transformation must preserve collinearity.

* A homography cannot be estimated in this case

![image](https://user-images.githubusercontent.com/60316325/232481367-112c895e-71b4-4eec-a55e-4e22be137a8b.png)

## Geometric Error

* Symmetric transfer Error

![image](https://user-images.githubusercontent.com/60316325/232482079-40e4cb8a-7ccc-433a-9d03-44a62cdd7133.png)

$$e = \sum_{i}(d(\mathbf{x}\_i, H^{-1}\mathbf{x}\_i^{\prime})^2 + d(\mathbf{x}\_i^{\prime}, H\mathbf{x})^2)$$

  * The first term is the transfer error in the first image.
  * The second term is transfer error in the second image.
  * The estimated homography $\hat{H}$ is the one that minimizes.

$$\hat{H} = argmin_H \sum_{i}(d(\mathbf{x}\_i, H^{-1}\mathbf{x}\_i^{\prime})^2 + d(\mathbf{x}\_i^{\prime}, H\mathbf{x})^2)$$

## Iterative Estimation Algorithm.

- Given $n\ge 4$ 2D to 2D point correspondences { $\mathbf{x}\_i \leftrightarrow \mathbf{x}\_i^{\prime}$ }, determine the $H$ <br>
  (this also implies computing optimal $\mathbf{x}\_i^{\prime} = H\mathbf{x}\_i$)

  1. Initialization : Compute an initial estimate using normalized DLT or RANSAC
  2. Geometric minimization : Minimize the geometric error using "Levenberg-Marquardt" over 9 entries of H
