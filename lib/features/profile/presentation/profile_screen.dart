import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme.dart';
import '../../auth/application/auth_controller.dart';

/// Editable name + skill-tags, with the default dashboard role shown
/// read-only (changing it is out of scope for this phase — a project's own
/// `members` map is what ultimately decides role per-project, see
/// [UserRole]'s TODO).
class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  late final TextEditingController _nameController;
  final _tagController = TextEditingController();
  List<String> _skillTags = [];
  bool _saving = false;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  void _addTag(String raw) {
    final tag = raw.trim();
    _tagController.clear();
    if (tag.isEmpty || _skillTags.contains(tag)) return;
    setState(() => _skillTags = [..._skillTags, tag]);
  }

  void _removeTag(String tag) {
    setState(() => _skillTags = _skillTags.where((t) => t != tag).toList());
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      await ref
          .read(authControllerProvider.notifier)
          .updateProfile(
            name: _nameController.text.trim(),
            skillTags: _skillTags,
          );
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Profile saved')));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(authControllerProvider).profile;
    final theme = Theme.of(context);
    final appColors = theme.appColors;

    if (profile == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!_initialized) {
      _nameController.text = profile.name;
      _skillTags = List.of(profile.skillTags);
      _initialized = true;
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                prefixIcon: Icon(Icons.badge_outlined),
              ),
            ),
            const SizedBox(height: 16),
            InputDecorator(
              decoration: const InputDecoration(labelText: 'Email'),
              child: Text(profile.email),
            ),
            const SizedBox(height: 16),
            InputDecorator(
              decoration: const InputDecoration(labelText: 'Default role'),
              child: Text(profile.defaultRole.label),
            ),
            const SizedBox(height: 24),
            Text('Skill tags', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final tag in _skillTags)
                  Chip(
                    label: Text(tag),
                    backgroundColor: appColors.chipBackground,
                    labelStyle: TextStyle(color: appColors.chipText),
                    deleteIconColor: appColors.chipText,
                    onDeleted: () => _removeTag(tag),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _tagController,
              decoration: InputDecoration(
                labelText: 'Add a skill tag',
                hintText: 'e.g. Graphic Designer',
                prefixIcon: const Icon(Icons.add_outlined),
              ),
              onSubmitted: _addTag,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _saving ? null : _save,
              child: _saving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
