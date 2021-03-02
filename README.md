# テーブル設計

## usersテーブル


| Column           | Type   | Options     |
| ---------------- | ------ | ----------- |
| nickname         | string | null: false |
| email            | string | null: false,unique:true |
| password         | string | null: false |
| name_family      | string | null: false |
| name_family_kana | string | null: false |
| name_first       | string | null: false |
| name_first_kana  | string | null: false |
| birth_year       | integer| null: false |
| birth_month      | integer| null: false |
| birth_day        | integer| null: false |

### アソシエーション
has_many :items
has_many :comments

## itemsテーブル


| Column           | Type      | Options     |
| ---------------- | --------- | ----------- |
| image            |           | null: false |
| string           | string    | null: false |
| text             | text      | null: false |
| category         | integer   | null: false |
| status           | integer   | null: false |
| shipping_fee     | integer   | null: false |
| shipping_area    | integer   | null: false |
| shipping_days    | integer   | null: false |
| price            | integer   | null: false |
| users            | references| foreign_key: true  |

### アソシエーション
belongs_to :users
has_one :purchase_record
has_many :comments

## shipping_informationテーブル

| Column           | Type      | Options     |
| ---------------- | --------- | ----------- |
| postal_code      | integer   | null: false |
| prefectures      | string    | null: false |
| municipality     | string    | null: false |
| address          | string    | null: false |
| building_name    | string    |             |
| phone_number     | integer   | null: false |
| purchase_record  | references| foreign_key: true |

### アソシエーション
belongs_to :purchase_record

## purchase_recordテーブル

| Column           | Type      | Options     |
| ---------------- | --------- | ----------- |
| buyer            | string    | null: false |
| items            | references| foreign_key: true |

### アソシエーション
has_one :purchase_record
belongs_to :items
has_many :comments

## commentsテーブル

| Column           | Type      | Options     |
| ---------------- | --------- | ----------- |
| text             | text      | null: false |
| users            | references| foreign_key: true |
| items            | references| foreign_key: true |

### アソシエーション
belongs_to :users
belongs_to :items
belongs_to :purchase_record