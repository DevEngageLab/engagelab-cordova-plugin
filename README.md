# engagelab-cordova-plugin
cordova plugin for push SDK
## Install

- Install directly via url:

  ```shell
  cordova plugin add https://github.com/DevEngageLab/engagelab-cordova-plugin.git --variable ENGAGELAB_PRIVATES_APPKEY=your_APPKEY  --variable VIVO_APPID=  --variable VIVO_APPKEY=  --variable OPPO_APPID=  --variable OPPO_APPKEY=  --variable OPPO_APPSECRET=  --variable MEIZU_APPID=  --variable MEIZU_APPKEY=  --variable XIAOMI_GLOBAL_APPID=  --variable XIAOMI_GLOBAL_APPKEY=  --variable HONOR_APPID= --variable XIAOMI_APPID=  --variable XIAOMI_APPKEY=
  ```

- Or download to local for local installation：

  ```shell
  cordova plugin add Your_Plugin_Path --variable ENGAGELAB_PRIVATES_APPKEY=your_APPKEY  --variable VIVO_APPID=  --variable VIVO_APPKEY=  --variable OPPO_APPID=  --variable OPPO_APPKEY=  --variable OPPO_APPSECRET=  --variable MEIZU_APPID=  --variable MEIZU_APPKEY=  --variable XIAOMI_GLOBAL_APPID=  --variable XIAOMI_GLOBAL_APPKEY=  --variable HONOR_APPID= --variable XIAOMI_APPID=  --variable XIAOMI_APPKEY=
  ```

### parameter

- ENGAGELAB_PRIVATES_APPKEY: required，the Appkey corresponding to the package name registered on ENGAGELAB

  ```shell
  --variable ENGAGELAB_PRIVATES_APPKEY=your_APPKEY
  ```
  
- HUAWEI Manufacturer: Must be set,Corresponds to the app_id in agconnect-services.json. If there is no app_id, fill in the blank.
  ```shell
  --variable HUAWEI_APP_ID=
  ```
  
- VIVO Manufacturer : Must be set, if not available, fill in the blank

  ```shell
  --variable VIVO_APPID=
  --variable VIVO_APPKEY=
  ```
  
- OPPO Manufacturer : Must be set, if not available, fill in the blank

  ```shell
  --variable OPPO_APPID=
  --variable OPPO_APPKEY=
  --variable OPPO_APPSECRET=
  ```
  
- MEIZU Manufacturer : Must be set, if not available, fill in the blank
  ```shell
  --variable MEIZU_APPID=
  --variable MEIZU_APPKEY=
  ```

- XIAOMI Global Manufacturer : Must be set, if not available, fill in the blank
  ```shell
  --variable XIAOMI_GLOBAL_APPID=
  --variable XIAOMI_GLOBAL_APPKEY=
  ```

- XIAOMI Manufacturer : Must be set, if not available, fill in the blank
  ```shell
  --variable XIAOMI_APPID=
  --variable XIAOMI_APPKEY=
  ```

- Honor Manufacturer : Must be set, if not available, fill in the blank
  ```shell
  --variable HONOR_APPID=
  ```

- ENGAGELAB_PRIVATES_CHANNEL: Optional，the default value is `developer-default`.

  ```shell
  --variable ENGAGELAB_PRIVATES_CHANNEL=your_channel
  ```

- ENGAGELAB_PRIVATES_PROCESS: Optional，the default value is `:remote`.

  ```shell
  --variable ENGAGELAB_PRIVATES_PROCESS=:your_process
  ```
  
### Note（android）
- goole Manufacturer : 
  - If necessary, manually copy the google-services.json file to the project's `app` folder. If it does not exist, do not process it.
  - Add under dependencies in the project build.gradle file:
  
  ```shell
  buildscript {
    dependencies {
        classpath 'com.google.gms:google-services:4.3.8'
    }
  }
  ```
  - Add under dependencies in the `build.gradle` file under the project's `app` folder:
  
  ```shell
    // google push need
    apply plugin:  'com.google.gms.google-services'
  ```
  
  - Add under the project repositories.gradle file:
  
  ```shell
     google()
     mavenCentral()
  ```
- Huawei manufacturer : 
  - If necessary, manually copy the agconnect-services.json file to the project's `app` floder. If it does not exist, do not process it.
  - Add under dependencies in the project's build.gradle file:
  
  ```shell
  buildscript {
    dependencies {
        classpath 'com.huawei.agconnect:agcp:1.6.0.300'
    }
  }
  ```
  - Add under dependencies the build.gradle file in the project's `app` folder:
  ```shell
    // huawei push need
    apply plugin:  'com.huawei.agconnect'
  ```
  
  - Add the following code under the project's `repositories.gradle` file:
  ```shell
     google()
     mavenCentral()
     maven { url 'https://developer.huawei.com/repo/' }
  ```


## Usage

### API

- [Api](/doc/api.md)
