function m = motor_model(p)
% MOTOR_MODEL  Silindirik delikli kati yakitli motorun zamana bagli modeli.
%   m = motor_model(p) -> p: parametreler() ciktisi
%
%   Cikti (struct m):
%     m.t_b      [s]     yanma suresi
%     m.time     [s]     zaman vektoru (0..t_b)
%     m.A_b      [m^2]   yanan yuzey alani
%     m.m_dot    [kg/s]  kutle debisi
%     m.T        [N]     itki
%     m.m_prop0  [kg]    baslangic yakit kutlesi
%     m.m_total  [kg]    anlik toplam roket kutlesi
%
%   Varsayimlar:
%     - Sadece delik ic yuzeyi yaniyor (uclar yanmiyor)
%     - Yanma hizi sabit (gercekte yanma odasi basincina bagli)
%     - Efektif egzoz hizi sabit, p2 = p3 (basinc itkisi yok)

m.t_b   = (p.R - p.r_0)/p.r_dot;
m.time  = linspace(0, m.t_b, 1000);

r_t     = p.r_0 + p.r_dot*m.time;        % [m] anlik delik yaricapi
m.A_b   = 2*pi*r_t*p.L;
m.m_dot = p.rho_p*m.A_b*p.r_dot;
m.T     = m.m_dot*p.v_e;

m.m_prop0  = trapz(m.time, m.m_dot);
m_burned   = cumtrapz(m.time, m.m_dot);  % [kg] her ana kadar yanan yakit
m.m_total  = p.m_dry + m.m_prop0 - m_burned;
end
