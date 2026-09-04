# Changelog

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
