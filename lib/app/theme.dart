import 'package:flutter/material.dart';

/// Raw slate-blue brand palette. Nothing outside this file should reference
/// these constants directly — go through [AppTheme.lightTheme] /
/// [AppTheme.darkTheme] (and [AppColors] for the roles [ColorScheme] has no
/// slot for) so every color stays swappable from one place.
class AppPalette {
  AppPalette._();

  // Base scale
  static const slateDarkest = Color(0xFF27374D);
  static const slateMid = Color(0xFF526D82);
  static const slateSoft = Color(0xFF9DB2BF);
  static const slateLight = Color(0xFFDDE6ED);

  // Chrome (AppBar + sidebar/nav) — fixed across light and dark mode.
  static const chromeHover = Color(0xFF2F4360);

  // Light mode content area
  static const pageBackgroundLight = Color(0xFFF3F6F9);

  // Dark mode content area
  static const overlayBackgroundDark = Color(0xFF2F4360);
  static const textOnPageDark = Color(0xFFF5F9FC);
  static const secondaryTextOnPageDark = Color(0xFFE6EDF3);
}

/// Design-system colors with no home on [ColorScheme]: the fixed AppBar/nav
/// chrome, dialog/dropdown surfaces, text field styling, the progress bar,
/// and per-status task badges (To Do / In Progress / Blocked / Completed /
/// Overdue).
///
/// Access via `Theme.of(context).appColors`.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.sidebar,
    required this.sidebarBorder,
    required this.sidebarHover,
    required this.sidebarInactive,
    required this.sidebarSelected,
    required this.sidebarIndicator,
    required this.primaryHover,
    required this.textOnPage,
    required this.secondaryTextOnPage,
    required this.overlayBackground,
    required this.dialogBorder,
    required this.textFieldFill,
    required this.textFieldBorder,
    required this.progressTrack,
    required this.progressFill,
    required this.chipBackground,
    required this.chipText,
    required this.statusToDoBackground,
    required this.statusToDoText,
    required this.statusInProgressBackground,
    required this.statusInProgressText,
    required this.statusBlockedBackground,
    required this.statusBlockedText,
    required this.statusCompletedBackground,
    required this.statusCompletedText,
    required this.statusOverdueBackground,
    required this.statusOverdueText,
  });

  // Chrome — identical in both themes.
  final Color sidebar;
  final Color sidebarBorder;
  final Color sidebarHover;
  final Color sidebarInactive;
  final Color sidebarSelected;
  final Color sidebarIndicator;

  final Color primaryHover;
  final Color textOnPage;
  final Color secondaryTextOnPage;
  final Color overlayBackground;
  final Color dialogBorder;
  final Color textFieldFill;
  final Color textFieldBorder;
  final Color progressTrack;
  final Color progressFill;
  final Color chipBackground;
  final Color chipText;
  final Color statusToDoBackground;
  final Color statusToDoText;
  final Color statusInProgressBackground;
  final Color statusInProgressText;
  final Color statusBlockedBackground;
  final Color statusBlockedText;
  final Color statusCompletedBackground;
  final Color statusCompletedText;
  final Color statusOverdueBackground;
  final Color statusOverdueText;

  static const light = AppColors(
    sidebar: AppPalette.slateDarkest,
    sidebarBorder: AppPalette.slateMid,
    sidebarHover: AppPalette.chromeHover,
    sidebarInactive: AppPalette.slateSoft,
    sidebarSelected: AppPalette.slateLight,
    sidebarIndicator: AppPalette.slateMid,
    primaryHover: AppPalette.slateDarkest,
    textOnPage: AppPalette.slateDarkest,
    secondaryTextOnPage: AppPalette.slateMid,
    overlayBackground: Colors.white,
    dialogBorder: AppPalette.slateLight,
    textFieldFill: Colors.white,
    textFieldBorder: AppPalette.slateSoft,
    progressTrack: AppPalette.slateLight,
    progressFill: AppPalette.slateMid,
    chipBackground: AppPalette.slateLight,
    chipText: AppPalette.slateDarkest,
    statusToDoBackground: Color(0xFFE7EAEE),
    statusToDoText: Color(0xFF54606B),
    statusInProgressBackground: AppPalette.slateLight,
    statusInProgressText: AppPalette.slateDarkest,
    statusBlockedBackground: Color(0xFFFDECC8),
    statusBlockedText: Color(0xFF8A5A00),
    statusCompletedBackground: Color(0xFFDCF3E8),
    statusCompletedText: Color(0xFF2E7D5B),
    statusOverdueBackground: Color(0xFFFEE2E2),
    statusOverdueText: Color(0xFFB91C1C),
  );

  static const dark = AppColors(
    sidebar: AppPalette.slateDarkest,
    sidebarBorder: AppPalette.slateMid,
    sidebarHover: AppPalette.chromeHover,
    sidebarInactive: AppPalette.slateSoft,
    sidebarSelected: AppPalette.slateLight,
    sidebarIndicator: AppPalette.slateMid,
    primaryHover: AppPalette.chromeHover,
    textOnPage: AppPalette.textOnPageDark,
    secondaryTextOnPage: AppPalette.secondaryTextOnPageDark,
    overlayBackground: AppPalette.overlayBackgroundDark,
    dialogBorder: AppPalette.slateMid,
    textFieldFill: AppPalette.overlayBackgroundDark,
    textFieldBorder: AppPalette.slateMid,
    progressTrack: AppPalette.slateMid,
    progressFill: AppPalette.slateLight,
    chipBackground: AppPalette.slateMid,
    chipText: AppPalette.textOnPageDark,
    statusToDoBackground: Color(0xFF3D4E5E),
    statusToDoText: Color(0xFFD3DBE1),
    statusInProgressBackground: AppPalette.slateMid,
    statusInProgressText: AppPalette.textOnPageDark,
    statusBlockedBackground: Color(0xFF5C4A22),
    statusBlockedText: Color(0xFFFFD9A0),
    statusCompletedBackground: Color(0xFF1F4A38),
    statusCompletedText: Color(0xFF7FD1A6),
    statusOverdueBackground: Color(0xFF6A3630),
    statusOverdueText: Color(0xFFFFC9BF),
  );

  @override
  AppColors copyWith({
    Color? sidebar,
    Color? sidebarBorder,
    Color? sidebarHover,
    Color? sidebarInactive,
    Color? sidebarSelected,
    Color? sidebarIndicator,
    Color? primaryHover,
    Color? textOnPage,
    Color? secondaryTextOnPage,
    Color? overlayBackground,
    Color? dialogBorder,
    Color? textFieldFill,
    Color? textFieldBorder,
    Color? progressTrack,
    Color? progressFill,
    Color? chipBackground,
    Color? chipText,
    Color? statusToDoBackground,
    Color? statusToDoText,
    Color? statusInProgressBackground,
    Color? statusInProgressText,
    Color? statusBlockedBackground,
    Color? statusBlockedText,
    Color? statusCompletedBackground,
    Color? statusCompletedText,
    Color? statusOverdueBackground,
    Color? statusOverdueText,
  }) {
    return AppColors(
      sidebar: sidebar ?? this.sidebar,
      sidebarBorder: sidebarBorder ?? this.sidebarBorder,
      sidebarHover: sidebarHover ?? this.sidebarHover,
      sidebarInactive: sidebarInactive ?? this.sidebarInactive,
      sidebarSelected: sidebarSelected ?? this.sidebarSelected,
      sidebarIndicator: sidebarIndicator ?? this.sidebarIndicator,
      primaryHover: primaryHover ?? this.primaryHover,
      textOnPage: textOnPage ?? this.textOnPage,
      secondaryTextOnPage: secondaryTextOnPage ?? this.secondaryTextOnPage,
      overlayBackground: overlayBackground ?? this.overlayBackground,
      dialogBorder: dialogBorder ?? this.dialogBorder,
      textFieldFill: textFieldFill ?? this.textFieldFill,
      textFieldBorder: textFieldBorder ?? this.textFieldBorder,
      progressTrack: progressTrack ?? this.progressTrack,
      progressFill: progressFill ?? this.progressFill,
      chipBackground: chipBackground ?? this.chipBackground,
      chipText: chipText ?? this.chipText,
      statusToDoBackground: statusToDoBackground ?? this.statusToDoBackground,
      statusToDoText: statusToDoText ?? this.statusToDoText,
      statusInProgressBackground:
          statusInProgressBackground ?? this.statusInProgressBackground,
      statusInProgressText: statusInProgressText ?? this.statusInProgressText,
      statusBlockedBackground:
          statusBlockedBackground ?? this.statusBlockedBackground,
      statusBlockedText: statusBlockedText ?? this.statusBlockedText,
      statusCompletedBackground:
          statusCompletedBackground ?? this.statusCompletedBackground,
      statusCompletedText: statusCompletedText ?? this.statusCompletedText,
      statusOverdueBackground:
          statusOverdueBackground ?? this.statusOverdueBackground,
      statusOverdueText: statusOverdueText ?? this.statusOverdueText,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      sidebar: Color.lerp(sidebar, other.sidebar, t)!,
      sidebarBorder: Color.lerp(sidebarBorder, other.sidebarBorder, t)!,
      sidebarHover: Color.lerp(sidebarHover, other.sidebarHover, t)!,
      sidebarInactive: Color.lerp(sidebarInactive, other.sidebarInactive, t)!,
      sidebarSelected: Color.lerp(sidebarSelected, other.sidebarSelected, t)!,
      sidebarIndicator: Color.lerp(
        sidebarIndicator,
        other.sidebarIndicator,
        t,
      )!,
      primaryHover: Color.lerp(primaryHover, other.primaryHover, t)!,
      textOnPage: Color.lerp(textOnPage, other.textOnPage, t)!,
      secondaryTextOnPage: Color.lerp(
        secondaryTextOnPage,
        other.secondaryTextOnPage,
        t,
      )!,
      overlayBackground: Color.lerp(
        overlayBackground,
        other.overlayBackground,
        t,
      )!,
      dialogBorder: Color.lerp(dialogBorder, other.dialogBorder, t)!,
      textFieldFill: Color.lerp(textFieldFill, other.textFieldFill, t)!,
      textFieldBorder: Color.lerp(textFieldBorder, other.textFieldBorder, t)!,
      progressTrack: Color.lerp(progressTrack, other.progressTrack, t)!,
      progressFill: Color.lerp(progressFill, other.progressFill, t)!,
      chipBackground: Color.lerp(chipBackground, other.chipBackground, t)!,
      chipText: Color.lerp(chipText, other.chipText, t)!,
      statusToDoBackground: Color.lerp(
        statusToDoBackground,
        other.statusToDoBackground,
        t,
      )!,
      statusToDoText: Color.lerp(statusToDoText, other.statusToDoText, t)!,
      statusInProgressBackground: Color.lerp(
        statusInProgressBackground,
        other.statusInProgressBackground,
        t,
      )!,
      statusInProgressText: Color.lerp(
        statusInProgressText,
        other.statusInProgressText,
        t,
      )!,
      statusBlockedBackground: Color.lerp(
        statusBlockedBackground,
        other.statusBlockedBackground,
        t,
      )!,
      statusBlockedText: Color.lerp(
        statusBlockedText,
        other.statusBlockedText,
        t,
      )!,
      statusCompletedBackground: Color.lerp(
        statusCompletedBackground,
        other.statusCompletedBackground,
        t,
      )!,
      statusCompletedText: Color.lerp(
        statusCompletedText,
        other.statusCompletedText,
        t,
      )!,
      statusOverdueBackground: Color.lerp(
        statusOverdueBackground,
        other.statusOverdueBackground,
        t,
      )!,
      statusOverdueText: Color.lerp(
        statusOverdueText,
        other.statusOverdueText,
        t,
      )!,
    );
  }
}

/// Convenience accessor: `Theme.of(context).appColors`.
extension AppColorsX on ThemeData {
  AppColors get appColors => extension<AppColors>()!;
}

/// Draws a single 1px line along the bottom edge only, used to give the
/// AppBar (and the sidebar's inner edge) a border without adding one on all
/// four sides.
class _EdgeBorderShape extends ShapeBorder {
  const _EdgeBorderShape({required this.color, this.width = 1});

  final Color color;
  final double width;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only(bottom: width);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      Path()..addRect(rect.deflate(width));

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) =>
      Path()..addRect(rect);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = width;
    canvas.drawLine(
      Offset(rect.left, rect.bottom - width / 2),
      Offset(rect.right, rect.bottom - width / 2),
      paint,
    );
  }

  @override
  ShapeBorder scale(double t) =>
      _EdgeBorderShape(color: color, width: width * t);
}

class AppTheme {
  AppTheme._();

  static final lightTheme = _build(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: AppPalette.slateMid,
      onPrimary: Colors.white,
      secondary: AppPalette.slateSoft,
      onSecondary: AppPalette.slateDarkest,
      surface: Colors.white,
      onSurface: AppPalette.slateDarkest,
      onSurfaceVariant: AppPalette.slateMid,
      outline: AppPalette.slateLight,
      outlineVariant: AppPalette.slateLight,
      error: Color(0xFFB91C1C),
      onError: Colors.white,
      errorContainer: Color(0xFFFEE2E2),
      onErrorContainer: Color(0xFFB91C1C),
    ),
    scaffoldBackground: AppPalette.pageBackgroundLight,
    appColors: AppColors.light,
  );

  static final darkTheme = _build(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: AppPalette.slateLight,
      onPrimary: AppPalette.slateDarkest,
      secondary: AppPalette.slateSoft,
      onSecondary: AppPalette.slateDarkest,
      surface: AppPalette.slateDarkest,
      onSurface: AppPalette.slateLight,
      onSurfaceVariant: AppPalette.slateSoft,
      outline: AppPalette.slateDarkest,
      outlineVariant: AppPalette.slateDarkest,
      error: Color(0xFFFFC9BF),
      onError: Color(0xFF6A3630),
      errorContainer: Color(0xFF6A3630),
      onErrorContainer: Color(0xFFFFC9BF),
    ),
    scaffoldBackground: AppPalette.slateMid,
    appColors: AppColors.dark,
  );

  static ThemeData _build({
    required Brightness brightness,
    required ColorScheme colorScheme,
    required Color scaffoldBackground,
    required AppColors appColors,
  }) {
    // Every elevation shadow below is pinned to a slate-blue shade instead
    // of the Material default black, so dark mode never shows a black or
    // near-black shadow, dialog, or dropdown.
    const shadow = AppPalette.slateDarkest;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBackground,
      shadowColor: shadow,
      // Top bar is fixed chrome — identical in light and dark mode.
      appBarTheme: AppBarTheme(
        backgroundColor: appColors.sidebar,
        foregroundColor: appColors.sidebarSelected,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        shape: _EdgeBorderShape(color: appColors.sidebarBorder),
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        shadowColor: shadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: colorScheme.outline),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: appColors.overlayBackground,
        surfaceTintColor: Colors.transparent,
        shadowColor: shadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
          side: BorderSide(color: appColors.dialogBorder),
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: appColors.overlayBackground,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: appColors.dialogBorder),
        ),
      ),
      menuTheme: MenuThemeData(
        style: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(appColors.overlayBackground),
          surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
          side: WidgetStatePropertyAll(
            BorderSide(color: appColors.dialogBorder),
          ),
        ),
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(appColors.overlayBackground),
          surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
          side: WidgetStatePropertyAll(
            BorderSide(color: appColors.dialogBorder),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: appColors.textFieldFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: appColors.textFieldBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: appColors.textFieldBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: appColors.progressFill,
        linearTrackColor: appColors.progressTrack,
        circularTrackColor: appColors.progressTrack,
      ),
      // Sidebar/nav chrome is fixed — identical in light and dark mode.
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: appColors.sidebar,
        indicatorColor: appColors.sidebarIndicator,
        selectedIconTheme: IconThemeData(color: appColors.sidebarSelected),
        selectedLabelTextStyle: TextStyle(color: appColors.sidebarSelected),
        unselectedIconTheme: IconThemeData(color: appColors.sidebarInactive),
        unselectedLabelTextStyle: TextStyle(color: appColors.sidebarInactive),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: appColors.sidebar,
        indicatorColor: appColors.sidebarIndicator,
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? appColors.sidebarSelected
                : appColors.sidebarInactive,
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => TextStyle(
            color: states.contains(WidgetState.selected)
                ? appColors.sidebarSelected
                : appColors.sidebarInactive,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(colorScheme.onPrimary),
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.hovered)
                ? appColors.primaryHover
                : colorScheme.primary,
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(colorScheme.onPrimary),
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.hovered)
                ? appColors.primaryHover
                : colorScheme.primary,
          ),
        ),
      ),
      extensions: [appColors],
    );
  }
}
