---
name: dev
description: "Start development session with environment check. Use when resuming work, checking environment status, or when the user says '/dev'"
---

# 開発セッション開始

開発を再開する際の環境確認を行います。

## 手順

1. worktree状態を確認:
```bash
git worktree list
git branch --show-current
git status
```

2. 関連Issueを表示（ブランチ名から推測）:
   - ブランチ名が `feature/issue-{number}-*` の場合、Issue情報を取得
```bash
gh issue view {issue_number}
```

3. Docker環境を確認（docker-compose.ymlがある場合）:
```bash
docker-compose ps
```

4. 環境が起動していなければ起動方法を提案:
```
Docker環境が起動していません。起動するには:
docker-compose up -d
```

5. 前回の作業内容をサマリー表示:
```bash
git log --oneline -5
```
