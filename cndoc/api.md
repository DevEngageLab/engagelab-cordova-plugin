# API 说明

## 注册监听

### MTPushEngagelab.onMTCommonReceiver （android/ios都支持）

集成了 sdk 回调的事件

#### 参数说明
- dataAll:反回的事件数据
  - dataAll.event_name: 为事件类型
    - android:
      - "onNotificationStatus":应用通知开关状态回调,内容类型为boolean，true为打开，false为关闭
      - "onConnectStatus":长连接状态回调,内容类型为boolean，true为连接
      - "onNotificationArrived":通知消息到达回调，内容为通知消息体
      - "onNotificationClicked":通知消息点击回调，内容为通知消息体
      - "onNotificationDeleted":通知消息删除回调，内容为通知消息体
      - "onCustomMessage":自定义消息回调，内容为通知消息体
      - "onPlatformToken":厂商token消息回调，内容为厂商token消息体
      - "onCommandResult":通用命令结果回调，小米消息频道订阅结果通过该事件返回
    - ios:
      - "willPresentNotification":通知消息到达回调，内容为通知消息体
      - "didReceiveNotificationResponse":通知消息点击回调，内容为通知消息体
      - "networkDidReceiveMessage":自定义消息回调，内容为通知消息体
  - dataAll.event_data: 为对应内容

`onCommandResult` 的 `event_data` 为 JSON 字符串。小米消息频道订阅对应的返回值如下：

- `cmd`: 固定为 `2012`
- `errorCode`: 小米整体结果码。`0` 仅表示订阅弹窗正常展示并返回了用户操作结果，不代表每个频道都订阅成功
- `msg`: 结果描述；当前订阅命令通常为空字符串
- `extra`: 小米 SDK 返回的扩展字段，并包含 `subscribe_code`（与 `errorCode` 一致）和 `platform`（小米为 `1`）

`errorCode` 说明：

|值|说明|
|:--:|---|
|`0`|弹窗正常展示，用户操作结果已返回|
|`-100`|当前版本不支持|
|`-200`|鉴权失败|
|`-300`|应用不在前台或设备未亮屏|
|`-400`|正在处理其他订阅请求|
|`-500`|触发小米频控|
|`-600`|参数无效|
|`-700`|用户取消|
|`-800`|没有通知权限|
|`-900`|未知异常|
|`-10000`|小米推送尚未完成注册|
|`-2147483648`|调用小米 SDK 异常|

当 `errorCode` 为 `0` 时，`extra.open_channel_result`（如果小米系统服务返回该字段）是各频道操作结果的 JSON 字符串。单频道 `code`：`100` 创建成功、`-100` 创建失败、`-200` 用户拒绝、`-300` 已创建且开启、`-400` 已创建但关闭、`-500` 频道无效。


#### 代码示例

```js
document.addEventListener('MTPushEngagelab.onMTCommonReceiver', function (dataAll) {
  $("#notificationType").html(dataAll.event_name);
  $("#messageResult").html(JSON.stringify(dataAll.event_data));
  $("#messageResultAll").html("<br/>"+$("#messageResultAll").text() +"<br/>"+ JSON.stringify(dataAll));
}, false)
```

## 订阅小米消息频道（仅 Android）

### requestSubscribeChannelAndroid

请求订阅一个或多个小米消息频道。该能力目前仅支持小米通道，调用结果通过
`MTPushEngagelab.onMTCommonReceiver` 的 `onCommandResult` 事件返回。
原生行为及限制参考 [EngageLab Android SDK requestSubscribeChannel](https://www.engagelab.com/zh_CN/docs/app-push/developer-guide/client-sdk-reference/android-sdk/sdk-api-guide#requestsubscribechannel)。

#### 接口定义

```js
window.cordova.plugins.MTPushEngagelab.requestSubscribeChannelAndroid(channelIds)
```

#### 参数说明

- `channelIds`: `string[]`，小米推送后台申请的订阅类频道 ID 列表。单次最多传入 3 个，超出部分由小米 SDK 丢弃

#### 频控限制

- 订阅弹窗 30 秒内最多请求一次
- 同一频道一个月内最多请求两次，达到上限时返回 `-500`

#### 代码示例

```js
document.addEventListener('MTPushEngagelab.onMTCommonReceiver', function (dataAll) {
  if (dataAll.event_name === 'onCommandResult') {
    const result = typeof dataAll.event_data === 'string'
      ? JSON.parse(dataAll.event_data)
      : dataAll.event_data;
    if (result.cmd === 2012) {
      console.log('订阅结果', result.errorCode, result.extra);
      if (result.errorCode === 0 && result.extra.open_channel_result) {
        console.log('各频道结果', JSON.parse(result.extra.open_channel_result));
      }
    }
  }
}, false);

window.cordova.plugins.MTPushEngagelab.requestSubscribeChannelAndroid([
  'channel_id_1',
  'channel_id_2'
]);
```

## 初始化

### init （android/ios都支持）

初始化sdk

#### 接口定义

```js
window.cordova.plugins.MTPushEngagelab.init();
```

## 开启 Debug 模式

### configDebugMode （android/ios都支持）

设置是否debug模式，debug模式会打印更对详细日志

#### 接口定义

```js
window.cordova.plugins.MTPushEngagelab.configDebugMode(enable)
```

#### 参数说明

- enable: 是否调试模式，true为调试模式，false不是

#### 代码示例

```js
window.cordova.plugins.MTPushEngagelab.configDebugMode(true)
```

## 获取 RegistrationID （android/ios都支持）

### getRegistrationId

RegistrationID 定义:
获取当前设备的registrationId，Engagelab私有云唯一标识，可同于推送

#### 接口定义

```js
window.cordova.plugins.MTPushEngagelab.getRegistrationId(successCallback)
```

#### 返回值

调用此 API 来取得应用程序对应的 RegistrationID。 只有当应用程序成功注册到 JPush 的服务器时才返回对应的值，否则返回空字符串。

#### 代码示例

```js
window.cordova.plugins.MTPushEngagelab.getRegistrationId(function(rId) {
  console.log("MTPushEngagelab:registrationID is " + rId)
})
```
