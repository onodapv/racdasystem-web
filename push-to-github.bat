@echo off
chcp 65001 >nul
echo ========================================
echo GitHubへのプッシュスクリプト
echo ========================================
echo.

cd /d "D:\Dropbox\MYWORK\CursorWorks\RSC-WEB2"
echo 現在のディレクトリ: %CD%
echo.

echo [1/6] Gitリポジトリの確認...
if not exist .git (
    echo Gitリポジトリを初期化中...
    git init
    if errorlevel 1 (
        echo エラー: Gitの初期化に失敗しました
        pause
        exit /b 1
    )
    echo ✓ Gitリポジトリ初期化完了
) else (
    echo ✓ Gitリポジトリは既に存在します
)
echo.

echo [2/6] Git設定の確認...
git config user.name "onodapv"
git config user.email "onodapv@users.noreply.github.com"
echo ✓ Git設定完了
echo.

echo [3/6] ファイルを追加中...
git add .
if errorlevel 1 (
    echo エラー: ファイルの追加に失敗しました
    pause
    exit /b 1
)
echo ✓ ファイル追加完了
echo.

echo [4/6] コミット中...
git commit -m "Initial commit: Add Vercel configuration and update to HTTPS"
if errorlevel 1 (
    echo 警告: コミットに失敗しました（既にコミット済みの可能性があります）
)
echo ✓ コミット完了
echo.

echo [5/6] リモートの設定...
git remote remove origin 2>nul
git remote add origin https://github.com/onodapv/racdasystem-web.git
if errorlevel 1 (
    echo エラー: リモートの設定に失敗しました
    pause
    exit /b 1
)
echo ✓ リモート設定完了
echo.

echo [6/6] ブランチ名をmainに変更...
git branch -M main
echo ✓ ブランチ名変更完了
echo.

echo ========================================
echo GitHubにプッシュ中...
echo （認証が必要な場合、Personal Access Tokenを入力してください）
echo ========================================
echo.
git push -u origin main

if errorlevel 1 (
    echo.
    echo ========================================
    echo プッシュに失敗しました
    echo ========================================
    echo.
    echo 認証が必要な場合、以下のコマンドを実行してください:
    echo git remote set-url origin https://YOUR_TOKEN@github.com/onodapv/racdasystem-web.git
    echo git push -u origin main
    echo.
    pause
    exit /b 1
) else (
    echo.
    echo ========================================
    echo ✓ プッシュ成功！
    echo ========================================
    echo.
    echo リポジトリURL: https://github.com/onodapv/racdasystem-web
    echo.
    pause
)


