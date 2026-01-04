---
name: branch
description: "Create feature branch with worktree from GitHub Issue. Use when starting work on an issue, creating a new branch, or when the user says '/branch'"
---

# ブランチ作成（worktree）

$ARGUMENTS

GitHubのIssueからworktreeを使って作業ブランチを作成します。

## 使用例
```
/branch 123
```

## 手順

1. 現在のプロジェクト名を取得:
```bash
basename $(git rev-parse --show-toplevel)
```

2. Issue情報を取得:
```bash
gh issue view {issue_number} --json title,number
```

3. ブランチ名を生成:
   - 形式: `feature/issue-{number}-{short-title}`
   - タイトルは英語・ケバブケースに変換
   - 日本語タイトルの場合は英訳してケバブケースに

4. worktreeを作成:
```bash
# プロジェクト名を動的に取得
PROJECT_NAME=$(basename $(git rev-parse --show-toplevel))

# worktreeディレクトリ: ../{PROJECT_NAME}-issue-{number}
git worktree add -b feature/issue-{number}-{short-title} ../${PROJECT_NAME}-issue-{number}
```

5. 作成したworktreeのパスを表示:
```
worktreeを作成しました: ../{PROJECT_NAME}-issue-{number}

次のステップ:
cd ../{PROJECT_NAME}-issue-{number}
```
