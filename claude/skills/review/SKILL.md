---
name: review
description: "Self-review changed files before creating PR. Use when reviewing code changes, before committing, or when the user says 'review'"
---

# セルフレビュー

変更ファイルをレビューし、問題を事前に検出します。

## 手順

1. 変更ファイルを確認:
```bash
git diff --name-only
git diff --stat
```

2. 以下の観点でレビュー:
   - **スタイル**: コーディング規約、命名規則、フォーマット
   - **セキュリティ**: SQLインジェクション、XSS、認証・認可の欠落
   - **パフォーマンス**: N+1クエリ、不要な再レンダリング、メモリリーク
   - **テスト**: テストカバレッジ、エッジケース
   - **アーキテクチャ**: 設計パターンの遵守、責務の分離

3. 問題があれば重大度別に報告:
   - **Critical**: 必ず修正（セキュリティ脆弱性、クラッシュ、データ損失）
   - **Warning**: 修正推奨（パフォーマンス問題、コード品質）
   - **Info**: 改善の余地（リファクタリング候補、ドキュメント）

4. Critical問題があれば修正を提案

5. **コミット分割の提案**:
   - 変更内容を論理的な単位で分析
   - 意味のあるコミット単位を提案
   - 例: 「リファクタリング」「新機能追加」「テスト追加」を別コミットに

## プロジェクト固有のルール

プロジェクトに `.claude/agents/code-reviewer.md` がある場合は、その観点も適用してください。
