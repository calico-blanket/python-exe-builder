@echo off
setlocal enabledelayedexpansion
echo === Python venv���\�z�����s�t�@�C���쐬�c�[�� ===
echo.
echo ��ʂ̎w���ɏ]���Đi�ނƁAPython venv�����\�z���A���s�t�@�C�����쐬����܂��B
echo.
echo  [������]
echo. 
echo  �E�R���\�[����\���i--no console�j�ō쐬����܂��B
echo  �E�t�H���_�[������onefile��������I���ł��܂��B
echo.
echo�@[���O�����̂��肢]
echo.
echo  1. ���s�t�@�C���ɂ�����py�t�@�C���̃t���p�X���N���b�v�{�[�h�⃁���ɃR�s�[���Ă����Ă��������B
echo.
echo  2. ���̃c�[���ł́Apy�t�@�C�������s���Ă̒ǉ����C�u�����̌��o�͂ł��܂���B
echo     ���炩���߁A�K�v�Ȓǉ����C�u�����̖��O���m�F���N���b�v�{�[�h�⃁���ɃR�s�[���Ă����Ă��������B
echo     �ˑ��֌W���o�c�[���idependancy-extractor.py�j�̂����p�������߂��܂��F
echo     https://github.com/calico-blanket/dependency-extractor
echo.
echo  3. ���s�t�@�C���̃A�C�R����C�ӂ̃A�C�R���t�@�C���ɕύX�ł��܂��B(�C�ӁAico�`���̂�)
echo     ���炩���߁A��]�̃A�C�R���t�@�C���̖��O���uicon.ico�v�ɕύX���A
echo     ���̃o�b�`�Ɠ����f�B���N�g��(�t�H���_�[)�ɕۑ����Ă��������B   
echo.
echo.
echo.
echo ��L1.2.(3.)�̏������ł��܂�����A�X�^�[�g���Ă��������B

REM ���͏��̎擾
echo.
echo === ���s�t�@�C���쐬�X�^�[�g ===
echo.
echo.
set /p PROJECT_NAME=�v���W�F�N�g������͂��Ă�������(���s�t�@�C���̖��O�ɂȂ�܂�): 
echo.
set /p PYTHON_FILE=���s�t�@�C���ɂ�����Python�t�@�C���p�X����͂��Ă�������(�t���p�X): 

REM �t�@�C�����̒��o
for %%F in ("%PYTHON_FILE%") do set FILE_NAME=%%~nF

echo.
echo === 1. �v���W�F�N�g�f�B���N�g���̍쐬 ===
mkdir %PROJECT_NAME%
cd %PROJECT_NAME%
echo �v���W�F�N�g�f�B���N�g�����쐬���܂���: %PROJECT_NAME%

REM ���݂̃p�X��ϐ��ɕۑ��i��ŕ\�����邽�߁j
set PROJECT_FULL_PATH=%CD%

echo.
echo === 2. ���z���̍쐬 ===
python -m venv .venv
echo ���z�����쐬���܂���: .venv

echo.
echo === 3. ���z���̃A�N�e�B�x�[�g ===
call .venv\Scripts\activate
echo ���z�����A�N�e�B�x�[�g���܂���

echo.
echo === 4. ��{�p�b�P�[�W�̃C���X�g�[�� ===
pip install pyinstaller
echo PyInstaller���C���X�g�[�����܂���

echo.
echo === 5. Python�t�@�C���̃R�s�[ ===
copy "%PYTHON_FILE%" "%FILE_NAME%.py"
echo Python�t�@�C�����R�s�[���܂���: %FILE_NAME%.py

echo.
echo === 6. �ǉ��p�b�P�[�W�̃C���X�g�[�� ===
REM �_�~�[�l��ݒ�i"NONE"�͎��ۂɂ͑��݂��Ȃ��p�b�P�[�W���j
set ADDITIONAL_PACKAGES=NONE
echo �ǉ����C�u�������s�v�ȏꍇ�͂��̂܂�Enter�������Ă��������B
set /p ADDITIONAL_PACKAGES=�K�v�ȃ��C�u�����p�b�P�[�W���X�y�[�X��؂�œ��͂��Ă�������: 

REM "NONE"�̏ꍇ�̓C���X�g�[�����X�L�b�v
if "%ADDITIONAL_PACKAGES%"=="NONE" (
    echo �ǉ��p�b�P�[�W�̓C���X�g�[�����܂���
) else (
    pip install %ADDITIONAL_PACKAGES%
    echo �ǉ��p�b�P�[�W���C���X�g�[�����܂���
)

REM �A�C�R���ύX�̑I��
echo.
echo === 7. �A�C�R���̐ݒ� ===
set USE_ICON=n
set /p USE_ICON=�A�C�R����ύX���܂����H (y �܂��� n �f�t�H���g:n): 

REM �A�C�R���I�v�V�����̐ݒ�
set ICON_OPTION=
if /i "%USE_ICON%"=="y" (
    if exist "%~dp0icon.ico" (
        echo �A�C�R���t�@�C���������܂���: icon.ico
        copy "%~dp0icon.ico" "icon.ico"
        if exist "icon.ico" (
            set ICON_OPTION=--icon=icon.ico
            echo icon.ico���R�s�[���ăA�C�R���ɐݒ肵�܂���
        ) else (
            echo �R�s�[�Ɏ��s���܂����B�f�t�H���g�A�C�R�����g�p���܂��B
        )
    ) else (
        echo �A�C�R���t�@�C���uicon.ico�v��������܂���B
        echo �f�t�H���g�A�C�R�����g�p���܂��B
    )
) else (
    echo �f�t�H���g�A�C�R�����g�p���܂��B
)

REM onefile�I�v�V�����̑I��
echo.
echo === 8. ���s�t�@�C���`���̑I�� ===
set ONEFILE_OPT=0
echo �P��t�@�C���`��(onefile)�ō쐬���܂����H
echo  1 - �͂�(�P��t�@�C���`��)
echo  2 - ������(�t�H���_�[�`��)
set /p ONEFILE_OPT=�I�����Ă������� (1�܂���2�A�f�t�H���g:2): 

REM �I���Ɋ�Â��ăI�v�V������ݒ�
if "%ONEFILE_OPT%"=="1" (
    echo �P��t�@�C���`���ō쐬���܂��B
    set FORMAT_OPTION=--onefile
    set IS_ONEFILE=yes
) else (
    echo �t�H���_�[�`���ō쐬���܂��B
    set FORMAT_OPTION=
    set IS_ONEFILE=no
)

echo.
echo === 9. ���s�t�@�C���̍쐬 ===
echo ���s�R�}���h: pyinstaller --noconsole %ICON_OPTION% %FORMAT_OPTION% --name=%PROJECT_NAME% %FILE_NAME%.py
pyinstaller --noconsole %ICON_OPTION% %FORMAT_OPTION% --name=%PROJECT_NAME% %FILE_NAME%.py

REM onefile�`�����ǂ����ŏo�̓��b�Z�[�W��ύX
if "%IS_ONEFILE%"=="yes" (
    echo ���s�t�@�C�����쐬���܂���: dist\%PROJECT_NAME%.exe
) else (
    echo ���s�t�@�C�����쐬���܂���: dist\%PROJECT_NAME%\%PROJECT_NAME%.exe
)

echo.
echo === �Z�b�g�A�b�v���� ===
echo �v���W�F�N�g�t�H���_: %PROJECT_FULL_PATH%
echo.
echo �ȉ��̃t�@�C�����쐬����܂���:
echo - ���z��: .venv
echo - ���C���t�@�C��: %FILE_NAME%.py
echo.
if "%IS_ONEFILE%"=="yes" (
    echo   ���s�t�@�C���̏ꏊ: %PROJECT_FULL_PATH%\dist\%PROJECT_NAME%.exe
    echo.
    echo ����: �P��t�@�C���`���ō쐬���ꂽ���߁Adist\%PROJECT_NAME%.exe�t�@�C���݂̂�z�z�ł��܂�
) else (
    echo   ���s�t�@�C���̏ꏊ: %PROJECT_FULL_PATH%\dist\%PROJECT_NAME%\%PROJECT_NAME%.exe
    echo.
    echo ����: �t�H���_�[�`���ō쐬���ꂽ���߁Adist\%PROJECT_NAME%�t�H���_�S�̂�z�z����K�v������܂�
)
echo.

pause
endlocal