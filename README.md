# Python EXE Builder

[English](#english) | [日本語](#japanese)

<a id="english"></a>
## Python EXE Builder

A tool that converts Python scripts to Windows executable files (.exe) with simple operations.

### Features

- **Easy Operation**: Convert Python scripts to .exe files just by following guided prompts
- **Automatic Environment Setup**: Automatically sets up a Python virtual environment
- **Dependency Management**: Automatically installs specified libraries in the virtual environment (note: libraries must be manually identified)
- **Customization Options**:
  - Icon customization
  - Single file/Folder format selection
  - Hidden console window
- **PyInstaller Utilization**: Uses reliable PyInstaller for conversion

### Requirements

- Windows OS
- Python 3.6 or higher

### Usage

1. Clone this repository or download as ZIP
2. Double-click `python-exe-builder_en.bat` (English) or `python-exe-builder_ja.bat` (Japanese) to run
3. Follow the on-screen instructions to enter information:
   - Project name (name of the output executable file)
   - Path of the Python file to convert
   - Required additional libraries (space-separated)
   - Whether to change the icon
   - Output format (single file or folder structure)

### Icon Customization

To use a custom icon:
1. Rename your desired icon file to "icon.ico"
2. Place it in the same directory as the batch file
3. Select "y" at the "Do you want to change the icon?" prompt during conversion

### Output Results

After conversion, the executable file will be generated in the following location:

- **For single file format**: `[Project name]/dist/[Project name].exe`
- **For folder format**: `[Project name]/dist/[Project name]/[Project name].exe`

### Notes

- Single file format: Can be distributed with just a single .exe file
- Folder format: Need to distribute the entire generated folder (larger size but faster startup)
- A properly functioning executable file will be generated by accurately specifying all dependencies

### Identifying Dependencies

This tool cannot automatically detect necessary libraries. You need to identify the dependent libraries used by your Python script in advance.

Recommended tools for identifying dependencies:

1. **pipreqs**: Extracts dependencies from your project
   - https://github.com/bndr/pipreqs

2. **pip-tools**: A set of tools to manage package dependencies
   - https://github.com/jazzband/pip-tools 

3. **dependency-extractor**: A tool for extracting dependent libraries from Python scripts
   - https://github.com/calico-blanket/dependency-extractor

### License

MIT

### Contribution

Contributions are welcome! We look forward to issue reports and pull requests for improvement.

---
[English](#english)
<a id="japanese"></a>
## Python EXE Builder

シンプルな操作でPythonスクリプトをWindowsの実行ファイル(.exe)に変換するツールです。

### 特徴

- **簡単操作**: ガイド付きのプロンプトに従うだけで、Pythonスクリプトを.exeファイルに変換
- **自動環境構築**: Python仮想環境を自動的にセットアップ
- **依存関係の管理**: 指定したライブラリを仮想環境内に自動インストール（※ライブラリの特定は手動で行う必要があります）
- **カスタマイズオプション**:
  - アイコンの変更
  - ワンファイル形式/フォルダ形式の選択
  - コンソールウィンドウ非表示
- **PyInstaller活用**: 信頼性の高いPyInstallerを使用

### 必要要件

- Windows OS
- Python 3.6以上

### 使い方

1. このリポジトリをクローンまたはZIPでダウンロード
2. `python-exe-builder_ja.bat`（日本語）または`python-exe-builder_en.bat`（英語）をダブルクリックで実行
3. 画面の指示に従って情報を入力:
   - プロジェクト名（出力される実行ファイルの名前）
   - 変換するPythonファイルのパス
   - 必要な追加ライブラリ（スペース区切り）
   - アイコン変更の有無
   - 出力形式（単一ファイル or フォルダ構造）

### アイコンのカスタマイズ

カスタムアイコンを使用するには:
1. 使用したいアイコンファイルを「icon.ico」という名前に変更
2. バッチファイルと同じディレクトリに配置
3. 変換時に「アイコンを変更しますか？」のプロンプトで「y」を選択

### 出力結果

変換が完了すると、以下の場所に実行ファイルが生成されます:

- **単一ファイル形式の場合**: `[プロジェクト名]/dist/[プロジェクト名].exe`
- **フォルダ形式の場合**: `[プロジェクト名]/dist/[プロジェクト名]/[プロジェクト名].exe`

### 注意事項

- 単一ファイル形式：単一の.exeファイルのみで配布可能
- フォルダ形式：生成されたフォルダ全体を配布する必要あり（サイズは大きいが起動が速い）
- 全ての依存関係を正確に指定することで、正常に動作する実行ファイルが生成されます

### 依存関係の特定方法

このツールは必要なライブラリを自動検出することはできません。Pythonスクリプトが使用する依存ライブラリを事前に特定しておく必要があります。

依存関係を特定するための方法:

1. **pipreqs**: プロジェクトから依存関係を抽出
   - https://github.com/bndr/pipreqs

2. **pip-tools**: 依存関係を管理するツール
   - https://github.com/jazzband/pip-tools

3. **dependency-extractor**: Pythonスクリプトから依存ライブラリを抽出するツール
   - https://github.com/calico-blanket/dependency-extractor

### ライセンス

MIT

### 貢献

貢献は歓迎します！Issue報告や改善のためのプルリクエストをお待ちしています。

## Author / 作者

calico_blanket (猫柄毛布）

## Note from the Author / 作者からのお知らせ

私はプロのデベロッパーやソフトエンジニアではなく、単なる、おばちゃんのIT愛好家にすぎません。

このツールは個人的なプロジェクトとして、ClaudeのSonnet3.7の助けを大きく借りて作成しました。

フィードバック、バグ報告、および提案などをいただきましたら、Sonnetと有識者の皆様のお知恵をお借りして、真摯に改善に取り組みたいと思います。
私の学びと成長ににご協力いただけると幸いです。

I am not a professional developer or software engineer, just a middle-aged woman who is an IT enthusiast.

This tool was created as a personal project with significant help from Claude's Sonnet 3.5 and 3.7.

If you provide feedback, bug reports, or suggestions, I will sincerely work on improvements with the help of Sonnet and knowledgeable community members.

I would appreciate your cooperation in my learning and growth.
