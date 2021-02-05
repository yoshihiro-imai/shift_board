# README

![1](https://user-images.githubusercontent.com/75416155/107018114-5cf92100-67e3-11eb-8a9b-9f5c89a99484.png)


### アプリケーション概要
 シフトの管理を行うことができるアプリケーションです。
 定期的にシフトを作成する必要があるかたの問題解決ができればと思い作成しました。
 ・ユーザー登録をすることでシフトの投稿、閲覧ができる。
 ・掲示板機能で、画像、テキストの投稿、いいねボタンを実装。

### URL

http://35.72.129.10/


### 利用方法
 シフトの提出、閲覧が出来ます。
 掲示板機能で画像や文章を投稿することができます。

### 目指した課題解決
 シフト管理を行う際に一つのアプリケーション内で管理をすることで
 シフトの作成の工数を減らし、業務の負担を軽減することを目的に作りました。
 1日のシフトをグラフ化して、一目でわかるシフト表を目指しました。
 掲示板やチャット機能を使う事で、同じコミュニティ内でのコミュニケーションツールとしても使うことができます。

### 実装した機能の説明
 ユーザー登録機能:ユーザーの登録をすることで利用ができます。
 掲示板機能:画像の投稿、テキストの投稿ができて、詳細ではいいねボタンを実装しました。

![いいね機能](https://user-images.githubusercontent.com/75416155/107020401-2bce2000-67e6-11eb-9a97-078152fd538c.gif)

 シフト投稿、閲覧機能:投稿されたシフトをカレンダー上で確認ができます。日にちごとに詳細も確認ができます。
 ![60460c8bc4208355e68caf35da268016](https://user-images.githubusercontent.com/75416155/107018483-d42eb500-67e3-11eb-8b20-3febf28b5106.gif)

### 工夫した部分
シフト投稿時のフォームをボタンで追加できる様にした点です。
部分テンプレートを用いて、必要な数だけフォームを増やし、同時に登録ができる様にしました。

### 苦労したところ
シフト表示の際に、特定の日にちに投稿した人だけを出力することです。
・2つのモデルを合わせて、特定の日にちを出力する際にjoinメゾットで、モデルを一つにし、そこからシフトに投稿した日付をwhereを用いて指定し表示させることができました。

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

<img width="583" alt="shift_boardER図" src="https://user-images.githubusercontent.com/75416155/107021185-30df9f00-67e7-11eb-9c68-f73fded605ac.png">
