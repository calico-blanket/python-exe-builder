@echo off
setlocal enabledelayedexpansion
echo === Python venv環境構築＆実行ファイル作成ツール ===
echo.
echo 画面の指示に従って進むと、Python venv環境を構築し、実行ファイルが作成されます。
echo.
echo  [ご注意]
echo. 
echo  ・コンソール非表示（--no console）で作成されます。
echo  ・フォルダー方式かonefile方式かを選択できます。
echo.
echo　[事前準備のお願い]
echo.
echo  1. 実行ファイルにしたいpyファイルのフルパスをクリップボードやメモにコピーしておいてください。
echo.
echo  2. このツールでは、pyファイルを実行しての追加ライブラリの検出はできません。
echo     あらかじめ、必要な追加ライブラリの名前を確認しクリップボードやメモにコピーしておいてください。
echo     依存関係抽出ツール（dependancy-extractor.py）のご利用をお勧めします：
echo     https://github.com/calico-blanket/dependency-extractor
echo.
echo  3. 実行ファイルのアイコンを任意のアイコンファイルに変更できます。(任意、ico形式のみ)
echo     あらかじめ、希望のアイコンファイルの名前を「icon.ico」に変更し、
echo     このバッチと同じディレクトリ(フォルダー)に保存してください。   
echo.
echo.
echo.
echo 上記1.2.(3.)の準備ができましたら、スタートしてください。

REM 入力情報の取得
echo.
echo === 実行ファイル作成スタート ===
echo.
echo.
set /p PROJECT_NAME=プロジェクト名を入力してください(実行ファイルの名前になります): 
echo.
set /p PYTHON_FILE=実行ファイルにしたいPythonファイルパスを入力してください(フルパス): 

REM ファイル名の抽出
for %%F in ("%PYTHON_FILE%") do set FILE_NAME=%%~nF

echo.
echo === 1. プロジェクトディレクトリの作成 ===
mkdir %PROJECT_NAME%
cd %PROJECT_NAME%
echo プロジェクトディレクトリを作成しました: %PROJECT_NAME%

REM 現在のパスを変数に保存（後で表示するため）
set PROJECT_FULL_PATH=%CD%

echo.
echo === 2. 仮想環境の作成 ===
python -m venv .venv
echo 仮想環境を作成しました: .venv

echo.
echo === 3. 仮想環境のアクティベート ===
call .venv\Scripts\activate
echo 仮想環境をアクティベートしました

echo.
echo === 4. 基本パッケージのインストール ===
pip install pyinstaller
echo PyInstallerをインストールしました

echo.
echo === 5. Pythonファイルのコピー ===
copy "%PYTHON_FILE%" "%FILE_NAME%.py"
echo Pythonファイルをコピーしました: %FILE_NAME%.py

echo.
echo === 6. 追加パッケージのインストール ===
REM ダミー値を設定（"NONE"は実際には存在しないパッケージ名）
set ADDITIONAL_PACKAGES=NONE
echo 追加ライブラリが不要な場合はそのままEnterを押してください。
set /p ADDITIONAL_PACKAGES=必要なライブラリパッケージをスペース区切りで入力してください: 

REM "NONE"の場合はインストールをスキップ
if "%ADDITIONAL_PACKAGES%"=="NONE" (
    echo 追加パッケージはインストールしません
) else (
    pip install %ADDITIONAL_PACKAGES%
    echo 追加パッケージをインストールしました
)

REM アイコン変更の選択
echo.
echo === 7. アイコンの設定 ===
set USE_ICON=n
set /p USE_ICON=アイコンを変更しますか？ (y または n デフォルト:n): 

REM アイコンオプションの設定
set ICON_OPTION=
if /i "%USE_ICON%"=="y" (
    if exist "%~dp0icon.ico" (
        echo アイコンファイルを見つけました: icon.ico
        copy "%~dp0icon.ico" "icon.ico"
        if exist "icon.ico" (
            set ICON_OPTION=--icon=icon.ico
            echo icon.icoをコピーしてアイコンに設定しました
        ) else (
            echo コピーに失敗しました。デフォルトアイコンを使用します。
        )
    ) else (
        echo アイコンファイル「icon.ico」が見つかりません。
        echo デフォルトアイコンを使用します。
    )
) else (
    echo デフォルトアイコンを使用します。
)

REM onefileオプションの選択
echo.
echo === 8. 実行ファイル形式の選択 ===
set ONEFILE_OPT=0
echo 単一ファイル形式(onefile)で作成しますか？
echo  1 - はい(単一ファイル形式)
echo  2 - いいえ(フォルダー形式)
set /p ONEFILE_OPT=選択してください (1または2、デフォルト:2): 

REM 選択に基づいてオプションを設定
if "%ONEFILE_OPT%"=="1" (
    echo 単一ファイル形式で作成します。
    set FORMAT_OPTION=--onefile
    set IS_ONEFILE=yes
) else (
    echo フォルダー形式で作成します。
    set FORMAT_OPTION=
    set IS_ONEFILE=no
)

echo.
echo === 9. 実行ファイルの作成 ===
echo 実行コマンド: pyinstaller --noconsole %ICON_OPTION% %FORMAT_OPTION% --name=%PROJECT_NAME% %FILE_NAME%.py
pyinstaller --noconsole %ICON_OPTION% %FORMAT_OPTION% --name=%PROJECT_NAME% %FILE_NAME%.py

REM onefile形式かどうかで出力メッセージを変更
if "%IS_ONEFILE%"=="yes" (
    echo 実行ファイルを作成しました: dist\%PROJECT_NAME%.exe
) else (
    echo 実行ファイルを作成しました: dist\%PROJECT_NAME%\%PROJECT_NAME%.exe
)

echo.
echo === セットアップ完了 ===
echo プロジェクトフォルダ: %PROJECT_FULL_PATH%
echo.
echo 以下のファイルが作成されました:
echo - 仮想環境: .venv
echo - メインファイル: %FILE_NAME%.py
echo.
if "%IS_ONEFILE%"=="yes" (
    echo   実行ファイルの場所: %PROJECT_FULL_PATH%\dist\%PROJECT_NAME%.exe
    echo.
    echo 注意: 単一ファイル形式で作成されたため、dist\%PROJECT_NAME%.exeファイルのみを配布できます
) else (
    echo   実行ファイルの場所: %PROJECT_FULL_PATH%\dist\%PROJECT_NAME%\%PROJECT_NAME%.exe
    echo.
    echo 注意: フォルダー形式で作成されたため、dist\%PROJECT_NAME%フォルダ全体を配布する必要があります
)
echo.

pause
endlocal