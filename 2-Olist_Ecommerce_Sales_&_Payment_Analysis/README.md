# Olist E-Commerce End-to-End Project: From Descriptive Analytics to Machine Learning Segmentation

## Project Overview
Proyek ini merupakan proyek hibrida komprehensif yang menggabungkan kekuatan **Data Analytics** dan **Data Science**. Proyek diawali dengan analisis deskriptif menggunakan SQL untuk memetakan performa bisnis makro dan visualisasi dashboard. Selanjutnya, proyek ditingkatkan ke ranah Data Science dengan membangun sistem **Customer Segmentation** otomatis menggunakan Machine Learning berbasis perilaku transaksi pelanggan secara individu.

---

## Phase 1: Descriptive Analytics & Business Dashboard (Data Analyst Role)
Pada fase awal, fokus utama adalah memahami kesehatan bisnis, kontribusi wilayah, serta perilaku pembayaran menggunakan ekstraksi data via **SQL** (`queries.sql`).

### Key Insights dari Dashboard:
* **Revenue Dominance by State:** Negara bagian **SP (São Paulo)** menjadi episentrum bisnis dengan menyumbang pendapatan tertinggi menembus **5.2 Juta BRL**, jauh melampaui RJ dan MG.
* **Top Product Categories:** Kategori **Health & Beauty** serta **Watches & Gifts** memimpin sebagai kontributor pendapatan terbesar (masing-masing > 1.1 Juta BRL).
* **Payment Behavior:** Metode **Credit Card** adalah pilihan utama yang mendominasi volume transaksi secara masif (**76,505 pesanan**), sekaligus menghasilkan rata-rata nilai transaksi tertinggi (**163 BRL**). Kebalikannya, *Voucher* memiliki nilai rata-rata transaksi terendah (66 BRL).

> *Hasil visualisasi dashboard makro ini dapat dilihat pada file `dashboard_olist.png`.*

---

## Phase 2: Predictive & Advanced Customer Segmentation (Data Science Upgrade)
Untuk memaksimalkan profitabilitas, strategi pemasaran massal harus diubah menjadi strategi berbasis personalisasi. Pada fase ini, Jupyter Notebook (`olist_customer_segmentation.ipynb`) dibuat untuk mengelompokkan pelanggan secara otomatis menggunakan algoritma **Unsupervised Learning**.

### Data Science Workflow & Tech Stack
* **Feature Engineering (RFM Metrics):** Mentransformasi data transaksi mentah menjadi metrik individu pelanggan:
  * *Recency (R):* Jumlah hari sejak transaksi terakhir.
  * *Frequency (F):* Total frekuensi pembelian unik pelanggan.
  * *Monetary (M):* Total uang yang dihabiskan pelanggan.
* **Data Preprocessing:** Penerapan transformasi logaritma (`np.log1p`) untuk menangani keragaman data (*skewness*) e-commerce dan penskalaan fitur menggunakan `StandardScaler`.
* **Model Optimization (Elbow Method):** Mengevaluasi nilai *Inertia* untuk menentukan jumlah kluster paling optimal. Berdasarkan grafik tekukan sikut, dipilih **k = 3** (atau k = 4) sebagai jumlah kelompok yang efisien secara matematis dan operasional bisnis.
* **Algorithms & Libraries:** `scikit-learn` (KMeans), `pandas`, `numpy`, `matplotlib`, dan `seaborn`.

### Strategic Business Recommendations (Actionable Insights)
Berdasarkan hasil klusterisasi K-Means, pelanggan terbagi menjadi kelompok strategis berikut:
1. **Cluster - Champions/VIP:** Pelanggan dengan skor Recency rendah (baru membeli) serta Frequency & Monetary tinggi. 
   * *Aksi Bisnis:* Berikan program loyalitas eksklusif, prioritas layanan pelanggan, dan akses awal untuk produk baru di kategori utama (Health & Beauty).
2. **Cluster - At Risk / Need Attention:** Pelanggan yang memiliki nilai Monetary besar di masa lalu, namun sudah lama tidak melakukan transaksi (Recency tinggi).
   * *Aksi Bisnis:* Lancarkan kampanye *win-back* tertarget dengan menawarkan promo cicilan khusus menggunakan *Credit Card* (memanfaatkan fakta metode bayar paling populer dari hasil Fase 1).
3. **Cluster - New/Occasional Customers:** Pelanggan dengan frekuensi dan nominal transaksi kecil.
   * *Aksi Bisnis:* Gunakan strategi *cross-selling* dengan merekomendasikan produk pelengkap murah saat *checkout* untuk mendongkrak nilai *Monetary* mereka.

---

## How to Run
1. Pastikan Anda telah memasang dependensi yang diperlukan:
   ```bash
   pip install -r requirements.txt
   ```
2. Jalankan query SQL di platform database Anda atau buka Jupyter Notebook untuk melihat proses pemodelan Machine Learning:
   ```bash
   jupyter notebook olist_customer_segmentation.ipynb
   ```
