# Triangulation 

## Computation of F

* We will study about how to estimate the fundamental matrix given a set of point correspondences between two images.
* The Fundamental matrix is defined by the equation $\mathbf{x}^{\prime}F\mathbf{x} = 0$, for any pair of matching points $\mathbf{x} \leftrightarrow \mathbf{x}^{\prime}$ in two images.
* Given sufficiently many point matches $\mathbf{x}\_i \leftrightarrow \mathbf{x}\_i^{\prime}$ (at least 7), <br>
  $\mathbf{x}^{\prime}F\mathbf{x} = 0$ can be used to compute the unknown matrix F.
* In particular, $\mathbf{x} = (x,y,1)^T$ and $\mathbf{x}^{\prime} = (x^{\prime},y^{\prime},1)^T$ gives rise to one linear equation in the unknown entries of F.
* The coefficients of the equation are easily written in terms of the known coordinates $\mathbf{x}$ and $\mathbf{x}^{\prime}$.
 (즉, F는 7 DOF 이므로, 7개의 이상의 매칭점이 필요하다.)
 
![image](https://user-images.githubusercontent.com/60316325/233006512-f8a6931a-513b-4998-ac9b-22c3b44b94e9.png)

* If $\mathbf{f}$ is the 9-vector made up of the entries of $F$, the above equation can be expressed as a vector inner product as..

![image](https://user-images.githubusercontent.com/60316325/233011134-09e2305a-f631-42b4-ae61-5791448e1c67.png)

* From a set of $n$ point matches, we obtain a set of linear equations of the form as..

![image](https://user-images.githubusercontent.com/60316325/233013645-c7e15331-d7f0-4fa0-8b72-6c2e73fa31a8.png)

* This is a homogeneous set of equations, and $\mathbf{f}$ can only be determined up to scale.<br>
 (일반적으로 여기서 p to scale 의미는, 결과적으로 나온 3D 상의 $\mathbf{X}$에 대한 거리 정보는 알 수 없고 비율 정보만 알 수 있다.) <br>
 (한마디로, 카메라 중심과 $\mathbf{x}$를 잇는 선상위에 수많은 $\mathbf{X}$가 있지만, 어떤 거리에 있는 \mathbf{X}$가 투영되었는지는 알 수 없다.)
 
![image](https://user-images.githubusercontent.com/60316325/233018141-58b16cd5-dc90-442d-9a76-7ae5c387cc89.png)

* For a solution to exist, matrix $A$ must have rank at most 8, and if the rank is exactly 8, <br>
  then the solution is unique and can be found by linear method.
* If the data is not exact, because of noise in the point coordinate, then the rank of $A$ may be greater than 8 <br>
  (In fact, equal to 9, since $A$ has 9 columns).
* In this case, one finds a **least-squares** solution.
* The least-square solution for $f$ is the last column of $V$ in the **SVD ($A=UDV^T$)**
* The solution vector $\mathbf{f}$ found in this way minimizes $A\mathbf{f}$ subject to the condition $\lVert \mathbf{f} \rVert = 1$.
* The algorithm just described is the essence of a method called the **8-point algorithm** for computation of the $F$ matrix.

### Singularity Constarints

- An important property of the fundamental matrix is that it is singular (rank = 2)
- For instance, if the fundamental matrix is non-singular matrix, then computed epipolar lines are not coincident.

![image](https://user-images.githubusercontent.com/60316325/233038621-557a1d26-ca82-42b3-930c-75099dcfc2a7.png)

- The matrix F found by solving the set of linear equations will not in general have rank 2. Thus, we should take steps to enforce this constraints
- A convenient method of doing this is to use SVD.
  - In particular, let $UDV^T$ be the SVD of $F$, where $D$ is a diagonal matrix<br>
    $D$ = diag(r,s,t) satisfying $r\ge s\ge t$.
  - Then, $F^{\prime} = U$ diag(r,s,0) $V^T$

## Normarlized 8-Point Algorithm

* The 8-point algorithm is the simplest method of computing the fundamental matrix.
* The key to success with the **8-point Algorithm** is proper normalization of the input data before constructing the equations.
* A simple transformation(translation, scaling) of the points in the image leads to an enormous improvement.
* The added complexity of the algorithm necessary to do this transformation is insignificant.

* Objective :
  - Given $n\ge 8$ image points correspondences $\mathbf{x}\_i \leftrightarrow \mathbf{x}\_i^{\prime}$, determine the $F$ matrix such that $\mathbf{x}^{\prime}F\mathbf{x} = 0$.

#### Algorithm :
  - **Normalization :**
    - Transform the image coordinates according to $\hat{\mathbf{x}}\_i = T\mathbf{x}\_i$ and  $\hat{\mathbf{x}}\_i^{\prime} = T^{\prime}\mathbf{x}\_i^{\prime}$,
      where $T$ and $T^{\prime}$ are normalizing transformations consisting of a translation and scaling.
  - Find the fundamental matrix $\hat{F}^{\prime}$ corresponding to matches $\hat{\mathbf{x}}\_i \leftrightarrow \hat{\mathbf{x}}\_i^{\prime}$ by..
    - (a) **Linear Solution** : Determine $\hat{F}$ from the singular vector corresponding to the smallest singular value of $\hat{A}$, <br>
      where $\hat{A}$ is composed from the matches $\hat{\mathbf{x}}\_i \leftrightarrow \hat{\mathbf{x}}\_i^{\prime}$.
    - (b) **Constraint enforcement** : Replace $\hat{F}$ by $\hat{F}^{\prime}$ such that $det(\hat{F}^{\prime}) = 0$ using SVD.
  - **Denormalization :**
    - Set $F = T^{\prime \ T}\hat{F}^{\prime}T.$ Matrix $F$ is the Fundamental matrix corresponding to the original data $\hat{\mathbf{x}}_i^{\prime} = T^{\prime}\mathbf{x}\_i^{\prime}$.

### Symmetric epipolar distance

* We can minimize the distance of a point from its projected epipolar line, computed in each of images.
* However, since first equation (Cost Function) seems to give slightly inferior results, Sampson distance is more widely used.

![image](https://user-images.githubusercontent.com/60316325/233053231-8c9a91b9-c1fe-4a54-9c1b-d7c63cd606f2.png)

![image](https://user-images.githubusercontent.com/60316325/233053754-ab1464ae-5d13-428f-946f-9fc36101427b.png)

## Automatic Computation of F using RANSAC

* In case of automatic computation of $F$, point matching results inevitable include some outliers. <br>
 (자동으로 F matrix를 계산하는 상황에서 특징점 매칭 결과 내의 이상치는 피할 수 없다.)
* Thus, we have to use a robust estimator such as **RANSAC**.

![image](https://user-images.githubusercontent.com/60316325/233054275-f4ff3bb0-2c31-47fb-a7c9-8699d76420e2.png)

## Image Rectification

* Image Rectification is a process that makes the epipolar lines run parallel with the x-axis,<br>
  and consequently disparities between the images are in the x-direction only (there is no y disparity(격차)) <br>
  (Epipolar line을 평행하도록 이미지를 변환하는 과정을 의미하는데, 맵핑 후의 점을 해당 epipolar line 에서만 찾으면 되므로 매우 간결해짐.)

![image](https://user-images.githubusercontent.com/60316325/233062659-37b6f40c-01db-4ef9-afa2-9f0bf4cd25e0.png)

* So This makes the point matching procedure much easier.

* In fact, if epioplar lines are to be transformed to lines parallel with the x-axis, <br>
  then the epipole should be mapped to the particular infinite point $(1, 0, 0)^T$. <br>
  (즉, epipolar line을 x축과 평행하게 변환하기 위해 , 기존의 epipole 또한 특정 무한대의 점으로 매핑시켜야 한다.) 
  
* Thus, we have to find a projective transformation $H$ of an image that maps the epipole to a point at infinity.<br>
  (따라서 우리는 epipole을 특정 무한대의 점으로 매핑하는 이미지의 $H$ Matrix를 찾아야 한다.)
* Suppose $\mathbf{x}\_0$ is the origin and the epipole $\mathbf{e} = (f, 0, 1)^T$ lies on the x-axis.
* The following transformation takes the epipole $(f,0,1)^T$ to the point at infinity $(f, 0, 0)^T$ as required. 

$$ G = \begin{bmatrix}
1&0&0 \\
0&1&0 \\
-1/f&0&1
\end{bmatrix}$$

* For an arbitrarily(임의로) placed point of interest $\mathbf{x}\_0$ and epipole $\mathbf{e}$, the required mapping H is a product $H = GRT$.
  * $T$ is a translation taking the point $\mathbf{x}\_0$ to the origin.
  * $R$ is a rotation about the origin taking the epipole $\mathbf{e}^{\prime}$ to a point $(f,0,1)^T$ on the x-axis.
  * $G$ is the mapping that takes $(f,0,1)^T$ to infinity.

## Linear Triangulation Methods

* It is supposed that the camera matrices and the fundamental matrix are provided.
* Since there are errors in the measured points $\mathbf{x}$ and $\mathbf{x}^{\prime}$, the rays back-projected from the points are skew(비스듬함).
* This means that there will not be a point $\mathbf{X}$ which exactly satisfies $\mathbf{x} = P\mathbf{x}$ and $\mathbf{x}^{\prime} = P^{\prime}\mathbf{X}$ <br>
  and the image points do not satisfy the epipolar constraints $\mathbf{x}^{\prime}F\mathbf{x} = 0$. <br>
  ($\mathbf{x} = P\mathbf{X}$ 과 $\mathbf{x}^{\prime} = P^{\prime}\mathbf{X}$ 를 '정확히' 만족하는 3D 상의 점 $\mathbf{X}$은 없으며, 이미지 상의 점들은 
   Epipolar Constraint 를 만족하지 못한다.) 
* These statements are equivalent since the two rays corresponding to matching pair of points $\mathbf{x}\_i \leftrightarrow \mathbf{x}\_i^{\prime}$ will meet <br>
  in space if and only if the points satisfy the epipolar constraint. <br>
  (즉, 대응되는 점 $\mathbf{x}\_i \leftrightarrow \mathbf{x}\_i^{\prime}$ 각각을 통과하는 2개의 선은 오직 점들이 Epipolar Constraint 를 만족할 때만 공간에서 만나게 된다.)

![image](https://user-images.githubusercontent.com/60316325/233072459-64551a8b-fa36-4d76-9ba7-df8e726b5463.png)

* (a) shows Rays back-projected from imperfect measured points $\mathbf{x}$, $\mathbf{x}^{\prime}$  are skew in 3D space in general.
* (b) The epipolar geometry for $\mathbf{x}$, $\mathbf{x}^{\prime}$ do not satisfy the epipolar constraint.

* The Linear Triangulation method is the direct analogue of the DLT method.
* In each image, we have a measurement $\mathbf{x} = P\mathbf{X}$ and $\mathbf{x}^{\prime} = P^{\prime}\mathbf{X}.
* These equations can be combined into a form $A\mathbf{X} = 0$, which is an equation linear in $\mathbf{X}$.

* For the first image, $\mathbf{x} \times (P\mathbf{X}) = 0$ and writing this out gives. ..
  * $\mathbf{p}^{iT}$ indicates the $i$-th row of $P$ (1x3)
  * Only two of them are linearly independent

$$x(\mathbf{p}^{3T}\mathbf{X}) - (\mathbf{p}^{1T}\mathbf{X}) = 0$$

$$y(\mathbf{p}^{3T}\mathbf{X}) - (\mathbf{p}^{2T}\mathbf{X}) = 0$$

$$x(\mathbf{p}^{2T}\mathbf{X}) - y(\mathbf{p}^{1T}\mathbf{X}) = 0$$

* These equations are linear in the components of $\mathbf{X}$.
* An equation of the form $A\mathbf{X} = 0$ can then be composed with..

$$A = \begin{bmatrix}
x\mathbf{p}^{3T} - \mathbf{p}^{1T} \\
y\mathbf{p}^{3T} - \mathbf{p}^{2T} \\
x^{\prime}\mathbf{p}^{\prime \ 3T} - \mathbf{p}^{\prime \ 1T} \\
x^{\prime}\mathbf{p}^{\prime \ 3T} - \mathbf{p}^{\prime \ 2T} \\
\end{bmatrix}$$

* **Homogeneous method**
  * $\mathbf{X}$ can be found by applying SVD.

* **Inhomogeneous method**
  * By setting $\mathbf{X}=(X,Y,Z,1)^T$, we have four inhomogeneous equations in three unknowns.
  * $\mathbf{X}$ can be found by applying the pseudo-inverse.
  * However, difficulties arise if the true solution $\mathbf{X}$ has last coordinate equal or close to 0. (X,Y,Z,0)....
 
