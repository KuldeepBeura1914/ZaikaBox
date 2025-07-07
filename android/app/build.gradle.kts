plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.zaika_box"
    compileSdk = 35         // <-- Changed from 34 to 35
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.zaika_box"
        minSdk = 31  // <-- Set here (instead of outside in the android block)
        targetSdk = 35       // <-- Changed from 34 to 35
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}
dependencies {
    implementation("androidx.core:core-splashscreen:1.0.0-beta01") // Splash Screen dependency
    implementation("com.google.android.material:material:1.5.0") // Material Components dependency
    implementation("org.jetbrains.kotlin:kotlin-stdlib:1.5.21") // Kotlin standard library dependency
    implementation("androidx.appcompat:appcompat:1.3.1") // AppCompat library for backward compatibility
    implementation("com.google.firebase:firebase-auth:21.0.1") // Firebase Auth
    implementation("com.google.firebase:firebase-firestore:24.0.0") // Firebase Firestore
    // Add other dependencies as necessary
}
