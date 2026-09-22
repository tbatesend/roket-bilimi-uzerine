%% DIKEY UCUS SIMULASYONU (1 serbestlik derecesi, Euler yontemi)
% Hareket denklemi (Newton'un 2. yasasi):
%   m(t)*dv/dt = T(t) - D - m(t)*g0
%   D = 0.5*C_D*rho_air*A_ref*v*|v|   (v*|v| -> surukleme hep harekete ters)
%
% Kaynak: Roketsan, Temel Roketcilik Egitimi, Bolum 1 (1.4, 1.5)
%
% Varsayimlar:
%   - Tamamen dikey ucus, tasima yok (hucum acisi ~0, Bolum 1.5.6)
%   - C_D, hava yogunlugu ve yercekimi sabit
%   - Parasut yok

clear; clc; close all;
p = parametreler();
m = motor_model(p);

%% Simulasyon
dt    = 0.01;                   % [s]
t_max = 150;                    % [s] ust sinir; roket yere dusunce durur
t_sim = 0:dt:t_max;
N     = length(t_sim);

v     = zeros(1,N);             % [m/s]   roketin havaya gore hizi (v_e degil!)
h     = zeros(1,N);             % [m]     irtifa
dv_dt = zeros(1,N);             % [m/s^2] ivme

for k = 1:N-1
    % Motor verisini bu ana aktar (yanma bitince itki 0, kutle m_dry)
    T_k = interp1(m.time, m.T,       t_sim(k), 'linear', 0);
    m_k = interp1(m.time, m.m_total, t_sim(k), 'linear', p.m_dry);

    D_k = 0.5*p.C_D*p.rho_air*p.A_ref*v(k)*abs(v(k));

    dv_dt(k) = (T_k - D_k - m_k*p.g0)/m_k;
    v(k+1)   = v(k) + dv_dt(k)*dt;
    h(k+1)   = h(k) + v(k)*dt;

    if h(k+1) < 0               % yere dustu: dur ve dizileri kirp
        n_end = k+1;
        t_sim = t_sim(1:n_end);  v = v(1:n_end);
        h     = h(1:n_end);      dv_dt = dv_dt(1:n_end);
        break;
    end
end

%% Sonuclar
[h_max, i_max] = max(h);
v_bo = interp1(t_sim, v, m.t_b);           % [m/s] yanma bitisi hizi
h_bo = interp1(t_sim, h, m.t_b);           % [m]   yanma bitisi irtifasi

fprintf('--- UCUS ---\n');
fprintf('Ilk adim ivmesi     : %.2f m/s^2\n', dv_dt(1));
fprintf('Yanma bitisi hizi   : %.1f m/s  (irtifa %.0f m, Mach ~%.2f)\n', ...
        v_bo, h_bo, v_bo/340);
fprintf('Maksimum irtifa     : %.0f m  (t = %.1f s)\n', h_max, t_sim(i_max));
fprintf('Yere dusus          : t = %.1f s, hiz = %.1f m/s\n', t_sim(end), v(end));

%% Ideal Delta-v ile karsilastirma
% Denklemi m'ye bolup 0..t_b arasinda entegre edince:
%   v_bo = v_e*ln(m0/mf) - integral(D/m) - g0*t_b
%        = ideal Delta-v - surukleme kaybi - yercekimi kaybi
dv_ideal  = p.v_e*log((p.m_dry + m.m_prop0)/p.m_dry);
loss_grav = p.g0*m.t_b;                     % dikey ucusta tam deger
loss_drag = dv_ideal - v_bo - loss_grav;    % geriye kalan

fprintf('\n--- KAYIPLAR ---\n');
fprintf('Ideal Delta-v       : %.1f m/s\n', dv_ideal);
fprintf('Gercek (simulasyon) : %.1f m/s\n', v_bo);
fprintf('Yercekimi kaybi     : %.1f m/s\n', loss_grav);
fprintf('Surukleme kaybi     : %.1f m/s\n', loss_drag);

%% Grafikler
figure;
subplot(3,1,1);
plot(t_sim, h, 'LineWidth', 1.5); hold on;
plot(t_sim(i_max), h_max, 'ro');
xline(m.t_b, '--', 'Yanma bitti');
ylabel('Irtifa (m)'); title('Dikey ucus simulasyonu'); grid on;

subplot(3,1,2);
plot(t_sim, v, 'LineWidth', 1.5); xline(m.t_b, '--');
ylabel('Hiz (m/s)'); grid on;

subplot(3,1,3);
plot(t_sim, dv_dt, 'LineWidth', 1.5); xline(m.t_b, '--');
ylabel('Ivme (m/s^2)'); xlabel('Zaman (s)'); grid on;
