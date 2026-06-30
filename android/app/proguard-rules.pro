# Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Gson / JSON (Dio responses)
-keepattributes Signature
-keepattributes *Annotation*
-dontwarn sun.misc.**

# Firebase
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# Secure storage
-keep class com.it_nomads.fluttersecurestorage.** { *; }
