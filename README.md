# README

# アプリケーション名
## ShiftBoard

### アプリケーション概要
 シフトの提出をする事ができ、提出した内容をそのまま編集し
 張り出すことのできるアプリケーションです。
 その他に、会員登録機能、掲示板機能、チャット機能があります。

### URL

### テスト用のアカウント

### 利用方法
 会員登録を行うことで、シフトの提出が出来るようになります。
 また特定のユーザーにはシフトの内容の編集や削除機能を使えます。
 投稿機能でお知らせを配信したり、個別でチャットを行うこともできます。

### 目指した課題解決
 シフト管理を行う際に、全てアプリケーション上で管理をすることで
 シフトの作成の工数を減らし、業務の負担を軽減することを目的に作りました。
 人件費の計算や目標人件費に対しての差異を作成時に確認する事ができ、コスト管理をしやすくします。
 掲示板やチャット機能を使う事で、同じコミュニティ内でのコミュニケーションツールとしても役に立ちます。

### 洗い出した要件定義

### 実装した機能についてのGIFと説明

### 実装予定の機能

### データベース設計


## users テーブル

| Column              | Type    | Options                |
| ------------------- | ------- | ---------------------- |
| name                | string  | null: false            |
| email               | string  | null: false,unique:true|
| encrypted_password  | string  | null: false            |

### Association

has_many : tweets
has_one  : shift
has_many : goals

## tweet テーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| title               | string     | null: false                    |
| context             | text       | null: false                    |
| user                | references | null: false, foreign_key: true |



### Association

belongs_to :user
has_many :count

## count テーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| like_count          | string     |                                |
| tweet               | references | null: false, foreign_key: true |
| user                | references | null: false, foreign_key: true |

### Association

belongs_to : tweet
belongs_to : user


## shift テーブル

| Column                 | Type       | Options                        |
| ---------------------- | ---------- | ------------------------------ |
| day                    | string     |                                |
| shift_in               | string     |                                |
| shift_out              | string     |                                |
| user                   | references | null: false, foreign_key: true |

### Association

belongs_to : user


## goal テーブル

| Column                 | Type       | Options                        |
| ---------------------- | ---------- | ------------------------------ |
| month                  | integer    | null: false                    |
| earning                | integer    | null: false                    |
| labor_cost             | integer    | null: false                    |
| user                   | references | null: false, foreign_key: true |

### Association

belongs_to : user

