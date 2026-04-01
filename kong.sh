#!/bin/bash

# --- Warna ---
KUNING='\033[1;33m'
NORMAL='\033[0m'
HIJAU='\033[0;32m'
MERAH='\033[0;31m'
CYAN='\033[0;36m'

# --- File Database ---
DATABASE="catatan_kerja_april_2026.txt"

# --- Fungsi Header & Teks Berjalan ---
tampilkan_header() {
    clear
    echo -e "${KUNING}"
    # Logo KONG KERJA Tebal Satu Baris
    echo "██╗  ██╗ ██████╗ ███╗   ██╗ ██████╗     ██╗  ██╗ ███████╗ ██████╗      ██╗  █████╗ "
    echo "██║ ██╔╝██╔═══██╗████╗  ██║██╔════╝     ██║ ██╔╝ ██╔════╝ ██╔══██╗     ██║ ██╔══██╗"
    echo "█████╔╝ ██║   ██║██╔██╗ ██║██║  ███╗    █████╔╝  █████╗   ██████╔╝     ██║ ███████║"
    echo "██╔═██╗ ██║   ██║██║╚██╗██║██║   ██║    ██╔═██╗  ██╔══╝   ██╔══██╗██   ██║ ██╔══██║"
    echo "██║  ██╗╚██████╔╝██║ ╚████║╚██████╔╝    ██║  ██╗ ███████╗ ██║  ██║╚█████╔╝ ██║  ██║"
    echo "╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝     ╚═╝  ╚═╝ ╚══════╝ ╚═╝  ╚═╝ ╚════╝  ╚═╝  ╚═╝"
    echo -e "${NORMAL}"

    # Teks Berjalan Identitas
    TEXT=">>>-{ where anonymous : by Laksamana dzu nur ain }-<<<"
    for (( i=0; i<${#TEXT}; i++ )); do
        echo -ne "${KUNING}${TEXT:$i:1}"
        sleep 0.01
    done
    echo -e "${NORMAL}\n"
}

# --- Fungsi Start Catat (Kalender Otomatis 2026) ---
start_catat() {
    tampilkan_header
    echo -e "${CYAN}[ INPUT JAM KERJA APRIL 2026 ]${NORMAL}"
    echo -e "Masukkan angka tanggal (1-30):"
    read -p ">> " tgl_pilih

    # Validasi Input
    if [[ "$tgl_pilih" -lt 1 || "$tgl_pilih" -gt 30 ]]; then
        echo -e "${MERAH}Hanya untuk bulan April (1-30)!${NORMAL}"
        sleep 2
        return
    fi

    # Menentukan Hari Otomatis (April 2026)
    HARI_ENG=$(date -d "2026-04-$tgl_pilih" +"%A")
    case $HARI_ENG in
        Monday) HARI="Senin" ;; Tuesday) HARI="Selasa" ;; Wednesday) HARI="Rabu" ;;
        Thursday) HARI="Kamis" ;; Friday) HARI="Jumat" ;; Saturday) HARI="Sabtu" ;;
        Sunday) HARI="Minggu" ;;
    esac

    echo -e "\n------------------------------------"
    echo -e "${KUNING}Hari $HARI tgl $tgl_pilih bulan 4 Tahun 2026${NORMAL}"
    echo -e "------------------------------------"
    
    # Input Manual Jam Kerja oleh Kamu
    read -p "Masuk kerja jam  = " msk
    read -p "Kluar kerja jam  = " klr
    read -p "Tambahan         = " tamb

    # Simpan Data ke File
    echo "------------------------------------" >> $DATABASE
    echo "Hari $HARI tgl $tgl_pilih bulan 4 Tahun 2026" >> $DATABASE
    echo "Masuk kerja jam = $msk" >> $DATABASE
    echo "Kluar kerja jam = $klr" >> $DATABASE
    echo "Tambahan = $tamb" >> $DATABASE
    
    echo -e "\n${HIJAU}Berhasil disimpan ke $DATABASE!${NORMAL}"
    sleep 2
}

# --- Fungsi Lihat Catatan ---
lihat_catatan() {
    tampilkan_header
    if [ -f "$DATABASE" ]; then
        echo -e "${KUNING}======= LOG CATATAN KERJA =======${NORMAL}"
        cat "$DATABASE"
        echo -e "${KUNING}=================================${NORMAL}"
        echo -e "\nTekan Enter untuk kembali ke menu..."
        read
    else
        echo -e "${MERAH}Belum ada data tersimpan.${NORMAL}"
        sleep 2
    fi
}

# --- Menu Utama ---
while true; do
    tampilkan_header
    echo -e "${KUNING}1.${NORMAL} Start Catat Kong"
    echo -e "${KUNING}2.${NORMAL} Lihat Catatan Kong"
    echo -e "${KUNING}3.${NORMAL} Exit"
    echo ""
    read -p "Pilih menu : " pilih

    case $pilih in
        1) start_catat ;;
        2) lihat_catatan ;;
        3) echo -e "${HIJAU}Siap Partner. Program selesai.${NORMAL}"; exit ;;
        *) echo -e "${MERAH}Pilihan salah!${NORMAL}"; sleep 1 ;;
    esac
done
