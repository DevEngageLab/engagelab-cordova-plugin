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
      - "onCommandResult":Generic command result callback. Xiaomi channel subscription results are returned through this event
    - ios:
      - "willPresentNotification":Callback for notification arrival, the content is the notification message body
      - "didReceiveNotificationResponse":Notification click callback, the content is the notification message body
      - "networkDidReceiveMessage":The callback of the custom message, the content is the message body of the custom message
  - dataAll.event_data: content

For `onCommandResult`, `event_data` is a JSON string. A Xiaomi channel subscription result contains:

- `cmd`: Always `2012`
- `errorCode`: Xiaomi's overall result code. `0` means the dialog was displayed and the user's operation result was returned; it does not mean every channel was subscribed successfully
- `msg`: Result description; currently usually an empty string for this command
- `extra`: Fields returned by the Xiaomi SDK, plus `subscribe_code` (same as `errorCode`) and `platform` (`1` for Xiaomi)

`errorCode` values:

|Value|Description|
|:--:|---|
|`0`|The dialog was displayed and the user operation result was returned|
|`-100`|The current version does not support the feature|
|`-200`|Authentication failed|
|`-300`|The app is not in the foreground or the screen is off|
|`-400`|Another subscription request is being processed|
|`-500`|Xiaomi frequency control was triggered|
|`-600`|Invalid parameters|
|`-700`|The user cancelled|
|`-800`|Notification permission is unavailable|
|`-900`|Unknown error|
|`-10000`|Xiaomi Push registration has not completed|
|`-2147483648`|An exception occurred while calling the Xiaomi SDK|

When `errorCode` is `0`, `extra.open_channel_result`, when supplied by the Xiaomi system service, is a JSON string containing each channel's result. Per-channel `code` values are: `100` created successfully, `-100` creation failed, `-200` rejected by the user, `-300` already created and enabled, `-400` already created but disabled, and `-500` invalid channel.


#### example

```js
document.addEventListener('MTPushEngagelab.onMTCommonReceiver', function (dataAll) {
  $("#notificationType").html(dataAll.event_name);
  $("#messageResult").html(JSON.stringify(dataAll.event_data));
  $("#messageResultAll").html("<br/>"+$("#messageResultAll").text() +"<br/>"+ JSON.stringify(dataAll));
}, false)
```

## Subscribe to Xiaomi message channels (Android only)

### requestSubscribeChannelAndroid

Requests subscription to one or more Xiaomi message channels. This feature currently supports only the Xiaomi
channel. The result is returned as an `onCommandResult` event through
`MTPushEngagelab.onMTCommonReceiver`.
See the [EngageLab Android SDK requestSubscribeChannel documentation](https://www.engagelab.com/zh_CN/docs/app-push/developer-guide/client-sdk-reference/android-sdk/sdk-api-guide#requestsubscribechannel) for the native behavior and limits.

#### Interface definition

```js
window.cordova.plugins.MTPushEngagelab.requestSubscribeChannelAndroid(channelIds)
```

#### Parameters

- `channelIds`: `string[]`, subscription channel IDs created in the Xiaomi Push console. At most three IDs can be passed per call; Xiaomi discards additional entries

#### Frequency limits

- The subscription dialog can be requested at most once every 30 seconds
- The same channel can be requested at most twice per month; exceeding this limit returns `-500`

#### Code example

```js
document.addEventListener('MTPushEngagelab.onMTCommonReceiver', function (dataAll) {
  if (dataAll.event_name === 'onCommandResult') {
    const result = typeof dataAll.event_data === 'string'
      ? JSON.parse(dataAll.event_data)
      : dataAll.event_data;
    if (result.cmd === 2012) {
      console.log('Subscription result', result.errorCode, result.extra);
      if (result.errorCode === 0 && result.extra.open_channel_result) {
        console.log('Per-channel results', JSON.parse(result.extra.open_channel_result));
      }
    }
  }
}, false);

window.cordova.plugins.MTPushEngagelab.requestSubscribeChannelAndroid([
  'channel_id_1',
  'channel_id_2'
]);
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

## Data Collection Control (Android only)

### setCollectControl

Set data collection control parameters

#### Interface definition

```js
window.cordova.plugins.MTPushEngagelab.setCollectControl(control)
```

#### Parameters

- control: Object containing collection control parameters
  - gaid: Boolean - Whether to collect GAID (Google Advertising ID), default is true
  - aid: Boolean - Whether to collect AID (AndroidId), default is true

#### code example

```js
// Disable GAID and AID collection
window.cordova.plugins.MTPushEngagelab.setCollectControl({
  gaid: false,
  aid: false
});
```
