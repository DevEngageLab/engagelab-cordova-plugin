# engagelab-cordova-plugin
cordova plugin for push SDK
## Install

- 直接通过 url 安装：

  ```shell
  cordova plugin add https://github.com/DevEngageLab/engagelab-cordova-plugin.git --variable ENGAGELAB_PRIVATES_APPKEY=your_APPKEY  --variable VIVO_APPID=  --variable VIVO_APPKEY=  --variable OPPO_APPID=  --variable OPPO_APPKEY=  --variable OPPO_APPSECRET=  --variable MEIZU_APPID=  --variable MEIZU_APPKEY=  --variable XIAOMI_GLOBAL_APPID=  --variable XIAOMI_GLOBAL_APPKEY=  --variable HONOR_APPID=
  ```

- 或下载到本地安装：

  ```shell
  cordova plugin add Your_Plugin_Path --variable ENGAGELAB_PRIVATES_APPKEY=your_APPKEY  --variable VIVO_APPID=  --variable VIVO_APPKEY=  --variable OPPO_APPID=  --variable OPPO_APPKEY=  --variable OPPO_APPSECRET=  --variable MEIZU_APPID=  --variable MEIZU_APPKEY=  --variable XIAOMI_GLOBAL_APPID=  --variable XIAOMI_GLOBAL_APPKEY=  --variable HONOR_APPID=
  ```


### 参数

- ENGAGELAB_PRIVATES_APPKEY: 必须设置，ENGAGELAB 上注册的包名对应的 Appkey

  ```shell
  --variable ENGAGELAB_PRIVATES_APPKEY=your_APPKEY
  ```
  
- HUAWEI厂商 : 必须设置，对应agconnect-services.json里的app_id如果没有可填空.
  ```shell
  --variable HUAWEI_APP_ID=
  ```
  
- VIVO厂商 : 必须设置，如果没有可填空.

  ```shell
  --variable VIVO_APPID=
  --variable VIVO_APPKEY=
  ```
  
- OPPO厂商 : 必须设置，如果没有可填空.

  ```shell
  --variable OPPO_APPID=
  --variable OPPO_APPKEY=
  --variable OPPO_APPSECRET=
  ```
  
- MEIZU厂商 : 必须设置，如果没有可填空.
  ```shell
  --variable MEIZU_APPID=
  --variable MEIZU_APPKEY=
  ```

- XIAOMI厂商 : 必须设置，如果没有可填空.
  ```shell
  --variable XIAOMI_GLOBAL_APPID=
  --variable XIAOMI_GLOBAL_APPKEY=
  ```
- 荣耀厂商 : 必须设置，如果没有可填空.
  ```shell
  --variable HONOR_APPID=
  ```

- ENGAGELAB_PRIVATES_CHANNEL: 可以不设置，默认为 developer-default.

  ```shell
  --variable ENGAGELAB_PRIVATES_CHANNEL=your_channel
  ```

- ENGAGELAB_PRIVATES_PROCESS: 可以不设置，默认为 :remote.

  ```shell
  --variable ENGAGELAB_PRIVATES_PROCESS=:your_process
  ```
  
### 特殊处理（android）
- goole厂商 : 
  - 如果需要，手动复制google-services.json文件到项目app下，如果没有可不处理.
  - 在项目build.gradle文件dependencies下添加：
  ```shell
  buildscript {
    dependencies {
        classpath 'com.google.gms:google-services:4.3.8'
    }
  }
  ```
  - 在项目app下的build.gradle文件dependencies下添加：
  ```shell
    // google push need
    apply plugin:  'com.google.gms.google-services'
  ```
  
  - 在项目repositories.gradle文件下添加：
  ```shell
     google()
     mavenCentral()
  ```
- 华为厂商 : 
  - 如果需要，手动复制agconnect-services.json文件到项目app下，如果没有可不处理.
  - 在项目build.gradle文件dependencies下添加：
  ```shell
  buildscript {
    dependencies {
        classpath 'com.huawei.agconnect:agcp:1.6.0.300'
    }
  }
  ```
  - 在项目app下的build.gradle文件dependencies下添加：
  ```shell
    // huawei push need
    apply plugin:  'com.huawei.agconnect'
  ```
  
  - 在项目repositories.gradle文件下添加：
  ```shell
     google()
     mavenCentral()
     maven { url 'https://developer.huawei.com/repo/' }
  ```

### 安卓设置tcp_sll、debug、fcm 国内测试 需要做以下配置
 * 1. 将 插件 src/android/MTPushApplication.java文件拖入到项目插件文件中, 找到MTPushEngagelab.java文件，放在与其同级的位置。
 * 2. 将 插件 example/mt_engagelab_cordova_push_config 文件拖入到项目 src/main/assets 文件夹中。
 * 3. 在 src/main/assets/ 下添加 mt_engagelab_cordova_push_config 文件（可查看example文件夹下的 mt_engagelab_cordova_push_config 文件）
 * mt_engagelab_cordova_push_config 文件内容：
  {
  "tcp_ssl": true,
  "debug":true,
  "testConfigGoogle":false // 在正式环境请请将其设置为false, 国内测试fcm请设置为true.
  }
 * 4. 在AndroidManifest.xml的application中添加android:name="com.engagelab.push.MTPushApplication"

## Usage

### API

- [Api](/doc/api.md)