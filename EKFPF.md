$$
\begin{aligned} \theta'_t &= \theta_{t-1}+\delta \theta_{t1} \\
\hat x_t &= x_{t-1}+\delta d_t\cos(\theta'_t) \\
\hat y_t &= y_{t-1}+\delta d_t\sin(\theta'_t)  \\
\hat\theta_t &= \theta_t' +\delta \theta_{t2} 
\end{aligned}
$$

$$
\begin{aligned}G_t &= \begin{bmatrix} 
 \frac{\part x_t}{\part x_{t-1}} & \frac{\part x_t}{\part y_{t-1}} &\frac{\part x_t}{\part \theta_{t-1}} \\
\frac{\part y_t}{\part x_{t-1}}&\frac{\part y_t}{\part y_{t-1}} &\frac{\part y_t}{\part \theta_{t-1}} \\
\frac{\part \theta_t}{\part x_{t-1}} &\frac{\part \theta_t}{\part y_{t-1}} & \frac{\part \theta_t}{\part \theta_{t-1}}
\end{bmatrix} \\ 
&=\begin{bmatrix} 
1&0&-\delta d \sin(\theta_{t-1}+\delta \theta_{t1}) \\
0&1& \cos(\theta_{t-1}+\delta \theta_{t1}) \\
0&0&1
\end{bmatrix}
\end{aligned}
$$

$$
\begin{aligned}V_t &= \begin{bmatrix} 
 \frac{\part x_t}{\part \delta\theta_{t1}} & \frac{\part x_t}{\part\delta d_{t}} &\frac{\part x_t}{\part \delta \theta_{t2}} \\
 \frac{\part y_t}{\part \delta\theta_{t1}} & \frac{\part y_t}{\part\delta d_{t}} &\frac{\part y_t}{\part \delta \theta_{t2}}\\
 \frac{\part \theta_t}{\part \delta\theta_{t1}} & \frac{\part \theta_t}{\part\delta d_{t}} &\frac{\part \theta_t}{\part \delta \theta_{t2}}
\end{bmatrix} \\
&=\begin{bmatrix}
-\delta d_t\sin( \theta_{t-1}+\delta \theta_{t1} )&\cos( \theta_{t-1}+\delta \theta_{t1} )& 0\\
\delta d_t \cos( \theta_{t-1}+\delta \theta_{t1} ) &\sin( \theta_{t-1}+\delta \theta_{t1} )&0 \\
1&0&1
\end{bmatrix}
\end{aligned}
$$

$$
M_t = \begin{bmatrix} 
Var_1&0&0 \\
0&Var_2&0 \\
0&0& Var_3
\end{bmatrix}
$$

$$
{\overline \Sigma}_t = G_t \Sigma_{t-1}G^T_t + V_tM_tV_t^T
$$

$$
\hat Z = \arctan(\frac {y_{marker}-\hat y_t}{x_{marker}-\hat x_t})-\hat \theta_t
$$

$$
\begin{aligned} H_t &= \begin{bmatrix}
\frac{\part z}{\part \hat x_t}&\frac{\part z}{\part \hat y_t}&\frac{\part z}{\part \hat \theta_t}
\end{bmatrix} \\
&= 
\begin{bmatrix}
 \frac{y_{marker}-\hat y_t}{ ({y_{marker}-\hat y_t})^2+ ({x_{marker}-\hat x_t})^2} & -\frac{y_{marker}-\hat y_t}{ ({y_{marker}-\hat y_t})^2+ ({x_{marker}-\hat x_t})^2}& -1
\end{bmatrix}
\end{aligned}
$$

$$
S_t = H_t\overline \Sigma_tH_t^T+Q
$$



