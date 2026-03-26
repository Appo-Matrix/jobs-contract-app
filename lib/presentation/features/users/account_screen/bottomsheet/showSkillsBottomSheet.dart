import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../providers/skill_provider.dart';
import 'SkillChip.dart';

Future<void> showSkillsBottomSheet(BuildContext context, bool isDark) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    // ✅ This makes the sheet resize when keyboard appears
    useSafeArea: true,
    backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => _SkillsSheet(isDark: isDark),
  );
}

class _SkillsSheet extends StatefulWidget {
  final bool isDark;
  const _SkillsSheet({required this.isDark});

  @override
  State<_SkillsSheet> createState() => _SkillsSheetState();
}

class _SkillsSheetState extends State<_SkillsSheet> {
  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';
  Timer? _debounce;
  Set<String> _selectedNames = {};
  bool _isSaving = false;

  ScrollController? _sheetScrollController;

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      if (!mounted) return;
      await context.read<SkillProvider>().loadAllSkills();

      if (!mounted) return;
      await context.read<SkillProvider>().loadMySkills();

      if (!mounted) return;
      final mySkills = context.read<SkillProvider>().mySkills;
      setState(() {
        _selectedNames = mySkills.map((s) => s.name.toLowerCase()).toSet();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _sheetScrollController?.removeListener(_onScroll);
    _debounce?.cancel();
    super.dispose();
  }

  void _attachScrollListener(ScrollController controller) {
    if (_sheetScrollController == controller) return;
    _sheetScrollController?.removeListener(_onScroll);
    _sheetScrollController = controller;
    _sheetScrollController!.addListener(_onScroll);
  }

  void _onScroll() {
    final sc = _sheetScrollController;
    if (sc == null || !sc.hasClients) return;
    if (sc.position.pixels >= sc.position.maxScrollExtent - 200) {
      context.read<SkillProvider>().loadMoreSkills(query: _searchQuery);
    }
  }

  void _onSearchChanged(String val) {
    setState(() => _searchQuery = val);
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      context.read<SkillProvider>().filterSkills(val.trim());
    });
  }

  Future<void> _saveSkills() async {
    setState(() => _isSaving = true);

    final provider = context.read<SkillProvider>();
    final currentMySkills = provider.mySkills;
    final currentNames =
    currentMySkills.map((s) => s.name.toLowerCase()).toSet();

    final toAdd = _selectedNames.difference(currentNames);
    final toRemove = currentMySkills
        .where((s) => !_selectedNames.contains(s.name.toLowerCase()))
        .toList();

    try {
      await Future.wait([
        ...toAdd.map((name) => provider.addSkill(name)),
        ...toRemove.map((s) => provider.deleteSkill(s.id!)),
      ]);

      if (mounted) {
        await provider.loadMySkills();
        Navigator.pop(context);
      }
    } catch (e) {
      debugPrint('Error saving skills: $e');
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _addNewSkill() async {
    final name = _searchQuery.trim();
    if (name.isEmpty) return;

    final provider = context.read<SkillProvider>();
    try {
      await provider.addSkill(name);
      if (!mounted) return;

      setState(() {
        _selectedNames.add(name.toLowerCase());
        _searchQuery = '';
        _searchController.clear();
      });

      provider.filterSkills('');
    } catch (e) {
      debugPrint('Error adding new skill: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SkillProvider>();
    final visibleSkills = provider.visibleSkills;
    final totalSkills = provider.totalSkillCount; // ✅ total unique count
    final isInitialLoading = provider.isLoadingAll || provider.isLoadingMine;
    final queryExistsInAll = provider.skillExistsByName(_searchQuery);

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      minChildSize: 0.5,
      maxChildSize: 0.92,
      builder: (ctx, sheetScrollController) {
        _attachScrollListener(sheetScrollController);

        return Column(
          children: [
            // ── Handle bar ─────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: widget.isDark
                        ? JAppColors.darkGray500
                        : JAppColors.lightGray300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),

            // ── Header + search ────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Manage Skills',
                        style: AppTextStyle.dmSans(
                          fontSize: 18.0,
                          weight: FontWeight.w700,
                          color: widget.isDark
                              ? JAppColors.darkGray100
                              : JAppColors.lightGray800,
                        ),
                      ),
                      // ✅ Shows selected count and total count
                      Text(
                        '${_selectedNames.length} selected · $totalSkills total',
                        style: AppTextStyle.dmSans(
                          fontSize: JSizes.fontSizeSm,
                          weight: FontWeight.w500,
                          color: JAppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Select skills to add to your profile',
                    style: AppTextStyle.dmSans(
                      fontSize: JSizes.fontSizeSm,
                      weight: FontWeight.w400,
                      color: widget.isDark
                          ? JAppColors.darkGray300
                          : JAppColors.lightGray600,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Search field
                  TextField(
                    controller: _searchController,
                    onChanged: _onSearchChanged,
                    // ✅ Dismiss keyboard on done instead of new line
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: 'Search or type a new skill...',
                      hintStyle: AppTextStyle.dmSans(
                        fontSize: JSizes.fontSizeSm,
                        weight: FontWeight.w400,
                        color: widget.isDark
                            ? JAppColors.darkGray300
                            : JAppColors.lightGray500,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: widget.isDark
                            ? JAppColors.darkGray300
                            : JAppColors.lightGray500,
                      ),
                      suffixIcon: _searchQuery.isNotEmpty && !queryExistsInAll
                          ? IconButton(
                        tooltip: 'Add "$_searchQuery"',
                        onPressed: _addNewSkill,
                        icon: Icon(
                          Icons.add_circle,
                          color: JAppColors.primary,
                        ),
                      )
                          : _searchQuery.isNotEmpty
                      // ✅ X button to clear search
                          ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                          _onSearchChanged('');
                        },
                        icon: Icon(
                          Icons.clear,
                          color: widget.isDark
                              ? JAppColors.darkGray300
                              : JAppColors.lightGray500,
                        ),
                      )
                          : null,
                      filled: true,
                      fillColor: widget.isDark
                          ? JAppColors.backGroundDarkCard
                          : JAppColors.lightGray100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),

            // ── Skill list ─────────────────────────────────────────────────
            Expanded(
              child: isInitialLoading
                  ? const Center(child: CircularProgressIndicator())
                  : visibleSkills.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                controller: sheetScrollController,
                padding:
                const EdgeInsets.symmetric(horizontal: 16),
                itemCount: visibleSkills.length +
                    (_selectedNames.isNotEmpty ? 1 : 0) +
                    (provider.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (_selectedNames.isNotEmpty && index == 0) {
                    return _buildSelectedSection(provider);
                  }

                  final skillIndex =
                  _selectedNames.isNotEmpty ? index - 1 : index;

                  if (skillIndex == visibleSkills.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                          child: CircularProgressIndicator()),
                    );
                  }

                  final skill = visibleSkills[skillIndex];
                  final selected = _selectedNames
                      .contains(skill.name.toLowerCase());

                  return _buildSkillRow(skill.name, selected);
                },
              ),
            ),

            // ── Bottom buttons ─────────────────────────────────────────────
            // ✅ Padding here pushes buttons above keyboard
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: widget.isDark
                      ? JAppColors.backGroundDark
                      : Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: widget.isDark
                          ? JAppColors.darkGray700
                          : JAppColors.lightGray200,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed:
                        _isSaving ? null : () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding:
                          const EdgeInsets.symmetric(vertical: 12),
                          side: BorderSide(
                            color: widget.isDark
                                ? JAppColors.darkGray400
                                : JAppColors.lightGray400,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: AppTextStyle.dmSans(
                            fontSize: JSizes.fontSizeMd,
                            weight: FontWeight.w600,
                            color: widget.isDark
                                ? JAppColors.darkGray200
                                : JAppColors.lightGray700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isSaving ? null : _saveSkills,
                        style: ElevatedButton.styleFrom(
                          padding:
                          const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: JAppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: _isSaving
                            ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                            : Text(
                          'Save Skills',
                          style: AppTextStyle.dmSans(
                            fontSize: JSizes.fontSizeMd,
                            weight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSelectedSection(SkillProvider provider) {
    final fromVisible = provider.visibleSkills
        .where((s) => _selectedNames.contains(s.name.toLowerCase()))
        .map((s) => s.name);

    final fromMine = provider.mySkills
        .where((s) => _selectedNames.contains(s.name.toLowerCase()))
        .map((s) => s.name);

    final names = {...fromVisible, ...fromMine}.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selected (${_selectedNames.length})',
          style: AppTextStyle.dmSans(
            fontSize: JSizes.fontSizeSm,
            weight: FontWeight.w600,
            color: widget.isDark
                ? JAppColors.lightGray300
                : JAppColors.darkGray700,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: names
              .map((name) => SkillChip12(
            name: name,
            isSelected: true,
            isDark: widget.isDark,
            onTap: () => setState(
                    () => _selectedNames.remove(name.toLowerCase())),
          ))
              .toList(),
        ),
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 8),
        Text(
          _searchQuery.isEmpty ? 'All Skills' : 'Search Results',
          style: AppTextStyle.dmSans(
            fontSize: JSizes.fontSizeSm,
            weight: FontWeight.w600,
            color: widget.isDark
                ? JAppColors.lightGray300
                : JAppColors.darkGray700,
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildSkillRow(String name, bool selected) {
    return InkWell(
      onTap: () {
        setState(() {
          if (selected) {
            _selectedNames.remove(name.toLowerCase());
          } else {
            _selectedNames.add(name.toLowerCase());
          }
        });
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        child: Row(
          children: [
            Expanded(
              child: Text(
                name,
                style: AppTextStyle.dmSans(
                  fontSize: JSizes.fontSizeMd,
                  weight: FontWeight.w400,
                  color: widget.isDark
                      ? JAppColors.darkGray100
                      : JAppColors.lightGray800,
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: selected ? JAppColors.primary : Colors.transparent,
                border: Border.all(
                  color: selected
                      ? JAppColors.primary
                      : (widget.isDark
                      ? JAppColors.darkGray400
                      : JAppColors.lightGray400),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: selected
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off,
              size: 48,
              color: widget.isDark
                  ? JAppColors.darkGray400
                  : JAppColors.lightGray400,
            ),
            const SizedBox(height: 12),
            Text(
              'No skill found',
              style: AppTextStyle.dmSans(
                fontSize: JSizes.fontSizeMd,
                weight: FontWeight.w500,
                color: widget.isDark
                    ? JAppColors.darkGray300
                    : JAppColors.lightGray600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap + to add "$_searchQuery" as a new skill',
              textAlign: TextAlign.center,
              style: AppTextStyle.dmSans(
                fontSize: JSizes.fontSizeSm,
                weight: FontWeight.w400,
                color: widget.isDark
                    ? JAppColors.darkGray400
                    : JAppColors.lightGray500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}