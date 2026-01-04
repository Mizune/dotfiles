# Global Claude Code Instructions

## Code Quality

コードを作成・変更する際は、可読性を重視すること。

- 意図が明確に伝わる命名（変数名、関数名、クラス名）
- 適切な関数・メソッドの分割（1つの関数は1つの責務）
- 複雑なロジックにはコメントを追加
- 一貫したコードスタイルの維持

---

## Development Workflow

コード変更を伴う作業では、以下のワークフローに従うこと。

### 1. Git Worktreeで作業
- 特に指示がなければ、git worktreeを使用してブランチを作成・作業する
- worktreeディレクトリが存在しない場合は、プロジェクトの親ディレクトリに作成する
  - 例: `git worktree add ../project-name-123 -b fix/issue-123`
- 親ディレクトリに作成できない場合は、プロジェクト内に `.worktrees/` ディレクトリを作成して使用

### 2. 実装後のレビュー
- 一通り実装が完了したら `/review` を実行してコードレビューを行う
- criticalな問題が検出された場合は修正し、再度 `/review` を実行
- criticalな問題がなくなるまで繰り返す

### 3. コミット作成
- レビューが完了したら、意味のある粒度でコミットを分割して作成する
- 下記の「Git Commit Policy」に従う

---

## Git Commit Policy

コミットは意味のある粒度で分割すること。1つのコミットは1つの論理的な変更のみを含める。

**分割の基準:**
- バックエンドとフロントエンドの変更は別コミット
- 機能追加とバグ修正は別コミット
- リファクタリングと機能変更は別コミット
- テスト追加は関連する実装と同じコミットでも可

**コミットメッセージ形式:**
- Conventional Commits形式を使用: `type(scope): description`
- type: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`
- scope: `backend`, `frontend`, `shared`, または具体的な機能名

**例:**
```
feat(backend): Stripe Connect ステータス再取得エンドポイント追加
fix(frontend): オンボーディング完了時にConnect状態を即時取得
refactor(shared): DTOのバリデーション処理を共通化
```
