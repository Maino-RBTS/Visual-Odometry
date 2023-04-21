# Epipolar Geometry

* Epiolar geometry is the intrinsic projective geometry between two views.
* It only depends on the camera's internal parameters and relative pose
* **The Fundamental matrix 'F'** encapsulates this intrinsic geometry. (F 행렬이 내부 geometry를 나타내고 있음)
* The Euclidean motion of the cameras between views may be computed from the fundamental matrix.
* Fundamental matrix can be computed from point correspondences.

## 1. Epipolar Geometry 

![image](https://user-images.githubusercontent.com/60316325/232724012-e0d91afa-d261-4168-b962-c1db08f78274.png)

* First, Suppose a point $\mathbf{X}$ in 3D is imaged in two views, at $\mathbf{x}$ in the first, and $\mathbf{x}^{\prime}$ in the second.
  * What is the relation between the correspoonding image points $\mathbf{x}$ and $\mathbf{x}^{\prime}$ ?
  * \- The image points $\mathbf{x}$ and $\mathbf{x}^{\prime}$, space point $\mathbf{X}$, and camera centers are coplanar. (Denote as $\pi$)<br>
    \- Ray back-projected from $\mathbf{x}$ and $\mathbf{x}^{\prime}$ intersect at $\mathbf{X}$ and the rays are coplanar lying in $\pi$. <br>
    \- This property is very important in searching for a corresponding point.<br>
    (즉, $\mathbf{x}, \mathbf{x}^{\prime}, \mathbf{X}$ 세점 모두 $\pi$ 평면상에 있으며, $\mathbf{x}$ 그리고 $\mathbf{x}^{\prime}$를 투영하는 각각의 광선은 $\mathbf{X}$에서 교차하며 $\pi$ 평면상에 있다.)
  
* Second, Suppose that we know only $\mathbf{x}$.
  * we may ask how the corresponding point $\mathbf{x}^{\prime}$ is constrained.
  * The plane $\pi$ is determined by the baseline (the line joining the camera center $\mathbf{C},\mathbf{C}^{\prime}$) and the ray defined by $\mathbf{x}$ and $\mathbf{C}$.<br>
    ($\pi$ 평면은, 두 카메라의 중심을 잇는 baseline과 $\mathbf{x}$ and $\mathbf{C}$ 를 잇는 카메라 광선을 통해 결정된다.)
  * The ray corresponding to the (unknown) point $\mathbf{x}^{\prime}$ lies in $\pi$.
  * So, the point $\mathbf{x}^{\prime}$ lies on the line of intersection $\mathbf{l}^{\prime}$ of $\pi$ with the second image plane. <br>
    (따라서, $\mathbf{x}^{\prime}$는 $\mathbf{l}^{\prime}$ 선상에 있게 된다.)
    
* line $\mathbf{l}^{\prime}$ is the image in the second view of the ray back-projected from $\mathbf{x}$.
* It is the **"epipolar line"** corresponding to $\mathbf{x}$. <br>
 (즉, Stereo matching 에서, $\mathbf{x}$에 상응하는 점을 찾기 위해 image plane 전체를 고려하지 않고, $\mathbf{l}^{\prime}$ 만을 고려하여 찾을 수 있다.)
    
### 1-1. Epipole 
 
  * The Point of intersection of the line joining the camera centers (the baseline) with the image plane.
  * The image in one view of the camera center of the other view.

### 1-2. Epipolar plane

  * A plane containing the baseline
  * There is a one-parameter family (a pencil) of epipolar planes.

### 1-3. Epipolar line
 
  * The intersection of an epipolar plane with the image plane.
  * All epipolar lines intersect at the epipole.
  * An epipolar plane intersects the left and right image planes in epipolar lines.
  * It defines the correspondence between the lines.

![image](https://user-images.githubusercontent.com/60316325/232729932-a4ae388d-0917-44f2-a8a0-74483dfc8a76.png)

## 2. Fundamental Matrix : Geometric Derivation

* Fundamental matrix is the algebraic representation (대수표현) of epipolar geometry.
* Given a pair of images, to each point $\mathbf{x}$ in one image, there exists a corresponding epipolar line $\mathbf{l}^{\prime}$ in the other image.
* Any point $\mathbf{l}^{\prime}$ in the second image matching the point $\mathbf{x}$ must lie on the epipolar line $\mathbf{l}^{\prime}$. <br>
 (두 번째 이미지 평면상의 $\mathbf{x}$와 매칭되는 어떠한 $\mathbf{x}^{\prime}$ 은 반드시 $\mathbf{l}^{\prime}$상에 놓여있음.)
 
 * The Epipolar line is the projection in the second image of the ray from the point $\mathbf{x}$ through the camera center $\mathbf{C}$ of the first camera. <br>
  (Epipolar line은 첫 번째 이미지 평면상의 점 $\mathbf{x}$와 카메라의 중심 $\mathbf{C}$를 통과하는 직선을 두 번째 평면에 투영시킨것과 같음)
 * Thus, there is a map from a point in one image to its corresponding epipolar line in the other image. ($\mathbf{x} \rightarrow \mathbf{l}^{\prime}$) <br>
  (따라서, 하나의 이미지 상의 점을 다른 이미지상의 epipolar line($\mathbf{l}^{\prime}$)으로의 map이 있다.)
 * This mapping from points to lines is represented by a **"Matrix F"**, the fundamental matrix.

### 2-1. Geometric Derivation of Fundamental Matrix

* We begin with a "geometric derivation" of the fundamental matrix.
* The mapping from a point in one image to a corresponding epipolar line in the other image may be decomposed into two step.
  * First, the point $\mathbf{x}$ is mapped to some point $\mathbf{x}^{\prime}$ in other image lying on the epipolar line $\mathbf{l}^{\prime}$ is obtained as the line joining with . <br>
    ($\mathbf{x}^{\prime}$ is a potential match for the point $\mathbf{x}$)
  * Second, the epipolar line $\mathbf{l}^{\prime}$ is obtained as the line joining with $\mathbf{x}^{\prime}$ to the epipole $\mathbf{e}^{\prime}$.

![image](https://user-images.githubusercontent.com/60316325/232752231-478c89f8-c18c-4ed0-85f8-556fd3062f88.png)

---

#### Step 1 : Point transfer via a plane

\- Consider a plane $\pi$ not passing through either of the two camera centers. <br>
\- The ray through the first camera center corresponding to the point $\mathbf{x}$ meets the plane $\pi$ in a point $\mathbf{X}$. <br>
   (카메라 중심과 $\mathbf{x}$를 통과하는 선은, $\pi$ 평면의 점 $\mathbf{X}$) <br>
\- This point $\mathbf{X}$ is then projected to a point $\mathbf{x}^{\prime}$ in the second image. <br>
\- This procedure is known as **transfer via the plane $\pi$**

* Since $\mathbf{X}$ lies on the ray corresponding to $\mathbf{x}$, the projected point $\mathbf{x}^{\prime}$ must lie on the epipolar line $\mathbf{l}^{\prime}$ corresponding to the image of this ray.
* The points $\mathbf{x}$ and $\mathbf{x}^{\prime}$ are both images of the 3D point $\mathbf{X}$ lying on a plane. <br>
  ($\mathbf{x}$ 그리고 $\mathbf{x}^{\prime}$ 점은 모두 $\pi$ 평면상에 있는 3D 점을 찍은 이미지 이다.)
* The set of all such points $\mathbf{x}\_i$ and the corresponding points $\mathbf{x}\_i^{\prime}$ are the images of the planar point set $\mathbf{X}\_i$.
* Thus. there is a 2D homography $H_{\pi}$ mapping each $\mathbf{x}\_i$ to $\mathbf{x}\_i^{\prime}$.
  
#### Step 2 :
  
* Given the point $\mathbf{x}^{\prime}$, the epipolar line $\mathbf{l}^{\prime}$ passing through $\mathbf{x}^{\prime}$ and the epipole $\mathbf{e}^{\prime}$ can be
  written below
  
$$\mathbf{l}^{\prime} = \mathbf{e}^{\prime} \times \mathbf{x}^{\prime} = [\mathbf{e}^{\prime}]\_{\times} \mathbf{x}^{\prime}$$
  
* Since $\mathbf{x}^{\prime}$ may be written as $\mathbf{x}^{\prime} = H_{\pi}\mathbf{x}$, we have..

$$\mathbf{l}^{\prime} = [\mathbf{e}^{\prime}]\_{\times}H_{\pi}\mathbf{x} = $\mathbf{x}$$

* $F = [\mathbf{e}^{\prime}]\_{\times}H_{\pi}$ is the **"fundamental matrix."**
  
---
  
* Back to the Point. The fundamental matrix F may be written as $F = [\mathbf{e}^{\prime}]\_{\times}H_{\pi}$.
  * $H_{\pi}$ is the transfer mapping from one image to another image via any plane $\pi$.
  * Since $[\mathbf{e}^{\prime}]\_{\times}$ has rank 2, and $H_{\pi}$ rank 3, F is a matrix of rank 2.

* Note, the geometric derivation above involves a scene plane $\pi$, but a plane is not required in order for F to exist.
  * The plane is simply used here as a means of defining a point map one image to other.
  
## 3. Fundamental Matrix : Algebric Derivation

* The form of the fundamental matrix in terms of the two camera projection matrices, $P$ and $P^{\prime}$, may be **"derived algebraically"** (P include $K$ and $[R|t]$)
* The ray back-projected from $x$ by $P$ is obtained by solving $P\mathbf{X} = \mathbf{x}$.
  * We know two points on this ray : camera center $C$ and the point $P^+\mathbf{x}$. ($P^+ = P^T(PP^T)^{-1}$ is the pseudo-inverse of $P$).
  * Point $P^+\mathbf{x}$ lies on the ray because it projects to $\mathbf{x}$, since $P(P^+\mathbf{x}) = I\mathbf{x} = \mathbf{x}$.
  * Then, the ray is the line formed by the join of these two point as..

$$\mathbf{X}(\lambda) = P^+\mathbf{x} + \lambda \mathbf{C}$$

![image](https://user-images.githubusercontent.com/60316325/232781907-0272ecb0-f586-4ed5-a5a2-013146e80875.png)

- The two points ($P^+\mathbf{x}$ and $\mathbf{C}$) are imaged by the second camera $P^{\prime}$ at $P^{\prime}P^+\mathbf{x}$ and $P^{\prime}\mathbf{C}$, respectively in the second view.
- The epipolar line is the line joining these two projected points namely $\mathbf{l}^{\prime} = (P^{\prime}\mathbf{C})\times(P^{\prime}P^+\mathbf{x}).$
- The point $P^{\prime}\mathbf{C}$ is the epipole in the second image, namely the projection of the first camera center, and my be denoted by $\mathbf{e}^{\prime}$.
- Thus, $\mathbf{l}^{\prime} = [\mathbf{e}^{\prime}]\_{\times}(P^{\prime}P^+)\mathbf{x} = F\mathbf{x}$, where F is the matrix. $F = [\mathbf{e}^{\prime}]\_{\times}(P^{\prime}P^+)$

$$F = [\mathbf{e}^{\prime}]\_{\times}H_{\pi}$$

$$F = [\mathbf{e}^{\prime}]\_{\times}(P^{\prime}P^+)$$

$$H_{\pi} = (P^{\prime}P^+)$$

- Note that when the two camera centers are the same, F becomes the zero matrix.

### Basic properties of Fundamental Matrix

* So $\mathbf{x}^{\prime}$ lies on $\mathbf{l}^{\prime}$, we can write $\mathbf{x}^{\prime \ T}\mathbf{l}^{\prime} = 0$.

$$\mathbf{x}^{\prime \ T}\mathbf{l}^{\prime} = \mathbf{x}^{\prime \ T}F\mathbf{x} = 0$$

* $\mathbf{x}^{\prime \ T}F\mathbf{x} = 0$ is important. <br>
  Because This enables F to be computed from image **correspondences alone** without reference to the camera matrices.
* In other words. We have seen that F may be computed from the two camera matrices. $F = [\mathbf{e}^{\prime}]\_{\times}P^{\prime}P^+$, <br>
  But now, we may enquire how many correspondences are required to compute F from $\mathbf{x}^{\prime \ T}F\mathbf{x} = 0$ ?? <br>
  and the circumstances under which the matrix is uniquely defined by these correspondences.<br> 
 (한마디로, F를 계산하기 위해 얼마나 많은 대응점들이 필요한지, 그리고 이러한 대응점들의 Matrix를 유일하게 정의할 수 있는 상황이 중요하다.)
 
* Suppose, we have two images acquired by cameras with non-coincident centers(중심이 같지않음), then the fundamental matrix F is the unique 3x3 rank 2 matrix which satisfies $\mathbf{x}^{\prime \ T} F \mathbf{x} = 0$ for all corresponding point $\mathbf{x} \leftrightarrow \mathbf{x}^{\prime}= 0$. <br>
(두 점에의해 정의되는 선이 $\mathbf{x}^{\prime \ T} F \mathbf{x} = 0$를 만족한다면, 두 선(rays)은 같은 평면상에 있다는 말과 같음.)

* **Properties**
  - Transpose :
    - if $F$ is the matrix of the pair of cameras $(P,P^{\prime})$, then $F^T$ is the fundamental matrix of the pair in the opposite order : $(P^{\prime},P)$
  - Epipolar lines :
    - For any point $\mathbf{x}$, the corresponding epipolar line is $\mathbf{l}^{\prime} = F\mathbf{x}$. <br>
      Similarly, $\mathbf{l} = F^T\mathbf{x}^{\prime}$ represents the epipolar line corresponding to $\mathbf{x}^{\prime}$.
  - Epipole :
    - The epipolar line $\mathbf{l}^{\prime} = F\mathbf{x}$ contains the epipole $\mathbf{e}^{\prime}$
    - Thus, $\mathbf{e}^{\prime}$ satisfies $\mathbf{e}^{\prime \ T}(F\mathbf{x}) =(\mathbf{e}^{\prime \ T}F)\mathbf{x} = 0$ for all $\mathbf{x}$.
    - It follows that $\mathbf{e}^{\prime \ T}F = 0$. $\mathbf{e}^{\prime}$ is the left null-vector of $F$.
    - Similarly $F\mathbf{e} = 0$. $\mathbf{e}$ is the right null-vector of $F$.
    - **$\mathbf{e}$ and $\mathbf{e}^{\prime}$ can be found by calculation the left and right null-vector of F.**
  - F has 7 DOF :
    - A 3x3 matrix has eight independent ratios. (because one can be normalized)
    - There are nine elements, and the common scaling is not significant. (-1 DOF) <br>
    - However, $F$ also satisfies the constraints det($F$) = 0 which removes one DOF. (-1 DOF)<br>
      ( More detail about reason : https://stackoverflow.com/questions/49763903/why-does-fundamental-matrix-have-7-degrees-of-freedom )
      
      ![image](https://user-images.githubusercontent.com/60316325/232971365-1c8b7299-8959-430c-8212-29aa7f72304a.png)

  - F is a projective map taking a point to line :
    - A point in the first image $\mathbf{x}$ defines a line in the second $\mathbf{l}^{\prime} = F\mathbf{x}$, which is the epipolar line of $\mathbf{x}$. <br>
     (첫 이미지에서의 특정 점 $\mathbf{x}$가 두번째 이미지에서의 Epipolar line을 정의한다.)
    - If $\mathbf{l}$ and $\mathbf{l}^{\prime}$ are corresponding epipolar lines, then any point $\mathbf{x}$ on $\mathbf{l}$ is mapped to the same line $\mathbf{l}^{\prime}$ <br>
     (만약 $\mathbf{l}$ 과 $\mathbf{l}^{\prime}$이 상응하는 epipolar line 이면, $\mathbf{l}$ 상의 모든 $\mathbf{x}$들은 $\mathbf{l}^{\prime}$에 매핑된다.)
    - **F is not of full rank, There is no point to point mapping between two iamges taken at different locations**.

### Pure Translational motion : F matrix (순수 병진운동)

- In considering pure translations of the camera. one may consider the equivant situation in which the camera is stationary <br>
  and the world undergoes a translation $\mathbf{t}$. <br>
  (카메라는 움직이지 않고, 물체가 Pure translation을 한다고 생각해보자.)

![image](https://user-images.githubusercontent.com/60316325/232974711-c426582a-fe34-4b95-bd01-3f026e78374c.png)

- Points in 3D, move on straight lines parallel to $\mathbf{t}$, and the imaged intersection of these parallel lines is the <br>
  vanishing point $\mathbf{v}$ in the direction of $\mathbf{t}$.
  - $\mathbf{v}$ is the epipole for both views, and the imaged parallel lines are the epipolar lines. <br>
   (두 이미지에서 $\mathbf{v}$는 epipole이며, 이미지 상의 평행 선은 epipolar line이 된다.)
   
- Suppose the motion of the cameras is a pure translation with no rotation and no change in the internal parameters.

![image](https://user-images.githubusercontent.com/60316325/232980298-7ad04662-2d2f-40a4-8301-aa450ead165e.png)

- But, this is pure translation case. so,

![image](https://user-images.githubusercontent.com/60316325/232981614-fc5b2adf-8a38-41b6-9081-a9d403e7d709.png)

- If the camera translation is parallel to the x-axis, then $\mathbf{e}^{\prime} = (1,0,0)^T$.

![image](https://user-images.githubusercontent.com/60316325/232982069-abdbf9d6-6a8f-403c-a259-7ca9cb42b3dc.png)

- The relation between corresponding points, $\mathbf{x}^{\prime}F\mathbf{x} = 0$, reduces to $y=y^{\prime}$, (i.e. the epipolar lines are corresponding rasters(pixel)).<br> 
 (즉, x축으로의 평행이동이 이루어질 때, 대응되는 점 간의 관계($\mathbf{x}^{\prime}F\mathbf{x} = 0$)는 $y=y^{\prime}$로 간소화되며, epipolar line은 일치한다.)
 
![image](https://user-images.githubusercontent.com/60316325/232985610-b6be380d-bd5b-4b54-9e2c-6861f526e52a.png)

## 4. Essential Matrix

- The **essential matrix** is t he specialization of the fundamental matrix to the case of normalized image coordimates.
- fundamental matrix may be thought of as the generalization of the essential matrix in which the assumption of calibrated cameras is removed.
- The essential matrix has fewer degrees of freedom, and additional properties compared to the F matrix.

### Definition

- Consider a camera matrix decomposed as $P=K[R |t]$ and let $\mathbf{x} = P\mathbf{X}$ be a point in the image
- If the calibration matrix $K$ is known, then we may apply its inverse to the point $\mathbf{x}$ to obtain the point $\hat{\mathbf{x}} = K^{-1}\mathbf{x}$.<br>
  ($\hat{\mathbf{x}}$ = image point expressed in normalized coordinates)
- Then $\hat{\mathbf{x}} = K^{-1}K[R|\mathbf{t}]\mathbf{X} = [R|\mathbf{t}]\mathbf{X}$.
- It may be thought of as the image of point $\mathbf{X}$ with respect to a camera $[R|\mathbf{t}]$ having the identity matrix $I$ as calibration matrix.
- The camera matrix $K^{-1}P = [R|\mathbf{t}]$ is called a **normalized camera matrix**, the effect of the known calibration matrix having been removed. <br>
 (쉽게 말해, 카메라의 내부 파라미터(intrinsic) 영향을 제거한 행렬 이라고 볼 수 있다.)
 
- Now consider a pair of normalized camera matrices.

$$P = [I|\mathbf{0}], \qquad P^{\prime} = [R|\mathbf{t}]$$

- The Fundamental matrix corresponding to the pair of normalized cameras is called the **"Essential Matrix"**. <br>
 (즉, 이러한 normalized camera에 대응되는 F matrix를 Essential Matrix 라고 한다.)
- The essential matrix has the form of..

$$E = [\mathbf{t}]_{\times}R = R[R^T\mathbf{t}]_{\times}$$

$$F = K^{\prime \ -T}[\mathbf{t}]_{\times}RK^{-1} = K^{\prime \ -T}R[R^T\mathbf{t}]_{\times}K^{-1}$$

- The defining equation for the essential matrix is.. (in terms of the normalized image coordinates for corresponding points $\mathbf{x} \leftrightarrow \mathbf{x}^{\prime}$)
- If we compare to $E$ and $F$, we can find that the $E$ matrix can be calculated from the $F$ matrix and the known calibration matrix as..

$$\hat{\mathbf{x}}^{\prime \ T}E\hat{\mathbf{x}} = 0$$

$$\mathbf{x}^{\prime \ T}F\mathbf{x} = \mathbf{x}^{\prime \ T}K^{\prime \ -T}EK^{-1}\mathbf{x} = 0$$

$$E = K^{\prime \ T}FK.$$

### Properties of Esseintial Matrix

* A 3x3 matrix is an essential matrix if and only if two of ites singular values are equal, and third is zero.
* Suppose that the SVD of E is $U$ diag(1,1,0) $V^T$.

$$U\begin{bmatrix}
1&0&0\\
0&1&0\\
0&0&0\end{bmatrix}V^T$$

* There are two possible factorizations $E=[\mathbf{t}]_{\times}R = SR$ as follows :
  * $S$ is a skew-symmetric matrix.
  * $R$ is an orthogonal matrix.
  
$$S = UZU^T, \quad R = UWV^T \ or \ UW^TV^T$$

$$W = \begin{bmatrix}
0&-1&0\\
1&0&0\\
0&0&1\end{bmatrix}, \qquad Z = \begin{bmatrix}
0&1&0\\
-1&0&0\\
0&0&0\end{bmatrix}$$

* Since $S\mathbf{t} = 0$ and $S = [\mathbf{t}]_{\times}$, it follows that $\mathbf{t} = U(0,0,1)^T = \mathbf(u)_3$, the last column of $U$.
* Note that $\mathbf{t}$ is determined up to scale and the sign of $\mathbf{t}$ cannot be determined.
* Thus, if $P = [I|\mathbf{0}]$, there are four possible choices of $P^{\prime}$ based on the two possible choices of $R$ and two possible signs of $\mathbf{t}$.

$$P^{\prime} = [UWV^T | +\mathbf{u}_3] \ or [UWV^T | -\mathbf{u}_3] \ or [UW^TV^T | +\mathbf{u}_3] \ or [UW^TV^T | -\mathbf{u}_3]$$

![image](https://user-images.githubusercontent.com/60316325/232998535-8b25f5de-f51e-448f-91e8-c8838a6eef30.png)

* The four solutions are shown below.
* Reconstructed point $\mathbf{X}$ will be in front of both cameras in one of these four solutions only. <br>
 (재구성된 점 X를 찾아내는 것은, 이 4가지 상황 중에서 하나만 가능하다.)
* So, testing with a single point to determine if it is in front of both camera is sufficient to decide between the four different solutions for the camera matrix $P^{\prime}$. <br>
 (하나의 점을 통해 두 카메라의 앞에 점이 있는지 결정하는것은 카메라 Matrix $P^{\prime}$에 대한 4가지 상황 중에 결정할 수 있으므로 충분하다.)
