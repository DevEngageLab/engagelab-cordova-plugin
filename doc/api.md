# API description

## Register the sdk callback event

### MTPushEngagelab.onMTCommonReceiver （Both android/ios support）

Register the sdk callback event

#### Parameter Description
- dataAll:Returned event data
  - dataAll.event_name:  event type
    - android:
      - "onNotificationStatus":callback for application notification switch status , the content type is boolean, true means open, false means closed
      - "onConnectStatus":callback for tcp connection status , content type is boolean, true means connected
      - "onNotificationArrived": Notification delivery callback, the content is the notification message body
      - "onNotificationClicked":Notification click callback, the content is the notification message body
      - "onNotificationDeleted":Notification deletion callback, the content is the notification message body
      - "onCustomMessage":Custom message callback, the content is the custom message body
      - "onPlatformToken":Manufacturer token message callback, the content is the manufacturer token message body
    - ios:
      - "willPresentNotification":Callback for notification arrival, the content is the notification message body
      - "didReceiveNotificationResponse":Notification click callback, the content is the notification message body
      - "networkDidReceiveMessage":The callback of the custom message, the content is the message body of the custom message
  - dataAll.event_data: content


#### example

```js
document.addEventListener('MTPushEngagelab.onMTCommonReceiver', function (dataAll) {
  $("#notificationType").html(dataAll.event_name);
  $("#messageResult").html(JSON.stringify(dataAll.event_data));
  $("#messageResultAll").html("<br/>"+$("#messageResultAll").text() +"<br/>"+ JSON.stringify(dataAll));
}, false)
```

## Setup

### init （both android/ios support）

Initialize sdk

#### Interface definition

```js
window.cordova.plugins.MTPushEngagelab.init();
```

## Turn on Debug mode

### configDebugMode （both android/ios support）

Set whether to turn on debug mode. When debug mode is turned on, a detailed log will be printed.

#### Interface definition

```js
window.cordova.plugins.MTPushEngagelab.configDebugMode(enable)
```

#### Parameter Description

- enable: Whether to turn on debugging mode, true means debugging mode, false does not

#### code example

```js
window.cordova.plugins.MTPushEngagelab.configDebugMode(true)
```

## Turn on voice broadcast

### setEnablePushTextToSpeech （both android/ios support）

To set whether to enable voice broadcast.

android: you just need to call this api.

iOS：you also need to call setAppGroupId: and some other configuration is required in the native project. 
1. You should [enable AppGroups capability](https://www.engagelab.com/docs/app-push/client-sdk-reference/ios-sdk/ios-certificate-setting-guide#enable-appgroups-capability)
2. Create a new Target and select Notification Service Extension. You can define the Target name yourself.
3. In the main project, select Signing&Capabilities, click +Capablitity, and select App Groups. Then select the + sign in the App Groups item and configure your appGroupId.
4. In Notification Service Extension, repeat the steps in step 3.
5. In Notification Service Extension,You need to configure a few lines of code. Please check [voice-broadcasting-feature](https://www.engagelab.com/docs/app-push/client-sdk-reference/ios-sdk/sdk-api-guide#voice-broadcasting-feature-1) for details.

#### Interface definition

```js
// android
window.cordova.plugins.MTPushEngagelab.setEnablePushTextToSpeech(enable)

// ios
window.cordova.plugins.MTPushEngagelab.setAppGroupId("your app group id");
window.cordova.plugins.MTPushEngagelab.setEnablePushTextToSpeech(enable)
```

#### Parameter Description

- enable: true means open, false means close, the default is false

#### code example

```js
window.cordova.plugins.MTPushEngagelab.configDebugMode(true)
```

## Get RegistrationID （both android/ios support）

### getRegistrationId

RegistrationID :
Get the registrationId of the current device, which can be used for push

#### Interface definition

```js
window.cordova.plugins.MTPushEngagelab.getRegistrationId(successCallback)
```

#### return value

Call this API to get the RegistrationID which returned by the Engagelab server only if the application is successfully registered, otherwise an empty string is returned.

#### code example

```js
window.cordova.plugins.MTPushEngagelab.getRegistrationId(function(rId) {
  console.log("MTPushEngagelab:registrationID is " + rId)
})
```
