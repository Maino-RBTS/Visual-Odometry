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

#### Basic properties

* So $\mathbf{x}^{\prime}$ lies on $\mathbf{l}^{\prime}$, we can write $\mathbf{x}^{\prime \ T}\mathbf{l}^{\prime} = 0$.

$$\mathbf{x}^{\prime \ T}\mathbf{l}^{\prime} = \mathbf{x}^{\prime \ T}F\mathbf{x} = 0$$

* $\mathbf{x}^{\prime \ T}F\mathbf{x} = 0$ is important. <br>
  Because This enables F to be computed from image **correspondences alone** without reference to the camera matrices.
* In other words. We have seen that F may be computed from the two camera matrices. $F = [\mathbf{e}^{\prime}]\_{\times}P^{\prime}P^+$, <br>
  But now, we may enquire how many correspondences are required to compute F from $\mathbf{x}^{\prime \ T}F\mathbf{x} = 0$ ?? <br>
  and the circumstances under which the matrix is uniquely defined by these correspondences.<br> 
 (한마디로, F를 계산하기 위해 얼마나 많은 대응점들이 필요한지, 그리고 이러한 대응점들의 Matrix를 유일하게 정의할 수 있는 상황이 중요하다.)
 
 


