# GitHubデプロイスクリプト
$ErrorActionPreference = "Stop"

Write-Host "=== GitHubデプロイスクリプト開始 ===" -ForegroundColor Green

# プロジェクトフォルダに移動
Set-Location "D:\Dropbox\MYWORK\CursorWorks\RSC-WEB2"
Write-Host "現在のディレクトリ: $(Get-Location)" -ForegroundColor Yellow

# Gitリポジトリの初期化
if (-not (Test-Path .git)) {
    Write-Host "Gitリポジトリを初期化中..." -ForegroundColor Yellow
    git init
    Write-Host "✓ Gitリポジトリ初期化完了" -ForegroundColor Green
} else {
    Write-Host "✓ Gitリポジトリは既に存在します" -ForegroundColor Green
}

# Git設定
Write-Host "Git設定を確認中..." -ForegroundColor Yellow
git config user.name "onodapv"
$email = git config user.email
if (-not $email) {
    git config user.email "onodapv@users.noreply.github.com"
}
Write-Host "✓ Git設定完了" -ForegroundColor Green

# ファイルを追加
Write-Host "ファイルを追加中..." -ForegroundColor Yellow
git add .
$status = git status --short
Write-Host "追加されたファイル:" -ForegroundColor Cyan
Write-Host $status
Write-Host "✓ ファイル追加完了" -ForegroundColor Green

# コミット
Write-Host "コミット中..." -ForegroundColor Yellow
$commitMsg = "Initial commit: Add Vercel configuration and update to HTTPS"
git commit -m $commitMsg
Write-Host "✓ コミット完了" -ForegroundColor Green

# ブランチ名をmainに変更
Write-Host "ブランチ名をmainに変更中..." -ForegroundColor Yellow
git branch -M main
Write-Host "✓ ブランチ名変更完了" -ForegroundColor Green

# リモートの設定
Write-Host "リモートを設定中..." -ForegroundColor Yellow
$remoteUrl = "https://github.com/onodapv/racdasystem-web.git"
$existingRemote = git remote get-url origin 2>$null
if ($LASTEXITCODE -eq 0) {
    Write-Host "既存のリモートを削除中..." -ForegroundColor Yellow
    git remote remove origin
}
git remote add origin $remoteUrl
Write-Host "✓ リモート設定完了: $remoteUrl" -ForegroundColor Green

# プッシュ
Write-Host "GitHubにプッシュ中..." -ForegroundColor Yellow
Write-Host "（認証が必要な場合、Personal Access Tokenを入力してください）" -ForegroundColor Cyan
git push -u origin main
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ プッシュ成功！" -ForegroundColor Green
    Write-Host "リポジトリURL: https://github.com/onodapv/racdasystem-web" -ForegroundColor Cyan
} else {
    Write-Host "✗ プッシュ失敗" -ForegroundColor Red
    Write-Host "エラーコード: $LASTEXITCODE" -ForegroundColor Red
    Write-Host ""
    Write-Host "手動でプッシュする場合:" -ForegroundColor Yellow
    Write-Host "git push -u origin main" -ForegroundColor White
    Write-Host ""
    Write-Host "認証が必要な場合、Personal Access Tokenを使用:" -ForegroundColor Yellow
    Write-Host "git remote set-url origin https://YOUR_TOKEN@github.com/onodapv/racdasystem-web.git" -ForegroundColor White
}

Write-Host ""
Write-Host "=== スクリプト完了 ===" -ForegroundColor Green


