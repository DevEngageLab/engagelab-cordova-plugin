#!/bin/bash

# 从 GitHub 仓库下载指定标签版本的 mtpush-ios SDK
# 使用方法: ./scripts/download_ios_sdk.sh <版本标签>
# 示例: ./scripts/download_ios_sdk.sh v5.3.0

set -e  # 遇到错误立即退出

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 检查参数
if [ $# -eq 0 ]; then
    echo -e "${RED}错误: 请提供版本标签${NC}"
    echo "使用方法: $0 <版本标签>"
    echo "示例: $0 v5.3.0"
    exit 1
fi

VERSION_TAG=$1
REPO_URL="https://github.com/DevEngageLab/mtpush-sdk.git"
TEMP_DIR=$(mktemp -d)
TARGET_DIR="src/ios/lib"

# 处理版本标签（移除 'v' 前缀如果存在）
VERSION_NUMBER=${VERSION_TAG#v}
SDK_NAME="mtpush-ios-${VERSION_NUMBER}.xcframework"

# 清理函数
cleanup() {
    if [ -d "$TEMP_DIR" ]; then
        echo -e "${YELLOW}清理临时目录...${NC}"
        rm -rf "$TEMP_DIR"
    fi
}

# 注册清理函数
trap cleanup EXIT

echo -e "${BLUE}========================================${NC}"
echo -e "${GREEN}MTPush iOS SDK 下载工具${NC}"
echo -e "${BLUE}========================================${NC}"
echo "版本标签: $VERSION_TAG"
echo "SDK 名称: $SDK_NAME"
echo "目标目录: $TARGET_DIR"
echo ""

# 检查 git 是否安装
if ! command -v git &> /dev/null; then
    echo -e "${RED}错误: 未找到 git 命令，请先安装 git${NC}"
    exit 1
fi

# 检查目标目录是否存在
if [ ! -d "$TARGET_DIR" ]; then
    echo -e "${YELLOW}创建目标目录: $TARGET_DIR${NC}"
    mkdir -p "$TARGET_DIR"
fi

# 克隆仓库到临时目录
echo -e "${GREEN}[1/4] 正在克隆仓库 (标签: $VERSION_TAG)...${NC}"
if ! git clone --depth 1 --branch "$VERSION_TAG" "$REPO_URL" "$TEMP_DIR" 2>&1 | grep -v "Cloning into"; then
    echo -e "${RED}错误: 无法克隆仓库或标签不存在${NC}"
    echo "请检查版本标签是否正确: $VERSION_TAG"
    echo ""
    echo -e "${YELLOW}提示: 可以使用以下命令查看所有可用标签:${NC}"
    echo "git ls-remote --tags $REPO_URL | grep -o 'refs/tags/.*' | sed 's|refs/tags/||' | sort -V"
    exit 1
fi

# 检查 SDK 文件是否存在
SDK_PATH="$TEMP_DIR/$SDK_NAME"
if [ ! -d "$SDK_PATH" ]; then
    echo -e "${YELLOW}未找到 $SDK_NAME，正在查找其他版本...${NC}"
    # 列出所有 xcframework 目录
    FRAMEWORKS=$(find "$TEMP_DIR" -type d -name "mtpush-ios-*.xcframework" 2>/dev/null)
    if [ -z "$FRAMEWORKS" ]; then
        echo -e "${RED}错误: 在仓库中未找到任何 mtpush-ios-*.xcframework${NC}"
        exit 1
    else
        echo -e "${YELLOW}找到以下 SDK 版本:${NC}"
        echo "$FRAMEWORKS" | sed 's|.*/||' | sed 's|\.xcframework||' | sort -V
        echo ""
        echo -e "${YELLOW}请使用正确的版本标签${NC}"
        exit 1
    fi
fi

# 显示 SDK 信息
SDK_SIZE=$(du -sh "$SDK_PATH" | cut -f1)
echo -e "${GREEN}[2/4] 找到 SDK (大小: $SDK_SIZE)${NC}"

# 删除旧版本（如果存在）
OLD_SDK=$(find "$TARGET_DIR" -type d -name "mtpush-ios-*.xcframework" 2>/dev/null | head -1)
if [ -n "$OLD_SDK" ]; then
    OLD_NAME=$(basename "$OLD_SDK")
    if [ "$OLD_NAME" != "$SDK_NAME" ]; then
        echo -e "${YELLOW}[3/4] 删除旧版本: $OLD_NAME${NC}"
        rm -rf "$OLD_SDK"
    else
        echo -e "${YELLOW}[3/4] 检测到相同版本，将覆盖...${NC}"
        rm -rf "$OLD_SDK"
    fi
else
    echo -e "${GREEN}[3/4] 未找到旧版本${NC}"
fi

# 复制新 SDK
echo -e "${GREEN}[4/4] 正在复制 SDK 到目标目录...${NC}"
cp -R "$SDK_PATH" "$TARGET_DIR/"

# 验证复制是否成功
if [ -d "$TARGET_DIR/$SDK_NAME" ]; then
    echo ""
    echo -e "${BLUE}========================================${NC}"
    echo -e "${GREEN}✓ SDK 下载完成!${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo "SDK 位置: $TARGET_DIR/$SDK_NAME"
    echo "SDK 大小: $SDK_SIZE"
    echo ""
    echo -e "${YELLOW}提示: 请记得更新 plugin.xml 中的 SDK 引用路径${NC}"
else
    echo -e "${RED}错误: SDK 复制失败${NC}"
    exit 1
fi

