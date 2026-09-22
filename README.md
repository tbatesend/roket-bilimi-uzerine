# Roket Bilimi Hakkında

Roket bilimini öğrenirken yazdığım MATLAB hesapları ve simülasyonları. Her kaynak kendi klasöründe,
her bölüm kendi alt klasöründe. Her konu; kullanılan denklemleri, varsayımları, sonuçları ve
**sonuçların nasıl doğrulandığını** içerir. Kaynaklardan alıntı yapılmamıştır; açıklamalar ve türetmeler bana aittir.

> **English summary:** Rocket science fundamentals worked through in MATLAB, organized by source
> and chapter — solid motor modelling, thrust and impulse, and a 1-DOF vertical flight simulation
> with drag and gravity losses. Each topic documents its equations, assumptions, results and
> verification checks. Content is in Turkish; code comments are ASCII-only for compatibility.

## İçindekiler

| Kaynak | Bölüm | Konu | Durum |
|---|---|---|---|
| Roketsan, *Temel Roketçilik Eğitimi* | [Bölüm 1](roketsan-el-kitapcigi/bolum-1/) | Tsiolkovsky denklemi, katı yakıtlı motor modeli, itki ve darbe, dikey uçuş simülasyonu | ✅ |
| | Bölüm 2 | — | Planlanıyor |

## Nasıl çalıştırılır?

1. Depoyu indir ya da klonla.
2. MATLAB'da ilgili bölüm klasörünü aç (örn. `roketsan-el-kitapcigi/bolum-1/`).
3. Tüm girdiler o klasördeki `parametreler.m` içinde. Scriptleri istediğin sırayla çalıştırabilirsin.

## Uyarı

Buradaki değerler öğrenme amaçlı varsayımlardır ve gerçek bir rokete ait değildir.
Modeller basitleştirilmiştir; sınırlamalar her bölümün README dosyasında belirtilmiştir.
