%% MOTOR ANALIZI: itki, toplam darbe, ozgul darbe
% Kaynak: Roketsan, Temel Roketcilik Egitimi, Bolum 1 (1.2, 1.3)

clear; clc; close all;
p = parametreler();
m = motor_model(p);

%% Sonuclar ve dogrulama
I_total = trapz(m.time, m.T);                   % [N*s] toplam darbe
m_p_geo = p.rho_p*pi*(p.R^2 - p.r_0^2)*p.L;     % [kg]  yakit (geometriden)
I_sp    = I_total/(m.m_prop0*p.g0);             % [s]   ozgul darbe

fprintf('Yanma suresi        : %.2f s\n', m.t_b);
fprintf('Toplam darbe        : %.1f N*s (M sinifi: 5120-10240)\n', I_total);
fprintf('Yakit (integral)    : %.4f kg\n', m.m_prop0);
fprintf('Yakit (geometri)    : %.4f kg  -> ikisi ayni olmali\n', m_p_geo);
fprintf('Ozgul darbe         : %.1f s  (= v_e/g0 olmali: %.1f s)\n', I_sp, p.v_e/p.g0);
fprintf('Itki/agirlik (t=0)  : %.2f  -> 1''den buyuk olmali\n', ...
        m.T(1)/(m.m_total(1)*p.g0));

%% Grafik
figure;
yyaxis left;  plot(m.time, m.A_b, 'LineWidth', 1.5); ylabel('Yanan yuzey alani (m^2)');
yyaxis right; plot(m.time, m.T,   'LineWidth', 1.5); ylabel('Itki (N)');
xlabel('Zaman (s)'); title('Silindirik delikli yakit: alan ve itki'); grid on;
