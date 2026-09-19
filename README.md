# Portfolio Data Analyst

> Calon data Scientist yang sedang membangun portfolio dari nol - mendokumentasikan tantangan nyata, proses berpikir analitis, dan insight bisnis dari setiap proyek.

[Portfolio](https://bit.ly/PortfolioDataAnalyst_Fadlan) · [LinkedIn](https://www.linkedin.com/in/fadlanfdilah) · [Email](mailto:fadlanfadilah250@gmail.com)

---

## Tentang Saya

Saya adalah mahasiswa jurusan S1 Informatika di Universitas Pembangunan Nasional "Veteran" Jakarta, dengan ketertarikan kuat di bidang Data Scientist dan Data Analyst. Repository ini mendokumentasikan perjalanan belajar saya, mulai dari data cleaning dan exploratory analysis, hingga desain dashboard dan business insight.

---

## Skill

| Kategori | Tools & Teknik |
|---|---|
| **Pemrograman** | Python (Pandas, Plotly, Matplotlib, Seaborn) |
| **Spreadsheet** | Microsoft Excel, Power Query, Pivot Table, Dashboard Design |
| **Database** | MySQL, PostgreSQL, DBeaver |
| **Visualisasi & Web App** | Tableau, Excel Charts, Streamlit Community Cloud |
| **Statistik** | Statistik Deskriptif, Korelasi *(sedang dipelajari)* |
| **Lainnya** | Data Cleaning, Business Acumen, Storytelling with Data |

---

## Proyek

### 1. Superstore Sales Performance Analysis
**Excel · Power Query · Pivot Table · Dashboard**

> Analisis 9.994 transaksi retail untuk mengungkap kerugian profit tersembunyi dan dampak diskon berlebihan terhadap margin bisnis.

**Temuan utama:**
- Sub-category Tables menghasilkan revenue $206K namun mencatatkan **net loss -$17K** (margin -8,6%)
- Copiers memberikan profit margin tertinggi (~37%) meski hanya berada di posisi ke-8 dari sisi revenue
- Revenue secara konsisten memuncak di Q4, menyumbang ~35% dari total penjualan tahunan

---

### 2. Olist E-Commerce Sales & Payment Analysis
**PostgreSQL · DBeaver · Tableau Public · Dashboard**

> Analisis komprehensif terhadap 99.442 transaksi pada sebuah e-commerce yang bertujuan untuk mengetahui wilayah dan kategori yang menjadi sumber pendapatan tertinggi, serta metode pembayaran apa yang palind dominan digunakan.

**Temuan utama:**
- São Paulo (SP) mendominasi revenue dengan BRL 5,2 juta, hampir 3x lipat state kedua (RJ: BRL 1,8 juta)
- Health Beauty memimpin revenue kategori (BRL 1,2 juta), diikuti Watches Gifts dan Bed Bath Table, ketiganya menyumbang lebih dari 40% total revenue top 10 kategori.
- Credit Card adalah metode pembayaran dominan (76.505 order, ~75% dari total) dengan rata-rata nilai transaksi tertinggi (BRL 163) dan rata-rata 3,5 kali cicilan
---

### 3. E-Commerce Public Dataset - Data Analytics Dashboard
**Python · Pandas · Plotly · Streamlit**

> Pengembangan web *dashboard* interaktif untuk menganalisis tren pendapatan bulanan dari kategori produk terlaris dan distribusi geografis pesanan pelanggan pada e-commerce Olist. Diselesaikan sebagai submission program Asah Dicoding 2026.

**Temuan utama & Fitur:**
- Mengonfirmasi dominasi negara bagian São Paulo (SP) sebagai penyumbang volume pesanan terbanyak secara nasional.
- *Dashboard* dilengkapi *sidebar widget* dinamis yang memungkinkan pengguna memfilter data berdasarkan tahun transaksi, rentang bulan, dan menyesuaikan jumlah *top* kategori produk (hingga 15 kategori).
- Mengintegrasikan Plotly untuk menyajikan *line chart* dan *bar chart* yang sepenuhnya interaktif (*hover, zoom, pan*).

**[🌐 Lihat Dashboard Interaktif](https://ecommerce-data-dashboard.streamlit.app/)**
---

## Struktur Repository

```
data-analyst-portfolio/
│
├── 1-Superstore_Sales_Performance_Analysis/
│   ├── SalesPortfolio_Fadlan.xlsx    # File Excel utama
│   ├── dashboard_superstore.png      # Tampilan dashboard lengkap
│   └── README.md                     # Dokumentasi proyek
│
├── 2-Olist_Ecommerce_Sales_&_Payment_Analysis
│   ├── queries.sql                   # File berisi query SQL
│   ├── dashboard_olist.png           # Tampilan dashboard
│
├── 3-ecommerce_data_analysis/
│   ├── dashboard/                    # File aplikasi Streamlit (dashboard.py) & data bersih
│   ├── data/                         # Berkas dataset mentah
│   ├── notebook.ipynb                # Proses pembersihan data & Exploratory Data Analysis (EDA)
│   ├── requirements.txt              # Daftar dependensi library Python
│   └── README.md                     # Dokumentasi spesifik proyek Streamlit
|
└── README.md                         # File ini
```

---

## Hubungi Saya

Terbuka untuk peluang magang, feedback, dan diskusi seputar data.

- 🔗 LinkedIn: [linkedin.com/in/fadlanfdilah](https://www.linkedin.com/in/fadlanfdilah)
- 🌐 Portfolio: [bit.ly/PortfolioDataAnalyst_Fadlan](https://bit.ly/PortfolioDataAnalyst_Fadlan)
- 📧 Email: [fadlanfadilah250@gmail.com](mailto:fadlanfadilah250@gmail.com)

---
*Terakhir diperbarui: September 2026 · Portfolio ini terus diperbarui seiring proyek baru selesai dikerjakan.*
