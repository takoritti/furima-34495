# テーブル設計

## usersテーブル

| Column            | Type   | Options     |
| ----------------- | ------ | ----------- |
| nickname          | string | null: false |
| email             | string | null: false,unique:true |
| encrypted_password| string | null: false |
| name_family       | string | null: false |
| name_family_kana  | string | null: false |
| name_first        | string | null: false |
| name_first_kana   | string | null: false |
| birth_day_id      | date   | null: false |

### アソシエーション
has_many :items
has_many :comments
has_many :purchase_record

## itemsテーブル


| Column           | Type      | Options     |
| ---------------- | --------- | ----------- |
| name             | string    | null: false |
| information      | text      | null: false |
| category_id      | integer   | null: false |
| status_id        | integer   | null: false |
| shipping_fee_id  | integer   | null: false |
| prefecture_id    | integer   | null: false |
| shipping_days_id | integer   | null: false |
| price            | integer   | null: false |
| user             | references| foreign_key: true  |

### アソシエーション
belongs_to :user
has_one :purchase_record
has_many :comments

## shipping_informationテーブル

| Column           | Type      | Options     |
| ---------------- | --------- | ----------- |
| postal_code      | string    | null: false |
| prefecture_id    | integer   | null: false |
| municipality     | string    | null: false |
| address          | string    | null: false |
| building_name    | string    |             |
| phone_number     | string    | null: false |
| purchase_record  | references| foreign_key: true |

### アソシエーション
belongs_to :purchase_record

## purchase_recordテーブル

| Column           | Type      | Options     |
| ---------------- | --------- | ----------- |
| user             | references| foreign_key: true |
| item             | references| foreign_key: true |

### アソシエーション
has_one :purchase_record
belongs_to :item
has_many :comments
belongs_to :user

## commentsテーブル

| Column           | Type      | Options     |
| ---------------- | --------- | ----------- |
| text             | text      | null: false |
| user             | references| foreign_key: true |
| item             | references| foreign_key: true |

### アソシエーション
belongs_to :user
belongs_to :item
belongs_to :purchase_record