# 更新SDK

根据输入的需要更新的SDK版本号更新插件。

## 更新步骤

### 1. 更新iOS SDK

使用自动下载脚本从 GitHub 仓库下载指定版本的 iOS SDK：

```bash
./scripts/download_ios_sdk.sh <版本标签>
```

**示例**：
```bash
# 下载 v5.3.0 版本的 SDK
./scripts/download_ios_sdk.sh v5.3.0

# 或者不带 'v' 前缀
./scripts/download_ios_sdk.sh 5.3.0
```

**脚本功能**：
- 自动从 GitHub 仓库 `https://github.com/DevEngageLab/mtpush-sdk.git` 下载指定标签版本的 SDK
- 自动删除旧版本的 SDK（如果存在）
- 将新 SDK 复制到 `src/ios/lib/` 目录

**手动步骤**（脚本完成后）：
- 将 `plugin.xml` 中关于 `mtpush-ios-x.x.x.xcframework` 相关的引用，替换为需要更新的版本（通常在 `<source-file>` 标签中，约第 217 行）

### 2. 查找SDK新增API

**⚠️ 重要：必须仔细逐项检查更新日志，不要因为看到"更新各厂商SDK"等主要更新内容就忽略新增API的检查！**

#### Android SDK
- 访问 [Android SDK Changelog](https://www.engagelab.com/zh_CN/docs/app-push/developer-guide/client-sdk-reference/changelog/android-sdk) 查找新版本的新增对外API
- **检查方法**：
  1. 找到目标版本（如 v5.2.0）的更新内容部分
  2. **逐项阅读**更新内容列表中的每一项，不要跳过任何条目
  3. 特别关注包含以下关键词的条目：
     - "新增"、"新增接口"、"新增API"、"新增方法"
     - "public static"、"public void" 等Java方法签名
     - "支持"、"功能"（可能包含新API）
  4. 对于每个疑似新增API的条目，记录：
     - API方法名（如 `setCollectControl`）
     - 完整方法签名（如 `public static void setCollectControl(MTPushCollectControl control)`）
     - 功能描述
- 在 [Android SDK API 文档](https://www.engagelab.com/zh_CN/docs/app-push/developer-guide/client-sdk-reference/android-sdk/sdk-api-guide) 中查找并确认新增API的详细用法、参数说明和示例代码

#### iOS SDK
- 访问 [iOS SDK Changelog](https://www.engagelab.com/zh_CN/docs/app-push/developer-guide/client-sdk-reference/changelog/ios-sdk) 查找新版本的新增对外API
- **检查方法**：
  1. 找到目标版本（如 v5.2.0）的更新内容部分
  2. **逐项阅读**更新内容列表中的每一项，不要跳过任何条目
  3. 特别关注包含以下关键词的条目：
     - "新增"、"新增接口"、"新增API"、"新增方法"
     - Objective-C方法签名（如 `- (void)setBadge:completion:`）
     - "支持"、"功能"（可能包含新API）
  4. 对于每个疑似新增API的条目，记录：
     - API方法名
     - 完整方法签名
     - 功能描述
- 在 [iOS SDK API 文档](https://www.engagelab.com/zh_CN/docs/app-push/developer-guide/client-sdk-reference/ios-sdk/sdk-api-guide) 中查找并确认新增API的详细用法、参数说明和示例代码

**检查清单**（在完成检查后确认）：
- [ ] 已找到目标版本的更新日志
- [ ] 已逐项阅读所有更新内容条目（包括次要更新）
- [ ] 已识别所有包含"新增"、"API"、"接口"、"方法"等关键词的条目
- [ ] 已记录所有新增API的方法名和签名
- [ ] 已在API文档中查找并确认了每个新增API的详细用法
- [ ] 已区分哪些是新增的对外API（需要封装），哪些是内部更新（不需要封装）

**常见误区**：
- ❌ 错误：看到"更新各厂商SDK"就认为只是版本更新，没有新增API
- ✅ 正确：即使主要更新是版本升级，也要仔细检查是否有新增API
- ❌ 错误：只关注主要更新内容，忽略列表中的其他条目
- ✅ 正确：必须逐项检查更新内容列表中的每一项
- ❌ 错误：依赖搜索结果判断是否有新增API
- ✅ 正确：直接查看官方更新日志，逐项检查
- ❌ 错误：文本识别有问题时（如缺少字母），直接忽略
- ✅ 正确：如果文本识别有问题，需要手动访问官方文档确认

### 3. 更新Android SDK版本依赖

- 在 `src/android/MTPushEngagelab.gradle` 中将版本号替换为需要更新的版本

### 4. 封装新增API（如有）

**⚠️ 重要：如果没有新增API，必须明确说明"经检查，该版本无新增对外API"，而不是简单说"没有新增API"。**

如果SDK有新增API，需要在插件中进行封装：
- 在 `www/MTPushEngagelab.js` 中添加JavaScript方法
- 在 `src/android/MTPushEngagelab.java` 中实现Android端逻辑
- 在 `src/ios/MTPushEngagelab.m` 或相关iOS文件中实现iOS端逻辑

**封装原则**：
- 如果Android和iOS新增的API是同一个功能，封装成一个插件方法
- 如果不是同一个功能，分开封装
- **不要使用反射的方式调用SDK API，直接调用即可**
- 如果没有新增API，**必须明确说明已检查并确认无新增API**，然后跳过此步骤

**封装步骤**：
1. 确定API的完整签名和参数类型
2. 确定API的调用时机（是否需要在init之前调用）
3. 在对应平台实现方法
4. 在JavaScript层添加方法，保持与现有API风格一致
5. 添加必要的错误处理和日志

### 5. 更新API文档

如果新增了插件方法，需要更新文档：
- 在 `doc/api.md` 中补充新增的插件方法

如果没有新增方法，跳过此步骤。

### 6. 更新插件版本号

**⚠️ 重要：需要在两个文件中更新版本号，保持一致**

- 在 `plugin.xml` 中更新插件版本号，在当前版本号的基础上 + 0.0.1
- 在 `package.json` 中更新插件版本号，在当前版本号的基础上 + 0.0.1

**版本号更新规则**：
- 版本号格式为 `主版本号.次版本号.修订号`（如 `1.0.5`）
- 在当前版本号的基础上 + 0.0.1（如 `1.0.5` → `1.0.6`）

**示例**：
- 假设当前版本为 `1.0.5`
- 更新后版本为 `1.0.6`

## 注意事项

- **必须逐项检查更新日志，不要遗漏任何新增API**
- 确保Android和iOS的SDK版本对应关系正确
- 新增API的封装需要保持与现有API风格一致
- 更新后建议进行测试验证
- **如果更新日志中的文本识别有问题（如缺少字母），需要手动访问官方文档确认**
- **确保 `plugin.xml` 和 `package.json` 中的版本号保持一致**
- 使用脚本更新iOS SDK后，需要确保 `plugin.xml` 中的 `<source-file>` 标签路径正确指向新的 xcframework 文件
- 脚本需要 git 命令支持，确保已安装 git