import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

// Signing of release builds
// https://docs.flutter.dev/deployment/android#configure-signing-in-gradle
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion
    namespace = "fr.myecl.titan"

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "fr.myecl.titan"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties.getProperty("keyAlias")
            keyPassword = keystoreProperties.getProperty("keyPassword")
            storeFile = keystoreProperties.getProperty("storeFile")?.let { file(it) }
            storePassword = keystoreProperties.getProperty("storePassword")
        }
    }

    // Product flavors configuration
    // https://docs.flutter.dev/deployment/flavors#using-flavors-in-android
    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
        }
    }

    flavorDimensions += "default"


    productFlavors {
        create("prod") {
            dimension = "default"
            manifestPlaceholders.putAll(mapOf("appAuthRedirectScheme" to "fr.myecl.titan"))
        }
        create("alpha") {
            dimension = "default"
            applicationIdSuffix = ".alpha"
            manifestPlaceholders.putAll(mapOf("appAuthRedirectScheme" to "fr.myecl.titan.alpha"))
        }
        create("dev") {
            dimension = "default"
            applicationIdSuffix = ".dev"
            manifestPlaceholders.putAll(mapOf("appAuthRedirectScheme" to "fr.myecl.dev"))
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}