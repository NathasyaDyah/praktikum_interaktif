
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Form Biodata',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          primary: const Color(0xFF7041B8),
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F3FF),
      ),
      home: const BiodataPage(),
    );
  }
}

class BiodataPage extends StatefulWidget {
  const BiodataPage({super.key});

  @override
  State<BiodataPage> createState() => _BiodataPageState();
}

class _BiodataPageState extends State<BiodataPage> {
  final _formKey = GlobalKey<FormState>();

  final namaCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final hpCtrl = TextEditingController();

  bool setuju = false;

  @override
  void dispose() {
    namaCtrl.dispose();
    emailCtrl.dispose();
    hpCtrl.dispose();
    super.dispose();
  }

  InputDecoration inputDecoration(
    String label,
    String hint,
    IconData icon,
  ) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: const Color(0xFF8052C7)),
      filled: true,
      fillColor: const Color(0xFFFAF8FF),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE2D7F2)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE2D7F2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Color(0xFF8052C7),
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }

  void simpanBiodata() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!setuju) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan setujui syarat dan ketentuan.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final nama = namaCtrl.text.trim();
    final email = emailCtrl.text.trim();
    final hp = hpCtrl.text.trim();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Data berhasil disimpan!\n'
          'Nama: $nama\n'
          'Email: $email\n'
          'No. HP: $hp',
        ),
        duration: const Duration(seconds: 5),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF6035A0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 550),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF9B71D6),
                          Color(0xFF6035A0),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.person_add_alt_1,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Form Biodata',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Silakan lengkapi data diri kamu '
                          'pada formulir di bawah ini.',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Form Card
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepPurple.withValues(
                            alpha: 0.08,
                          ),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Informasi Pribadi',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF542B91),
                            ),
                          ),

                          const SizedBox(height: 6),

                          const Text(
                            'Pastikan semua data terisi dengan benar.',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Nama
                          TextFormField(
                            controller: namaCtrl,
                            textCapitalization:
                                TextCapitalization.words,
                            decoration: inputDecoration(
                              'Nama Lengkap',
                              'Masukkan nama lengkap',
                              Icons.person_outline,
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty) {
                                return 'Nama wajib diisi';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 18),

                          // Email
                          TextFormField(
                            controller: emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            decoration: inputDecoration(
                              'Email',
                              'Masukkan alamat email',
                              Icons.email_outlined,
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty) {
                                return 'Email wajib diisi';
                              }

                              if (!value.contains('@')) {
                                return 'Email harus mengandung @';
                              }

                              return null;
                            },
                          ),

                          const SizedBox(height: 18),

                          // Nomor HP
                          TextFormField(
                            controller: hpCtrl,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: inputDecoration(
                              'Nomor HP',
                              'Masukkan nomor HP',
                              Icons.phone_android,
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty) {
                                return 'Nomor HP wajib diisi';
                              }

                              if (value.trim().length < 10) {
                                return 'Nomor HP minimal 10 digit';
                              }

                              return null;
                            },
                          ),

                          const SizedBox(height: 18),

                          // Checkbox
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF6F0FF),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: CheckboxListTile(
                              value: setuju,
                              activeColor: const Color(0xFF7041B8),
                              controlAffinity:
                                  ListTileControlAffinity.leading,
                              contentPadding:
                                  const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              title: const Text(
                                'Saya menyetujui syarat dan ketentuan',
                                style: TextStyle(fontSize: 13),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  setuju = value ?? false;
                                });
                              },
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Tombol Simpan
                          SizedBox(
                            width: double.infinity,
                            height: 54,
                            child: ElevatedButton.icon(
                              onPressed: simpanBiodata,
                              icon: const Icon(
                                Icons.save_outlined,
                                color: Colors.white,
                              ),
                              label: const Text(
                                'Simpan Biodata',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color(0xFF7041B8),
                                foregroundColor: Colors.white,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.verified_user_outlined,
                        size: 16,
                        color: Color(0xFF8052C7),
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Pastikan data diri sudah benar sebelum disimpan.',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Praktikum Pemrograman Mobile - Pertemuan 5',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF8052C7),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
