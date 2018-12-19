function [mu, sigma, predMu, predSigma, zHat, pOfZ, G, V, H, K] = ...
  	ekfUpdate( mu, sigma, ...
			   u, filterAlphas, ...
			   z, filterBeta, ...
			   markerId, FIELDINFO)
% EKF Update step
%
% INPUT:
%  mu           - state mean at time t-1
%  sigma        - state covariance at time t-1
%  u            - control at time t
%  filterAlphas - motion model noise
%  z            - observation at time t
%  filterBeta   - observation noise variance
%  markerId     - ID of the marker we see at time t (get observation from)
%  FIELDINFO    - Field details for observation function
%
% OUTPUTS:
%  mu           - state mean at time t
%  sigma        - state covar at time t 
%  predMu       - state mean from EKF prediction step
%  predSigma    - state covar from EKF prediction step
%  zHat         - expected observation
%  pOfZ         - observation likelihood
%  G            - Jacobian of dynamics w.r.t state_t-1
%  V            - Jacobian of dynamics w.r.t control_t
%  H            - Observation jacobian
%  K            - Kalman gain

% TODO: Remove this line
% [predMu, predSigma, zHat, pOfZ, G, V, H, K] = deal([]);

% You should almost certainly leave the header the way it is.

% Init vars
Delta_rot1 = u(1);
Delta_trans = u(2);
Delta_rot2 = u(3);
Pos_prev_x = mu(1);
Pos_prev_y = mu(2);
Pos_prev_theta = mu(3);

Delta_theta_temp = Pos_prev_theta+Delta_rot1;
% --------------------------------------------
% Prediction step
% --------------------------------------------
predMu = prediction(mu, u);
% some stuff here
% x = x + delta*cos; y = y + delta*sin; theta = theta + delta;
G = [1, 0, -Delta_trans*sin(Delta_theta_temp); ...
    0, 1, Delta_trans*cos(Delta_theta_temp);...
    0,   0,   1];
V = [-Delta_trans*sin(Delta_theta_temp),cos(Delta_theta_temp),0; ...
    Delta_trans*cos(Delta_theta_temp),sin(Delta_theta_temp),0; ...
    1,    0,    1];
% 控制变量协方差
Cov_M = eye(3,3);
variances = noiseFromMotion(u, filterAlphas);
Cov_M(1,1) = variances(1);
Cov_M(2,2) = variances(2);
Cov_M(3,3) = variances(3);
predSigma = G*sigma*G' + V*Cov_M*V';

%--------------------------------------------------------------
% Correction step
%--------------------------------------------------------------

% Compute expected observation and Jacobian
% 方向与ID
zHat = observation(predMu, FIELDINFO, markerId);
dx = FIELDINFO.MARKER_X_POS( int32(markerId)) - predMu(1);
dy = FIELDINFO.MARKER_Y_POS( int32(markerId)) - predMu(2);
dist_2 = dx^2 + dy^2;
H1 = dy/dist_2;
H2 = -dx/dist_2;
% H = [H1,H2, -1; 0 , 0, 0];
H = [H1,H2, -1];
% Innovation / residual covariance

% Q = eye(2,2);
% Q(1,1) = filterBeta;  %角度方差
% Q(2,2) = 0;   % ID方差
Q = filterBeta;
S = H*predSigma*H' + Q;
% Residual
res = z(1) - zHat(1);
res = minimizedAngle(res);
% Likelihood
pOfZ = likelihood(S,res);
% Kalman gain
K = predSigma*H'*pinv(S);
% Correction
mu = predMu + K*res;
mu(3) = minimizedAngle(mu(3));
sigma = (eye(3,3) - K*H)*predSigma;






   
