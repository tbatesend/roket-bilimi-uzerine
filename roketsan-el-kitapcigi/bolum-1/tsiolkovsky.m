%% TSIOLKOVSKY ROKET DENKLEMI: Delta-v ve kutle orani iliskisi
% Delta_v = v_e * ln(m_0 / m_f)
% Kaynak: Roketsan, Temel Roketcilik Egitimi, Bolum 1
%
% Soru: Ayni motorla (v_e sabit) daha fazla yakit tasirsak ne kazaniriz?

clear; clc; close all;
p = parametreler();

mass_ratio = linspace(1, 10, 200);          % [-]   m_0/m_f
dv = p.v_e*log(mass_ratio);                 % [m/s] ideal hiz degisimi

% Her ikiye katlama ayni Delta-v'yi kazandirir: v_e*ln(2)
fprintf('Oran 2 -> 4  : +%.0f m/s\n', p.v_e*log(4/2));
fprintf('Oran 5 -> 10 : +%.0f m/s (ayni kazanc, cok daha fazla yakit)\n', p.v_e*log(10/5));

% Yakit orani: roketin yuzde kaci yakit?
fuel_fraction = 1 - 1./mass_ratio;
fprintf('Oran 10 -> roketin %%%.0f''i yakit\n', 100*fuel_fraction(end));

figure;
plot(mass_ratio, dv, 'LineWidth', 1.5);
xlabel('Kutle orani m_0/m_f (-)');
ylabel('\Delta v (m/s)');
title(sprintf('Ideal \\Delta v - kutle orani (v_e = %d m/s)', p.v_e));
grid on;
