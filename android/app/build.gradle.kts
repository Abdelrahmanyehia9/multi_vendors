import java.util.Properties
import java.io.FileInputStream

// =======================
// Load keystore properties
// =======================
val keyPropertiesFile = rootProject.file("key.properties")
val keyProperties = Properties()

if (keyPropertiesFile.exists()) {
    keyPropertiesFile.inputStream().use { keyProperties.load(it) }
} else {
    throw GradleException("key.properties file not found! Cannot build release.")
}
// =======================
// Plugins
// =======================
plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

// =======================
// Android config
// =======================
android {
    namespace = "com.nexyra.avera"
    compileSdk = 36
    ndkVersion = "28.2.13676358"

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    // =======================
    // Signing Config (Release)
    // =======================
    signingConfigs {
        create("release") {
            keyAlias = keyProperties.getProperty("keyAlias")
            keyPassword = keyProperties.getProperty("keyPassword")
            storeFile = file(keyProperties.getProperty("storeFile"))
            storePassword = keyProperties.getProperty("storePassword")
        }
    }

    // =======================
    // Default Config
    // =======================
    defaultConfig {
        applicationId = "com.nexyra.avera"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true
    }

    // =======================
    // Build Types
    // =======================
    buildTypes {
        debug {
            signingConfig = signingConfigs.getByName("debug")
            isDebuggable = true
            isMinifyEnabled = false
            isShrinkResources = false
        }

        release {
            signingConfig = signingConfigs.getByName("release")
            isDebuggable = false
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }

    // =======================
    // Flavors
    // =======================
    flavorDimensions += "default"

    productFlavors {
        create("dev") {
            dimension = "default"
            applicationIdSuffix = ".development"
            versionNameSuffix = "-dev"
        }

        create("prod") {
            dimension = "default"
        }
    }

    // =======================
    // Bundle config (Play Store)
    // =======================
    bundle {
        language { enableSplit = true }
        density { enableSplit = true }
        abi { enableSplit = true }
    }
}

// =======================
// Dependencies
// =======================
dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}

// =======================
// Flutter
// =======================
flutter {
    source = "../.."
}