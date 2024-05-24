part of 'theme_manager.dart';

extension ColorHelper on BuildContext {
  Brightness get brightness => Theme.of(this).brightness;

  bool get isDark => brightness == Brightness.dark;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  Color get outline => colorScheme.outline;

  Color get outlineVariant => colorScheme.outlineVariant;

  Color get primary => colorScheme.primary;

  Color get onPrimary => colorScheme.onPrimary;

  Color get primaryContainer => colorScheme.primaryContainer;

  Color get onPrimaryContainer => colorScheme.onPrimaryContainer;

  Color get secondary => colorScheme.secondary;

  Color get onSecondary => colorScheme.onSecondary;

  Color get inverseSurface => colorScheme.inverseSurface;

  Color get onInverseSurface => colorScheme.onInverseSurface;

  Color get secondaryContainer => colorScheme.secondaryContainer;

  Color get onSecondaryContainer => colorScheme.onSecondaryContainer;

  Color get onTertiary => colorScheme.tertiary;

  Color get tertiary => colorScheme.onTertiary;

  Color get tertiaryContainer => colorScheme.tertiaryContainer;

  Color get onTertiaryContainer => colorScheme.onTertiaryContainer;

  Color get surfaceVariant => colorScheme.surfaceContainerHighest;

  Color get onSurfaceVariant => colorScheme.onSurfaceVariant;

  Color get surface => colorScheme.surface;

  Color get onSurface => colorScheme.onSurface;

  Color get surfaceTint => colorScheme.surfaceTint;

  Color get background => colorScheme.surface;

  Color get onBackground => colorScheme.onSurface;

  Color get error => colorScheme.error;

  Color get shadow => colorScheme.shadow;

  Color get errorContainer => colorScheme.errorContainer;

  Color get onError => colorScheme.onError;

  Color get onErrorContainer => colorScheme.onErrorContainer;
}

extension TextStyleHelper on BuildContext {
  TextStyle? get titleLarge =>
      Theme.of(this).textTheme.titleLarge?.copyWith(fontSize: 22);

  TextStyle? get titleMedium =>
      Theme.of(this).textTheme.titleMedium?.copyWith(fontSize: 16);

  TextStyle? get titleSmall =>
      Theme.of(this).textTheme.titleSmall?.copyWith(fontSize: 14);

  TextStyle? get bodySmall =>
      Theme.of(this).textTheme.bodySmall?.copyWith(fontSize: 12);

  TextStyle? get bodyMedium =>
      Theme.of(this).textTheme.bodyMedium?.copyWith(fontSize: 14);

  TextStyle? get bodyLarge =>
      Theme.of(this).textTheme.bodyLarge?.copyWith(fontSize: 16);

  TextStyle? get labelLarge =>
      Theme.of(this).textTheme.labelLarge?.copyWith(fontSize: 14);

  TextStyle? get labelMedium =>
      Theme.of(this).textTheme.labelMedium?.copyWith(fontSize: 12);

  TextStyle? get labelSmall =>
      Theme.of(this).textTheme.labelSmall?.copyWith(fontSize: 11);

  TextStyle? get displayLarge =>
      Theme.of(this).textTheme.displayLarge?.copyWith(fontSize: 57);

  TextStyle? get displayMedium =>
      Theme.of(this).textTheme.displayMedium?.copyWith(fontSize: 45);

  TextStyle? get displaySmall =>
      Theme.of(this).textTheme.displaySmall?.copyWith(fontSize: 36);

  TextStyle? get headlineLarge =>
      Theme.of(this).textTheme.headlineLarge?.copyWith(fontSize: 32);

  TextStyle? get headlineMedium =>
      Theme.of(this).textTheme.headlineMedium?.copyWith(fontSize: 28);

  TextStyle? get headlineSmall =>
      Theme.of(this).textTheme.headlineSmall?.copyWith(fontSize: 24);

  /// App Bar Title Style
  TextStyle? get appBarTitleStyle => titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 20,
      );

  /// Floating Action Button Text Style
  TextStyle? get floatingButtonTextStyle => bodySmall!.copyWith(
        color: onSurface,
      );

  TextStyle? get captionStyle => Theme.of(this).textTheme.bodySmall?.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      );

  TextStyle? get captionLightStyle =>
      Theme.of(this).textTheme.bodySmall?.copyWith(
            fontSize: 10,
          );
}
