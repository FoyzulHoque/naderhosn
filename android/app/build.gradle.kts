plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.naderhosn" // Replace with your actual application ID
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        applicationId = "com.example.naderhosn" // Replace with your actual application ID
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("debug") {
            keyAlias = "androiddebugkey"
            keyPassword = "android"
            storeFile = file("debug.keystore") // Adjust path if needed
            storePassword = "android"
        }
        // Add release signing config if needed, e.g.:
        // create("release") {
        //     keyAlias = System.getenv("KEY_ALIAS")
        //     keyPassword = System.getenv("KEY_PASSWORD")
        //     storeFile = file(System.getenv("KEYSTORE_PATH"))
        //     storePassword = System.getenv("STORE_PASSWORD")
        // }
    }

    buildTypes {
        getByName("release") {
            isMinifyEnabled = true // Enable R8 minification
            // useProguard is not needed; R8 is the default with ProGuard rules
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
            signingConfig = signingConfigs.getByName("debug") // Use release config if available
        }
    }
}

flutter {
    source = "../.."
}