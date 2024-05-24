import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

part 'color_scheme.dart';
part 'extensions.dart';

ThemeData appTheme(
  BuildContext context, {
  required ColorScheme colorScheme,
  required SystemUiOverlayStyle systemUiOverlayStyle,
}) {
  final baseTheme = ThemeData(brightness: colorScheme.brightness);
  return ThemeData.from(
    colorScheme: colorScheme,
    useMaterial3: true,
  ).copyWith(
    textTheme: GoogleFonts.robotoSlabTextTheme(baseTheme.textTheme),
    appBarTheme: _appBarTheme(systemUiOverlayStyle, context),
    elevatedButtonTheme: _elevateButtonThemeData(context, colorScheme),
    floatingActionButtonTheme: _floatingActionButtonThemeDate(colorScheme),
    tabBarTheme: _tabBarTheme(context, colorScheme),
    bottomSheetTheme: _bottomSheetThemeData(colorScheme),
    navigationBarTheme: _navigationBarTheme(colorScheme),
  );
}

BottomSheetThemeData _bottomSheetThemeData(ColorScheme colorScheme) {
  return BottomSheetThemeData(
    showDragHandle: true,
    modalBackgroundColor: colorScheme.onInverseSurface,
    elevation: 5,
    modalElevation: 5,
  );
}

NavigationBarThemeData _navigationBarTheme(ColorScheme colorScheme) {
  return NavigationBarThemeData(
    elevation: 5,
    backgroundColor: colorScheme.onInverseSurface,
  );
}

TabBarTheme _tabBarTheme(BuildContext context, ColorScheme colorScheme) {
  return TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    labelStyle: context.appBarTitleStyle!.copyWith(
      fontSize: 16,
      color: colorScheme.onSecondaryContainer,
    ),
    unselectedLabelStyle: context.appBarTitleStyle!.copyWith(
      fontSize: 16,
      color: colorScheme.onSecondaryContainer,
    ),
    indicatorColor: colorScheme.onSecondaryContainer,
  );
}

FloatingActionButtonThemeData _floatingActionButtonThemeDate(
  ColorScheme colorScheme,
) {
  return FloatingActionButtonThemeData(
    backgroundColor: colorScheme.secondaryContainer,
  );
}

AppBarTheme _appBarTheme(
  SystemUiOverlayStyle systemUiOverlayStyle,
  BuildContext context,
) {
  return AppBarTheme(
    //titleTextStyle: context.appBarTitleStyle,
    centerTitle: false,
    systemOverlayStyle: systemUiOverlayStyle.copyWith(
      statusBarColor: Colors.transparent,
    ),
  );
}

ElevatedButtonThemeData _elevateButtonThemeData(
  BuildContext context,
  ColorScheme colorScheme,
) {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      fixedSize: const Size(double.maxFinite, 50),
      textStyle: context.titleSmall,
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
    ),
  );
}
