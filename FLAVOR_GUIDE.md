# Flutter Flavor Configuration

## 📱 Apa itu Flavor?

Flavor adalah cara untuk membuat beberapa versi aplikasi dari satu codebase yang sama. Biasanya digunakan untuk:
- **Development**: Untuk testing dan development
- **Production**: Untuk release ke user

## 🚀 Cara Menjalankan Flavor

> **⚠️ PENTING: Project ini menggunakan FVM (Flutter Version Management)**
> 
> Pastikan Anda menggunakan command `fvm flutter` bukan `flutter` saja untuk menghindari konflik versi Dart SDK.

### 1. Menggunakan FVM (RECOMMENDED)

Project ini sudah dikonfigurasi dengan FVM menggunakan Flutter 3.16.4 (Dart 3.2.3).

#### Development
```bash
# Run di emulator/device (Android)
fvm flutter run --flavor cu_development -t lib/main_dev.dart

# Run di emulator/device (iOS)
fvm flutter run --flavor cu_development -t lib/main_dev.dart

# Build APK
fvm flutter build apk --flavor cu_development -t lib/main_dev.dart

# Build iOS
fvm flutter build ios --flavor cu_development -t lib/main_dev.dart
```

#### Production
```bash
# Run di emulator/device (Android)
fvm flutter run --flavor cu_production -t lib/main_prod.dart

# Run di emulator/device (iOS)
fvm flutter run --flavor cu_production -t lib/main_prod.dart

# Build APK
fvm flutter build apk --flavor cu_production -t lib/main_prod.dart

# Build iOS
fvm flutter build ios --flavor cu_production -t lib/main_prod.dart
```


### 2. Menggunakan Command Line (Tanpa FVM)

#### Development
```bash
# Run di emulator/device
flutter run --flavor cu_development -t lib/main_dev.dart

# Build APK
flutter build apk --flavor cu_development -t lib/main_dev.dart

# Build iOS
flutter build ios --flavor cu_development -t lib/main_dev.dart
```

#### Production
```bash
# Run di emulator/device
flutter run --flavor cu_production -t lib/main_prod.dart

# Build APK
flutter build apk --flavor cu_production -t lib/main_prod.dart

# Build iOS
flutter build ios --flavor cu_production -t lib/main_prod.dart
```

### 3. Menggunakan VS Code

VS Code sudah dikonfigurasi untuk menggunakan FVM secara otomatis (lihat `.vscode/settings.json`).

1. Tekan `F5` atau klik menu `Run > Start Debugging`
2. Pilih flavor yang ingin dijalankan:
   - **Development (Debug)** - untuk development
   - **Production (Debug)** - untuk production
   - **Development (Profile)** - untuk testing performance
   - **Production (Profile)** - untuk testing performance production
   - **Development (Release)** - untuk build release development
   - **Production (Release)** - untuk build release production

3. Atau klik dropdown di bagian atas VS Code (di sebelah tombol play) dan pilih konfigurasi yang diinginkan

**Note**: Jika VS Code masih menggunakan Dart SDK yang salah, restart VS Code setelah membuat `.vscode/settings.json`

### 4. Menggunakan Android Studio / IntelliJ

1. Klik dropdown di toolbar (biasanya bertuliskan "main.dart")
2. Pilih "Edit Configurations..."
3. Klik tombol "+" dan pilih "Flutter"
4. Isi:
   - **Name**: Development
   - **Dart entrypoint**: lib/main_dev.dart
5. Klik "OK"
6. Ulangi untuk Production dengan entrypoint `lib/main_prod.dart`

## 📝 Struktur File Flavor

```
lib/
├── main.dart              # Widget utama aplikasi
├── main_dev.dart          # Entry point untuk Development
├── main_prod.dart         # Entry point untuk Production
└── main_config.dart       # Konfigurasi flavor
```

## 🔧 Cara Menggunakan Flavor di Code

Untuk mengakses flavor indicator di dalam aplikasi:

```dart
import 'package:catat_uang/main_config.dart';

// Di dalam widget
String flavor = MainConfig.of(context).flavorIndicator ?? 'unknown';

// Contoh penggunaan
if (flavor == 'cu_development') {
  print('Running in Development mode');
} else if (flavor == 'cu_production') {
  print('Running in Production mode');
}
```

## 🎯 Perbedaan Development vs Production

### Development (main_dev.dart)
- Flavor indicator: `cu_development`
- Biasanya connect ke development server/database
- Bisa menampilkan debug info
- Untuk testing dan development

### Production (main_prod.dart)
- Flavor indicator: `cu_production`
- Connect ke production server/database
- Tidak menampilkan debug info
- Untuk release ke user

## 💡 Tips

1. **Jangan pernah** commit file yang berisi API keys production ke git
2. Gunakan environment variables untuk menyimpan sensitive data
3. Selalu test di flavor production sebelum release
4. Gunakan flavor development untuk daily development

## 🔐 Best Practices

1. Pisahkan konfigurasi API endpoint berdasarkan flavor
2. Gunakan Firebase projects yang berbeda untuk dev dan prod
3. Tambahkan visual indicator (misalnya banner) di development mode
4. Setup CI/CD untuk auto-build berdasarkan flavor

## 📦 Build untuk Release

### Android APK
```bash
# Development
flutter build apk -t lib/main_dev.dart --release

# Production
flutter build apk -t lib/main_prod.dart --release
```

### Android App Bundle (untuk Play Store)
```bash
# Production
flutter build appbundle -t lib/main_prod.dart --release
```

### iOS
```bash
# Production
flutter build ios -t lib/main_prod.dart --release
```

## ❓ Troubleshooting

### Error: "Can't load Kernel binary: Invalid kernel binary format version"
Ini terjadi karena Dart SDK yang aktif berbeda dengan yang dibutuhkan project. **Solusi:**

1. **Gunakan FVM:**
   ```bash
   fvm flutter run -t lib/main_dev.dart
   ```

2. **Atau update FVM:**
   ```bash
   dart pub global activate fvm
   ```

### Error: "Dart SDK version is 2.19.0 but project requires >=3.2.0"
Project ini membutuhkan Dart SDK 3.2.0+. **Solusi:**

1. **Install FVM jika belum:**
   ```bash
   dart pub global activate fvm
   ```

2. **Install Flutter 3.16.4 dengan FVM:**
   ```bash
   fvm install 3.16.4
   ```

3. **Gunakan Flutter 3.16.4 untuk project ini:**
   ```bash
   fvm use 3.16.4
   ```

4. **Jalankan dengan FVM:**
   ```bash
   fvm flutter run -t lib/main_dev.dart
   ```

### VS Code menggunakan Dart SDK yang salah
1. Pastikan file `.vscode/settings.json` sudah ada dan berisi:
   ```json
   {
     "dart.flutterSdkPath": ".fvm/flutter_sdk"
   }
   ```

2. Restart VS Code (Command Palette > "Developer: Reload Window")

3. Cek Dart SDK yang digunakan di status bar (pojok kanan bawah)

### Error: "No such file or directory"
Pastikan path file benar: `lib/main_dev.dart` atau `lib/main_prod.dart`

### Flavor tidak terdeteksi
Pastikan Anda sudah import `main_config.dart` dan menggunakan `MainConfig.of(context)`

### Build gagal
1. Jalankan `fvm flutter clean`
2. Jalankan `fvm flutter pub get`
3. Coba build lagi

### FVM tidak ditemukan
Tambahkan FVM ke PATH:
```bash
# Tambahkan ke ~/.zshrc atau ~/.bashrc
export PATH="$PATH":"$HOME/.pub-cache/bin"
```

Kemudian restart terminal atau jalankan:
```bash
source ~/.zshrc  # atau source ~/.bashrc
```
