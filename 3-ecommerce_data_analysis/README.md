# E-Commerce Public Dataset - Data Analytics Dashboard

## Pertanyaan Bisnis
Analisis ini dikembangkan untuk menjawab dua pertanyaan bisnis utama:
1. Bagaimana tren total pendapatan bulanan untuk 3 kategori produk terlaris sepanjang tahun 2018?
2. Negara bagian (*state*) mana yang menyumbang volume pesanan terbanyak untuk kategori terlaris tersebut di tahun 2018?

## Struktur Direktori
```text
submission/
├── dashboard/
│   ├── dashboard.py
│   └── main_data.csv
├── data/
│   ├── customers_dataset.csv
│   ├── order_items_dataset.csv
│   ├── orders_dataset.csv
│   └── products_dataset.csv
├── notebook.ipynb
├── README.md 
└── requirements.txt
```

## Cara Menjalankan Dashboard Secara Lokal
Ikuti langkah-langkah berikut untuk menjalankan dashboard interaktif ini di komputer lokal:

1. Buka Terminal atau Command Prompt.
2. Arahkan direktori aktif ke dalam folder dashboard:
```bash
cd path/ke/folder/submission/dashboard
```
3. Instal seluruh dependensi yang dibutuhkan:
```bash
pip install -r ../reuirements.txt
```
4. Jalankan aplikasi Streamlit. (Sangat disarankan menggunakan awalan python -m untuk menghindari kendala Environment Variables/PATH di Windows):
```bash
python -m streamlit run dashboard.py
```
5. Dashboard akan otomatis terbuka di browser pada alamat http://localhost:8501.

## Deployment
Dashboard ini juga telah di-deploy ke Streamlit Community Cloud agar dapat diakses secara publik tanpa perlu melakukan instalasi lokal.

Tautan Dashboard Interaktif: https://ecommerce-data-dashboard.streamlit.app/

*Proyek ini diselesaikan sebagai portfolio Data Analytics dan submission program Asah Dicoding 2026*