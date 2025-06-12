import 'package:advanced_app/core/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


ThemeData theme() {
  return ThemeData(
    brightness: Brightness.light,
    // fontFamily: 'BahijTheSansArabic',
    primaryColor: AppColors.primary,
    cardColor: Colors.white,
    canvasColor: const Color(0x29000000),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: appBarTheme(),
    radioTheme: radioTheme(),
    dialogTheme: dialogTheme(),
    textButtonTheme: textButtonTheme(),
    bottomSheetTheme: bottomSheetTheme(),
    dropdownMenuTheme: dropdownMenuTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    textTheme: ThemeData.light().textTheme,
    dividerTheme: DividerThemeData(
      color: Colors.grey.shade400,
      thickness: 1.sp,
    ),
    
    // Add other light theme properties
  );
}

InputDecorationTheme inputDecorationTheme() {
  return InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(
        horizontal: 8, vertical: 8),
    filled: true,
    fillColor: Colors.white,
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 1, color: Color(0xFFDCD5D5)),
      borderRadius: BorderRadius.circular(8),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 1, color: Color(0xFFDCD5D5)),
      borderRadius: BorderRadius.circular(12),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
          width: 2, color: Colors.black12), // Set focused border color
      borderRadius: BorderRadius.circular(12),
    ),
    border: OutlineInputBorder(
      borderSide:
          const BorderSide(width: 1, color: Color.fromARGB(255, 245, 125, 32)),
      borderRadius: BorderRadius.circular(12),
    ),
    labelStyle:
        //Theme.of(context).textTheme.bodyMedium!.apply(color:Colors.black45),
        const TextStyle(color: Colors.black45),
  );
}

TextButtonThemeData textButtonTheme() {
  return const TextButtonThemeData(
    style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(
      Color(0xFFF35F16),
    )),
  );
}

DialogTheme dialogTheme() {
  return DialogTheme(
    backgroundColor: ThemeData().scaffoldBackgroundColor,
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    backgroundColor: Colors.white,
    scrolledUnderElevation: 4.0, // Add some elevation when scrolled
    surfaceTintColor: Colors
        .transparent, // IMPORTANT: This prevents the color blend on scroll
    shadowColor: Colors.black26, // Shadow color
    elevation: 0,
    // centerTitle: true,
    titleTextStyle: TextStyle(
      color: Colors.black,
      // fontFamily: 'BahijTheSansArabicBold',
      fontSize: 18.sp,
      fontWeight: FontWeight.w400,
      height: 0,
    ),
  );
}

BottomSheetThemeData bottomSheetTheme() {
  return const BottomSheetThemeData(
    backgroundColor: Colors.white,
    elevation: 10.0,
    modalBackgroundColor: Color(0xFFF3F3F3),
    modalElevation: 10.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(12),
      ),
    ),
    dragHandleColor: Color(0xFFDCD5D5),
    dragHandleSize: Size(40, 4),
  );
}

DialogTheme enhancedDialogTheme() {
  return DialogTheme(
    backgroundColor: const Color(0xFFF3F3F3),
    elevation: 8.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    titleTextStyle: TextStyle(
      // fontFamily: 'BahijTheSansArabic',
      fontSize: 22.sp,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    contentTextStyle: TextStyle(
      // fontFamily: 'BahijTheSansArabic',
      fontSize: 18.sp,
      color: Colors.black87,
    ),
  );
}

DropdownMenuThemeData dropdownMenuTheme() {
  return DropdownMenuThemeData(
    // Menu styling
    menuStyle: MenuStyle(
      backgroundColor: const MaterialStatePropertyAll(Colors.white),
      elevation: const MaterialStatePropertyAll(4.0),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(width: 1, color: Color(0xFFDCD5D5)),
        ),
      ),
      padding:
          const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 8.0)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(
          horizontal: 8, vertical: 8),
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1, color: Color(0xFFDCD5D5)),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 2, color: Color(0xFFF35F16)),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    textStyle: const TextStyle(
      // fontFamily: 'BahijTheSansArabic',
      fontSize: 8,
      color: Colors.black,
    ),
  );
}

// For traditional DropdownButton styling using the correct class
ButtonThemeData buttonThemeForDropdowns() {
  return ButtonThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: const BorderSide(width: 1, color: Color(0xFFDCD5D5)),
    ),
    buttonColor: Colors.white,
    disabledColor: Colors.grey.shade200,
    alignedDropdown: true, // Makes dropdown items align with button
    colorScheme: const ColorScheme.light(
      primary: Color(0xFFF35F16),
    ),
  );
}

RadioThemeData radioTheme() {
  return RadioThemeData(
    fillColor: WidgetStateProperty.all<Color>(
      const Color(0xFFF35F16),
    ),
  );
}