import 'package:flutter/material.dart';

class AddNoteDialog extends StatelessWidget {
  const AddNoteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      backgroundColor: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: Row(
        children: [
          Icon(Icons.edit_note_rounded, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          Text('Tambah Catatan', style: TextStyle(color: theme.colorScheme.onSurface)),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Judul Catatan',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: theme.colorScheme.outline),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: theme.colorScheme.primary),
                ),
                prefixIcon: Icon(Icons.title, color: theme.colorScheme.primary),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Isi Catatan',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: theme.colorScheme.outline),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: theme.colorScheme.primary),
                ),
                alignLabelWithHint: true,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 64.0),
                  child: Icon(Icons.note_alt, color: theme.colorScheme.primary),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Batal', style: TextStyle(color: theme.colorScheme.primary)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Catatan berhasil ditambahkan!')),
            );
          },
          child: const Text('Simpan'),
        ),
      ],
    );
  }
}