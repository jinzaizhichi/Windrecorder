@echo off
echo Loading extension, please stand by.
echo.

cd /d %~dp0
chcp 65001

:start_install
cls
echo.
echo   This guide will add WeChat OCR as the optical text recognition engine for Windrecorder.
echo   Third-party OCR engines may consume more system resources when recognizing.
echo.
echo   本向导将为捕风记录仪添加 WeChat OCR 作为光学文本识别引擎。

echo   第三方 OCR 引擎运行时可能会占用更高系统资源。
echo.
echo   Support languages: en-US, zh-Hans, zh-Hant
echo   支持语言：英文, 简体中文, 繁体中文
echo.
echo   Make sure to exit windrecorder before installation.
echo   安装前请确保退出了 捕风记录仪。
echo.
echo   Enter Y and press Enter to install WeChat OCR module.
echo   输入 Y 后回车安装 WeChat OCR。
echo.
echo   ================================================================================
echo.
set /p choice=   Please enter the options and press Enter:

if /I "%choice%"=="Y" (
    echo Installing...
    goto install_module
)

goto start_install


@REM -------------------------------------------------
:install_module
poetry run pip install wechat-ocr -i https://pypi.tuna.tsinghua.edu.cn/simple
cd ..
cd ..
cd ocr_lib
git clone https://github.com/Antonoko/wxocr-binary
cd ..
cd extension
cd install_wechat_ocr
goto :finish


@REM -------------------------------------------------
:finish
echo.
echo   checking the installation results... 检查安装结果……
echo.
for /F "tokens=* USEBACKQ" %%A in (`python -m poetry env info --path`) do call "%%A\Scripts\activate.bat"
python _test_install.py
echo.
echo   The installation script has been completed. 已执行完安装脚本。
echo.
pause
exit