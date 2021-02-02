# README

# アプリケーション名
## SHIFT BOARD

### アプリケーション概要
 シフトの提出を行うことができます。
 また、その提出したシフト内容を表で閲覧できるアプリケーションです。
 その他に、会員登録機能、掲示板機能、画像投稿機能、掲示板確認ボタンなどがあります。

### URL

https://shift-board.herokuapp.com/


### 利用方法
 会員登録を行うことで、シフトの提出、閲覧が出来るようになります。
 掲示板機能で画像や文章を投稿することができます。

### 目指した課題解決
 シフト管理を行う際にアプリケーション上で管理をすることで
 シフトの作成の工数を減らし、業務の負担を軽減することを目的に作りました。
 人件費の計算や目標人件費に対しての差異を作成時に確認する事ができ、コスト管理をしやすくします。
 掲示板やチャット機能を使う事で、同じコミュニティ内でのコミュニケーションツールとしても役に立ちます。



### 実装予定の機能
オーナー権限機能
掲示板への、一言コメント機能
売上目標設定機能、人件費管理機能

### データベース設計


## users テーブル

| Column              | Type    | Options                |
| ------------------- | ------- | ---------------------- |
| name                | string  | null: false            |
| email               | string  | null: false,unique:true|
| encrypted_password  | string  | null: false            |

### Association

   has_many :tweets, dependent: :destroy
   has_many :likes, dependent: :destroy
   has_many :likes_posts, through: :like, source: :post
   has_many :projects

## tweet テーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| title               | string     | null: false                    |
| context             | text       | null: false                    |
| user                | references | null: false, foreign_key: true |



### Association

belongs_to :user
has_many :likes,  dependent: :destroy
has_many :liked_users, through: :likes, source: :user
has_one_attached :image,  dependent: :destroy

## like テーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| like_count          | string     |                                |
| tweet               | references | null: false, foreign_key: true |
| user                | references | null: false, foreign_key: true |

  belongs_to :tweet
  belongs_to :user

### Association

belongs_to : tweet
belongs_to : user


## project テーブル

| Column                 | Type       | Options                        |
| ---------------------- | ---------- | ------------------------------ |
| nicknname              | string     |                                |
| user                   | references | null: false, foreign_key: true |

  has_many :tasks
  belongs_to :user

## task テーブル

| Column                 | Type       | Options                        |
| ---------------------- | ---------- | ------------------------------ |
| start_time             | datetime   |                                |
| intime                 | datetime   |                                |
| outtime                | datetime   |                                |
| project                | references | null: false, foreign_key: true |

### Association

belongs_to : project

