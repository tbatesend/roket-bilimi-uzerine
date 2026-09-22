# Bölüm 1 — Roket 101

Kaynak: Roketsan, *Temel Roketçilik Eğitimi*, Bölüm 1.

## Dosyalar

| Dosya | Tür | Ne yapar? |
|---|---|---|
| `parametreler.m` | fonksiyon | Tüm girdi değerleri (geometri, motor, gövde, ortam). Değerler tek yerde. |
| `motor_model.m` | fonksiyon | Silindirik delikli katı yakıtlı motorun zamana bağlı modeli |
| `tsiolkovsky.m` | script | İdeal Δv – kütle oranı ilişkisi |
| `motor_analizi.m` | script | İtki, toplam darbe, özgül darbe ve doğrulamalar |
| `dikey_ucus.m` | script | 1 serbestlik dereceli dikey uçuş simülasyonu ve kayıp analizi |

## 1. Tsiolkovsky denklemi

$$\Delta v = v_e \ln\frac{m_0}{m_f}$$

Kütle oranını her ikiye katlamak aynı Δv'yi kazandırır ($v_e \ln 2 \approx 1386$ m/s).
Ancak eklenmesi gereken yakıt katlanarak artar: oran 10, roketin %90'ının yakıt olması demektir.
Kademeli roketlerin var olma sebebi budur.

bakınız https://www1.grc.nasa.gov/beginners-guide-to-aeronautics/ideal-rocket-equation/

## 2. Katı yakıtlı motor modeli

Yakıt, ortasında delik olan bir silindir. Sadece iç yüzey yanar ve yanma dışa doğru ilerler.

$$A_b(t) = 2\pi\,(r_0 + \dot r\,t)\,L \qquad \dot m = \rho_p A_b \dot r \qquad T = \dot m\, v_e$$

Delik genişledikçe yanan alan, dolayısıyla itki artar (495 N → 1649 N).

## 3. Dikey uçuş simülasyonu

$$m(t)\,\frac{dv}{dt} = T(t) - \tfrac12 C_D \rho A\, v|v| - m(t)\,g$$

Euler yöntemiyle çözülür. Sürüklemede $v|v|$ kullanılır; böylece sürükleme roket düşerken de harekete ters yönde kalır.

Denklem $m$'ye bölünüp yanma süresi boyunca entegre edilirse kayıplar ayrıştırılabilir:

$$v_{bo} = \underbrace{v_e \ln\frac{m_0}{m_f}}_{\text{ideal }\Delta v} - \underbrace{\int_0^{t_b}\frac{D}{m}\,dt}_{\text{sürükleme kaybı}} - \underbrace{g\,t_b}_{\text{yerçekimi kaybı}}$$

## Sonuçlar

| Büyüklük | Değer |
|---|---|
| Yanma süresi | 7,0 s |
| Toplam darbe | 7504,5 N·s (M sınıfı) |
| Özgül darbe | 203,9 s |
| Yanma bitişi hızı | 335,8 m/s (Mach ≈ 0,99) |
| Maksimum irtifa | ≈ 3746 m (t ≈ 28,5 s) |
| İdeal Δv | 446,5 m/s |
| Yerçekimi kaybı | 68,7 m/s |
| Sürükleme kaybı | 42,1 m/s |

## Doğrulama

- **Yakıt kütlesi iki yoldan:** $\int \dot m\,dt$ ile geometriden hesaplanan $\rho_p \pi (R^2 - r_0^2) L$ aynı çıkıyor (3,7522 kg).
- **Özgül darbe iki yoldan:** $I_t / (m_p g_0)$ ile $v_e/g_0$ aynı çıkıyor (203,9 s).
- **İlk adım kontrolü:** $t=0$'da ivme elle hesaplanan $T/m - g \approx 16{,}6$ m/s² ile uyuşuyor.
- **Bağımsız çözüm:** Aynı model Python'da ayrıca çözüldü, sonuçlar birebir tuttu.

## Sınırlamalar ve olası iyileştirmeler

- **Sabit $C_D$:** Yanma bitişinde Mach ≈ 0,99, yani transonik bölgedeyiz. Burada $C_D$ belirgin şekilde artar; gerçek irtifa muhtemelen daha düşüktür. → Mach'a bağlı $C_D$ eklenebilir.
- **Sabit hava yoğunluğu:** 3,7 km'de hava daha incedir; bu hata ters yönde etki eder. → Standart atmosfer modeli eklenebilir.
- **Paraşüt yok:** Roket ≈ 187 m/s ile yere çarpıyor (limit hız ≈ 206 m/s). → Tepe noktasında paraşüt açılması modellenebilir.
- **Sabit yanma hızı ve egzoz hızı:** Gerçekte ikisi de yanma odası basıncına bağlıdır.
