import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("dev") {
            dimension = "flavor-type"
            applicationId = "com.solid.principle.dev"
            resValue(type = "string", name = "app_name", value = "AMK Dev")
        }
        create("staging") {
            dimension = "flavor-type"
            applicationId = "com.solid.principle.staging"
            resValue(type = "string", name = "app_name", value = "AMK Staging")
        }
        create("prod") {
            dimension = "flavor-type"
            applicationId = "com.solid.principle"
            resValue(type = "string", name = "app_name", value = "AMK Prod")
        }
    }
}