
使用方法：修改需求里的内容，将需求和步骤内容作为指令让cursor进行执行。


需求：
1. 更新iOS MTPush SDK 到 x.x.x 版本, MTPush SDK 包的路径是：~
2. 更新Android MTPush SDK 到 x.x.x 版本
3. 将原生iOS、Android SDK 新增的方法，封装在插件中。
   原生SDK新增方法一：
   iOS:
   ```
   ```
   
   Android:
   ```
   ```
   
    统一封装为 方法名为 "" 的对外方法。
    

请按照以下步骤完成：

1. 找到需要升级的iOS JPush SDK，替换src/ios/lib/mtpush-ios-x.x.x.xcframework 为需要更新的版本。
2. 将plugin.xml中关于jpush-ios-x.x.x.xcframework相关的引用，替换为需要更新的版本。
3. 安卓找到 MTPushEngagelab.gradle 将版本号替换为需要更新的版本。
4. 封装新增的方法。(如果没有新增的方法就不用执行这一步)，并更新doc/api.md 文档。
5. 在plugin.xml中更新插件版本号，在当前版本号的基础上+0.0.1。
6. 在package.json中更新插件版本号，在当前版本号的基础上+0.0.1。



