function p = parametreler()
% PARAMETRELER  Bolum 1 hesaplarinda kullanilan tum girdi degerleri.
%   p = parametreler() tum parametreleri tek bir struct icinde dondurur.
%   Tum scriptler bu dosyayi kullanir; bir degeri degistirmek icin
%   sadece burayi duzenlemek yeterlidir.
%
%   Not: Degerler ogrenme amacli varsayimlardir, gercek bir rokete ait degildir.

% --- Yakit geometrisi (silindirik delikli) ---
p.R      = 0.05;        % [m]      yakitin dis yaricapi
p.r_0    = 0.015;       % [m]      baslangic delik yaricapi
p.L      = 0.3;         % [m]      yakit uzunlugu

% --- Motor ---
p.rho_p  = 1750;        % [kg/m^3] yakit yogunlugu (tipik kompozit tahmini)
p.r_dot  = 0.005;       % [m/s]    yanma hizi (sabit kabul)
p.v_e    = 2000;        % [m/s]    efektif egzoz hizi (sabit kabul)

% --- Roket govdesi ---
p.m_dry  = 15;          % [kg]     yakitsiz roket kutlesi
p.d_body = 0.12;        % [m]      govde capi
p.A_ref  = pi*p.d_body^2/4;   % [m^2] referans alan
p.C_D    = 0.5;         % [-]      surukleme katsayisi (sabit kabul)

% --- Ortam ---
p.rho_air = 1.225;      % [kg/m^3] hava yogunlugu (deniz seviyesi, sabit kabul)
p.g0      = 9.81;       % [m/s^2]  yercekimi ivmesi
end
