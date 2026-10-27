# Changelog

## [1.0.16] - 2026-10-27

### Changed
- Android SDK 依赖升级至 5.5.3；iOS SDK 保持 5.4.4。
- 新增 `requestVivoSubscribeChannelAndroid(channelIds, successCallback, errorCallback)`；最终订阅结果通过 `onMTCommonReceiver` 的 `onCommandResult` 返回（`cmd = 2013`）。
- vivo Push SDK 升级至 4.1.7.0_517，补充中英文 API 文档。
- 在 plugin.xml 根节点声明 tools 命名空间，修复 tools:node 属性导致的 XML 解析失败。
- 移除 config-file 不支持的 mode 属性，修复 Android AppKey、Service 和 Receiver 在插件安装时未写入应用 Manifest 的问题。

## [1.0.15] - 2026-09-18

### Changed
- 更新 Android SDK 及厂商插件至 5.5.1；iOS SDK 保持 5.4.4。
- 插件 Android 端新增 `requestSubscribeChannelAndroid(channelIds)` 小米消息频道订阅接口；结果通过 `MTPushEngagelab.onMTCommonReceiver` 的 `onCommandResult` 事件返回（小米订阅命令 `cmd = 2012`）。
- 小米 Push SDK 升级至 7.12.4。

## [1.0.14] - 2026-09-14

### Changed
- 更新 Android SDK 及厂商插件至 5.5.0；iOS SDK 保持 5.4.4。

## [1.0.13] - 2026-09-04

### Changed
- 更新 Android SDK 及厂商插件至 5.4.4；iOS SDK 保持 5.4.4。

## [1.0.12] - 2026-08-31

### Changed
- 更新 iOS SDK 至 5.4.4；Android 主 SDK 保持 5.4.3。

## [1.0.11] - 2026-08-25

### Changed
- Android 主 SDK 保持 5.4.3，vivo 厂商插件升级至 5.4.3.1，补充桌面角标权限。

## [1.0.10] - 2026-08-19

### Changed
- 更新 Android SDK 至 5.4.3；支持 OPPO 与 vivo 厂商消息角标处理。

## [1.0.9] - 2026-07-10

### Added
- 新增 `reportCustomDisplay(messageId, platform, platformMessageId)`：上报自定义消息展示数据（Android/iOS，iOS 仅使用 messageId）
- 新增 `reportCustomClick(messageId, platform, platformMessageId)`：上报自定义消息点击数据（Android/iOS，iOS 仅使用 messageId）
- Android 5.4.2：新增 `onVoipMessage` 回调（VoIP 消息，支持小米/OPPO/vivo/荣耀四大厂商通道），已接入插件 wrapper

### Changed
- 更新 Android SDK 到 5.4.2，iOS SDK 保持 5.4.1

## [1.0.8] - 2026-05-26

### Changed
- 更新 Android SDK 到 5.4.0，iOS SDK 到 5.4.0
- Android 5.4.0：AndroidId 默认不再采集，`setCollectControl` 中 `aid` 参数已废弃
- Android 5.4.0：小米厂商 SDK 从 6.0.1 升级至 7.9.2
