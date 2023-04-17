# Basic Knowledge about Projective Geometry

### 1. Lines and Points in Homogeneneous Coordinates

* Homogeneous representation of "lines"
  * $ax+by+c = 0, \quad (a,b,c)^T$
  * $(ka)x+(kb)y+(kc)=0, \quad \forall k\neq 0, \quad (a,b,c)^T \sim k(a,b,c)^T$ 
  * **$(a,b,c)^T$** and **$k(a,b,c)^T$** represent the same line, for any non-zero constant $k$.

* Homogeneous representation of "points"
  * $\mathbf{x} = (x,y)^T$ on $\mathbf{l} = (a,b,c)^T$, if and only if $ax+bx+c = 0$
  * $(x,y,1)(a,b,c)^T = (x,y,1)\ \mathbf{l} = 0 \quad (x,y,1)^T \sim k(x,y,1)^T, \quad \forall k\neq 0$
  * In general, $(x,y,0)^T$ is called a point at infinity (Think about intersection point in parallel two lines)

* The point $\mathbf{x}$ lies on the line $\mathbf{l}$ if and only if $\mathbf{x}^T\ \mathbf{l} = \mathbf{l}^T\ \mathbf{x} = 0$

* Intersection of lines
  * The intersection of two lines $l$ and $l^{\prime}$ is $\mathbf{x} = l\times l^{\prime}$
  * The Point $\mathbf{x}$ should be on the two lines $l$ and $l^{\prime}$.<br>
$$\mathbf{x}^Tl = (l\times l^{\prime})^Tl = 0 $$
$$\mathbf{x}^Tl^{\prime} = (l\times l^{\prime})^Tl^{\prime} = 0 $$

![image](https://user-images.githubusercontent.com/60316325/232305759-7ffa334d-d215-4ae3-a000-16755b68fd8f.png)

* Line Joining two points
  * The Line through two points $\mathbf{x}$ and $\mathbf{x}^{\prime}$ is $l = \mathbf{x}\times \mathbf{x}^{\prime}$
  * The Line $l$ should pass through the two points $\mathbf{x}$ and $\mathbf{x}^{\prime}$.
$$l^T\mathbf{x} = (\mathbf{x}\times \mathbf{x}^{\prime})^T\mathbf{x} = 0$$
$$l^T\mathbf{x}^{\prime} = (\mathbf{x}\times \mathbf{x}^{\prime})^T\mathbf{x}^{\prime} = 0$$

![image](https://user-images.githubusercontent.com/60316325/232306804-622644cf-ff44-46e2-b704-38236af063ba.png)

---

### 2. Projective Transformations

**Projective = collineation = projective transformation = homography**

* Definition <br>
  * A projectivity is an invertible mapping $h$ from $P^2$ to itself such that three points $\mathbf{x}\_1, \mathbf{x}\_2$ and $\mathbf{x}\_3$ lie on the <br>
    same line if and only if $h(\mathbf{x}\_1), h(\mathbf{x}\_2)$ and $h(\mathbf{x}\_3)$ do. 
  * A mapping $h:P^2 \rightarrow P^2$ is a projectivity if and only if there exist a non-singular 3x3 matrix $\mathbf{H}$ such that for <br>
    any point in $P^2$ represent by a vector $\mathbf{x}$, it is true that $h(x) = \mathbf{H}\mathbf{x}$
    
$$\begin{pmatrix}
x_1^{\prime} \\
x_2^{\prime} \\
x_3^{\prime} 
\end{pmatrix} = 
\begin{bmatrix}
h_{11}&h_{12}&h_{13}\\
h_{21}&h_{22}&h_{23}\\
h_{31}&h_{32}&h_{33} 
\end{bmatrix}
\begin{pmatrix}
x_1\\
x_2 \\
x_3 
\end{pmatrix}, \qquad \qquad \mathbf{x}^{\prime} = \mathbf{H}\mathbf{x}
$$

#### For a point transformation..

If $\mathbf{x}\_i$ is on $l$ and $\mathbf{x}\_i^{\prime}$ is on $l^{\prime}$. From $\mathbf{x}^{\prime} = \mathbf{H}\mathbf{x}$.. 

$$l^{\prime \ T}\mathbf{x}\_i^{\prime} = 0$$

$$l^{T}\mathbf{H}^{-1}\mathbf{H}\mathbf{x}\_i = 0$$

$$l^{\prime \ T}\mathbf{x}\_i^{\prime} = l^{T}\mathbf{H}^{-1}\mathbf{H}\mathbf{x}\_i$$

$$l^{\prime \ T} = l^{T}\mathbf{H}^{-1}$$

$$l^{\prime} = \mathbf{H}^{-T}l$$

* Example s of a projective transformation, $\mathbf{x}^{\prime} = \mathbf{H}\mathbf{x}$, arising in perspective image.
![image](https://user-images.githubusercontent.com/60316325/232307933-73ed8e7e-fd25-4107-afed-29ef7b5b1122.png)

* So, For Projective Transformations, We need 4 points. (2 constraints per point, 8 DOF) <br>
:paperclip: https://gaussian37.github.io/vision-concept-image_transformation/
![image](https://user-images.githubusercontent.com/60316325/232308489-61b663b7-8120-499c-856b-79aa6eb94dfb.png)

---

### 3. Parameter Estimation, Homography Estimation

* 2D homography, Given a set of ($\mathbf{x}\_i, \mathbf{x}\_i^{\prime}$), compute H ($\mathbf{x}\_i^{\prime} = \mathbf{H}\mathbf{x}\_i$)

* Number of measurements required.
  * At least as many independent equations as degrees of freedom required.
  * 2 independent equations per point, 8 degrees of freedom. (4x2 $\ge$ 8)

$$\mathbf{x}^{\prime} = \mathbf{H}\mathbf{x} \qquad \lambda\begin{bmatrix}
x^{\prime} \\
y^{\prime} \\
1 
\end{bmatrix} = 
\begin{bmatrix}
h_{11}&h_{12}&h_{13}\\
h_{21}&h_{22}&h_{23}\\
h_{31}&h_{32}&h_{33} 
\end{bmatrix}
\begin{pmatrix}
x\\
y \\
1 
\end{pmatrix}$$

* **1. Direct Linear Transformation (DLT)**
  * Find 3x3 Homography($\mathbf{H}$) using 4 correspond points in two images.
  * Given $n\ge 4$ 2D to 2D Point correspondences { $\mathbf{x}_i \leftrightarrow \mathbf{x}_i^{\prime}$ }, determine the $\mathbf{H}$ such that $\mathbf{x}_i^{\prime} = \mathbf{H}\mathbf{x}_i$.
  * Algorithm <br>
    -1. For each correspondence $\mathbf{x}_i \leftrightarrow \mathbf{x}_i^{\prime}$, compute $A_i$. Usually only two first rows needed.<br>
    -2. Assemble $n$ 2x9 matrices $A_i$ into a single 2$n$x9 matrix A.<br>
    -3. Obtain SVD of A. Solution for $\mathbf{h}$ is last column of V.<br>
    -4. Determine H from $\mathbf{h}$

* **2. Normalized Direct Linear Transformation**
  * Find 3x3 Homography($\mathbf{H}$) using 4 correspond points in two images.
  * Given $n\ge 4$ 2D to 2D Point correspondences { $\mathbf{x}_i \leftrightarrow \mathbf{x}_i^{\prime}$ }, determine the $\mathbf{H}$ such that $\mathbf{x}_i^{\prime} = \mathbf{H}\mathbf{x}_i$.
  * Algorithm <br>
    -1. Normalize points. $\tilde{\mathbf{x}\_i} = T_{norm} \mathbf{x}\_i \quad \tilde{\mathbf{x}\_i}^{\prime} = T_{norm}^{\prime} \mathbf{x}\_i^{\prime}$ <br>
    -2. Apply DLT algorithm to $\tilde{\mathbf{x}\_i} \leftrightarrow \tilde{\mathbf{x}\_i}^{\prime}$.<br>
    -3. Denormalize solution.<br>
    
$$H = T_{norm}^{\prime \ -1}\tilde{H}T_{norm}, \qquad \mathbf{x}\_i^{\prime} = T_{norm}^{\prime \ -1}\tilde{H}T_{norm}\mathbf{x}\_i$$
    
* **3. Iterative Estimation**
  * Given $n\ge 4$ 2D to 2D point correspondences { $\mathbf{x}\_i \leftrightarrow \mathbf{x}\_i^{\prime}$ }, determine the $H$ <br>
    (this also implies computing optimal $\mathbf{x}\_i^{\prime} = H\mathbf{x}\_i$)

  * Algorithm <br>
    -1. Initialization : Compute an initial estimate using normalized DLT or RANSAC.<br>
    -2. Geometric minimization : Minimize the geometric error using "Levenberg-Marquardt" over 9 entries of H.<br>
